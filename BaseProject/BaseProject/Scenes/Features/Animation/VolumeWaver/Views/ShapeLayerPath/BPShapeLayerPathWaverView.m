//
//  BPShapeLayerPathWaverView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPShapeLayerPathWaverView.h"
#import "BPVolumeQueueHelper.h"
#import "CADisplayLink+BPAdd.h"

@interface BPShapeLayerPathWaverView ()<CAAnimationDelegate>
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) BPVolumeQueueHelper *volumeQueueHelper;
@property (nonatomic, assign) NSInteger waveNumber;
@property (nonatomic, assign) BOOL secondAnimation;
@property (nonatomic, strong) UIImageView *secondAnimationImageView;
@property (nonatomic, assign) BOOL delay;
@property (nonatomic,strong) CAShapeLayer *shapeLayer1;
@property (nonatomic,strong) CAShapeLayer *shapeLayer2;
@end

const static CGFloat voiceWaveDisappearDuration = 0.25;
const static NSInteger defaultWaveNumber = 2;
static NSRunLoop *_voiceWaveRunLoop;
static NSThread *_voiceWaveThread = nil;

@implementation BPShapeLayerPathWaverView {
    CGFloat _idleAmplitude;//idleAmplitude
    CGFloat _amplitude;//振幅:归一化振幅系数，与音量正相关
    CGFloat _density;//密度:x轴粒度
    CGFloat _waveHeight;
    CGFloat _waveWidth;
    CGFloat _waveMid;
    CGFloat _maxAmplitude;//最大振幅
    CGFloat _mainWaveWidth;//主波纹线宽，其他波纹是它的一半，也可自定义
    CGFloat _phase1;//阶段:firstLine相位
    CGFloat _phase2;//secondLine相位
    CGFloat _phaseShift1;//移相
    CGFloat _phaseShift2;
    CGFloat _frequency;//频率
    CGFloat _frequency1;//频率
    
    CGPoint _lineCenter1;
    CGPoint _lineCenter2;
    CGFloat _currentVolume;
    CGFloat _lastVolume;
    CGFloat _middleVolume;
    CGFloat _maxWidth;//波纹显示最大宽度
    CGFloat _beginX;//波纹开始坐标
    CGFloat _stopAnimationRatio;//松手后避免音量过大，波纹振幅大，乘以衰减系
    BOOL _isStopAnimating;//正在进行消失动画
    NSMutableArray<UIBezierPath *> *_waveLinePathArray;//存放贝塞尔曲线的数组
    NSLock *_lock;
}

#pragma mark - 初始化
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initSubLayers];
        [self initGesture];
        [self startVoiceWaveThread];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initSubLayers];
    [self initGesture];
    [self startVoiceWaveThread];
}

- (void)initSubLayers {
    self.shapeLayer1 = [CAShapeLayer layer];
    self.shapeLayer1.lineCap       = kCALineCapSquare;
    self.shapeLayer1.lineJoin      = kCALineJoinBevel;
    self.shapeLayer1.strokeColor   =  kGreenColor.CGColor;
    self.shapeLayer1.fillColor     = [kGreenColor CGColor];
    [self.shapeLayer1 setLineWidth:kOnePixel*1.5];
    [self.layer addSublayer:self.shapeLayer1];
    
    self.shapeLayer2 = [CAShapeLayer layer];
    self.shapeLayer2.lineCap       = kCALineCapSquare;
    self.shapeLayer2.lineJoin      = kCALineJoinBevel;
    UIColor *alphaColor1 = [kGreenColor colorWithAlphaComponent:0.5];
    self.shapeLayer2.strokeColor   =  alphaColor1.CGColor;
    self.shapeLayer2.fillColor     = [alphaColor1 CGColor];
    [self.shapeLayer2 setLineWidth:kOnePixel*0.5];
    [self.layer addSublayer:self.shapeLayer2];
}

- (void)initGesture {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesCallback:)];
    [self addGestureRecognizer:tap];
}

- (void)tapGesCallback:(UIGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(tapGesCallback)]) {
        [_delegate tapGesCallback];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _waveWidth  = CGRectGetWidth(self.bounds);
    _waveHeight = CGRectGetHeight(self.bounds);
    _waveMid    = _waveWidth / 2.0f;
    _maxAmplitude = _waveHeight * 0.5;//最大振幅
    NSInteger centerX = _waveWidth / 2;
    _lineCenter1 = CGPointMake(0, 0);
    _lineCenter2 = CGPointMake(centerX, 0);
    _maxWidth = _waveWidth + _density;
}

#pragma mark - 配置默认值
- (void)configDefaultValue {
    //a=Asin(2πft)　　A为振幅，f为频率，t为时间，a为瞬时值。
    _frequency = 3.0f;//频率，几个圆圈
    _frequency1 = 2.0f;//频率，几个圆圈
    _amplitude = 1.5f;//振幅
    _idleAmplitude = .15f;//闲置的振幅
    _phase1 = 0.0f;
    _phase2 = 0.0f;
    _phaseShift1 = -0.20f;//移相
    _phaseShift2 = -0.10f;//移相
    _density = 1.f;//密度
    _waveWidth = CGRectGetWidth(self.bounds);
    _waveHeight = CGRectGetHeight(self.bounds);
    _waveMid = _waveWidth / 2.0f;
    _maxAmplitude = _waveHeight * 0.5;//最大振幅
    NSInteger centerX = _waveWidth / 2;
    _lineCenter1 = CGPointMake(0, 0);
    _lineCenter2 = CGPointMake(centerX, 0);
    _maxWidth = _waveWidth + _density;
    _beginX = 0.0;
    _lastVolume = 0.0;
    _currentVolume = 0.0;
    _middleVolume = 0.05;
    _stopAnimationRatio = 1.0;
    [_volumeQueueHelper cleanQueue];
    _mainWaveWidth = kOnePixel * 1.5;
    _waveNumber = _waveNumber > 0 ? _waveNumber : defaultWaveNumber;
    _waveLinePathArray = [NSMutableArray array];
    _lock = [[NSLock alloc] init];
}

#pragma mark - 开启子线程准备进行异步绘制
- (NSThread *)startVoiceWaveThread {
    self.backgroundColor = kLightGrayColor;
    [self configDefaultValue];
    [self updateMeters];
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _voiceWaveThread =
        [[NSThread alloc] initWithTarget:self
                                selector:@selector(voiceWaveThreadEntryPoint:)
                                  object:nil];
        [_voiceWaveThread setName:@"bpVolumeWaver_thread"];
        [_voiceWaveThread start];
    });
    return _voiceWaveThread;
}

- (void)voiceWaveThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        if (_voiceWaveThread) {
            _voiceWaveRunLoop = [NSRunLoop currentRunLoop];
            [_voiceWaveRunLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
            [_voiceWaveRunLoop run];
        }
    }
}

#pragma mark - 开启定时器，开始进行波浪动画（通过时时更新异步绘制来实现的）
- (void)startVoiceWave {
    _delay = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.delay = YES;
    });
    if (_isStopAnimating) {
        return;
    }
    [self configDefaultValue];
    if (_voiceWaveRunLoop) {
        [self.displayLink invalidate];
        __weak typeof (self) weakSelf = self;
        self.displayLink = [CADisplayLink displayLinkWithRunLoop:_voiceWaveRunLoop executeBlock:^(CADisplayLink *displayLink) {
            [weakSelf updateMeters];
        }];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_voiceWaveRunLoop) {
                [self.displayLink invalidate];
                __weak typeof (self) weakSelf = self;
                self.displayLink = [CADisplayLink displayLinkWithRunLoop:_voiceWaveRunLoop executeBlock:^(CADisplayLink *displayLink) {
                    [weakSelf updateMeters];
                }];
            }
        });
    }
}

#pragma mark - 外部通过接口实现数据更新
- (void)changeVolume:(CGFloat)volume {
    @synchronized (self) {
        _lastVolume = _currentVolume;
        _currentVolume = volume;
#pragma mark - 获取y坐标
        NSArray *volumeArray = [self generatePointsOfSize:6 withPowFactor:1 fromStartY:_lastVolume toEndY:_currentVolume];
        [self.volumeQueueHelper pushVolumeWithArray:volumeArray];
    }
}

#pragma mark - 定时器方法：时时绘制：updateMeters
- (void)updateMeters {
    //BPLog(@"isMainThread1 %d",[NSThread isMainThread]);
    CGFloat volume = [self.volumeQueueHelper popVolume];
    if (volume > 0) {
        _middleVolume = volume;
    }
    _phase1 += _phaseShift1; // Move the wave
    _phase2 += _phaseShift2;
    _amplitude = fmax(_middleVolume, _idleAmplitude);
    if (_isStopAnimating) {
        _stopAnimationRatio = _stopAnimationRatio - 0.05;
        _stopAnimationRatio = fmax(_stopAnimationRatio, 0.01);
    }
    [_lock lock];
    [_waveLinePathArray removeAllObjects];
    CGFloat waveWidth = _mainWaveWidth;
    CGFloat progress = 1.0f;
    CGFloat amplitudeFactor = 1.0f;
    for (NSInteger i = 0; i < _waveNumber; i++) {
        waveWidth = i==0 ? _mainWaveWidth : _mainWaveWidth / 3.0;
        progress = 1.0f - (CGFloat)i / _waveNumber;
        amplitudeFactor = 1.5f * progress - 0.5f;
        amplitudeFactor = 1;
#pragma mark - 生成贝塞尔曲线
        if(i==0) {
            UIBezierPath *linePath = [self generatePathWithFrequency:_frequency maxAmplitude:_maxAmplitude * amplitudeFactor phase:_phase1 lineCenter:&_lineCenter1 yOffset:waveWidth / 2.0];
            if (linePath) {
                [_waveLinePathArray addObject:linePath];
            }
        }else {
            UIBezierPath *linePath = [self generatePathWithFrequency:_frequency1 maxAmplitude:_maxAmplitude * amplitudeFactor phase:_phase2 lineCenter:&_lineCenter2 yOffset:waveWidth / 2.0];
            if (linePath) {
                [_waveLinePathArray addObject:linePath];
            }
        }
    }
    [_lock unlock];
    [self configDrawPath];
}

#pragma mark - drawRect方法
- (void)configDrawPath {
    //绘制渐变
    [_lock lock];
    if (_waveLinePathArray.count == _waveNumber && _waveNumber > 0) {
        for (NSInteger i = 0; i < _waveNumber; i++) {
            CGPathRef path = _waveLinePathArray[i].CGPath;
            if (i==0) {
                self.shapeLayer1.path = path;
            }else {
                self.shapeLayer2.path = path;
                if (self.delay) {
                }
            }
        }
    }
    [_lock unlock];
}

#pragma mark - 生成贝塞尔曲线
- (UIBezierPath *)generatePathWithFrequency:(CGFloat)frequency maxAmplitude:(CGFloat)maxAmplitude phase:(CGFloat)phase lineCenter:(CGPoint *)lineCenter yOffset:(CGFloat)yOffset {
    // (-(2x-1)^2+1)sin (2pi*f*x)
    // (-(2x-1)^2+1)sin (2pi*f*x + 3.0)
    UIBezierPath *wavelinePath = [UIBezierPath bezierPath];
    CGFloat normedAmplitude = fmin(_amplitude, 1.0);
    if (_maxWidth < _density || _waveMid <= 0) {
        return nil;
    }
    CGFloat x = _beginX;
    CGFloat y = 0;
    for(; x<_maxWidth; x += _density) {
        CGFloat scaling = -pow(x / _waveMid  - 1, 2) + 1; // make center bigger
        y = scaling * maxAmplitude * normedAmplitude * _stopAnimationRatio * sinf(2 * M_PI *(x / _waveWidth) * frequency + phase) + (_waveHeight * 0.5 - yOffset);
        if (_beginX == x) {
            [wavelinePath moveToPoint:CGPointMake(x, y)];
        }
        else {
            [wavelinePath addLineToPoint:CGPointMake(x, y)];
        }
        if (fabs(lineCenter->x - x) < 0.01) {
            lineCenter->y = y;
        }
    }
    x = x - _density;
    [wavelinePath addLineToPoint:CGPointMake(x, y + 2 * yOffset)];
    for(; x>=_beginX; x -= _density) {
        CGFloat scaling = -pow(x / _waveMid  - 1, 2) + 1; // make center bigger
        y = scaling * maxAmplitude * normedAmplitude * _stopAnimationRatio * sinf(2 * M_PI *(x / _waveWidth) * frequency + phase) + (_waveHeight * 0.5 + yOffset);
        [wavelinePath addLineToPoint:CGPointMake(x, y)];
    }
    x = x + _density;
    [wavelinePath addLineToPoint:CGPointMake(x, y - 2 * yOffset)];
    return wavelinePath;
}

/**
 *  音量插值
 *
 *  @param size   插值返回音量个数(包含起始点、不包含末尾节点)
 *  @param factor 插值系数，(0~1 : 变化率从大到小  1~2 : 变化率从小到大)
 参考
 pow(x,0.2),pow(x,0.3),pow(x,0.4),pow(x,0.5),pow(x,0.6),pow(x,0.7),pow(x,0.8),pow(x,0.9)
 *  @param y1     起始插值音量，取值范围0~1
 *  @param y2     终止插值音量，取值范围0~1
 *
 *  @return 插值后音量数组
 */
- (NSArray *)generatePointsOfSize:(NSInteger)size withPowFactor:(CGFloat)factor fromStartY:(CGFloat)y1 toEndY:(CGFloat)y2 {
    BOOL factorValid = factor < 2 && factor > 0 && factor != 0;
    BOOL y1Valid = 0 <= y1 && y1 <= 1;
    BOOL y2Valid = 0 <= y2 && y2 <= 1;
    if (!(factorValid && y1Valid && y2Valid)) {
        return nil;
    }
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:size];
    CGFloat x1,x2;
    x1 = pow(y1,1/factor);
    x2 = pow(y2,1/factor);
    CGFloat pieceOfX = (x2 - x1) / size;
    CGFloat x,y;
    [mArray addObject:[NSNumber numberWithFloat:y1]];
    for (int i = 1; i < size; ++i) {
        x = x1 + pieceOfX * i;
        y = pow(x, factor);
        [mArray addObject:[NSNumber numberWithFloat:y]];
    }
    return [mArray copy];
}

#pragma mark - 停止波浪动画，并回调
- (void)stopVoiceWaveWithShowLoadingViewCallback:(BPShapeLayerPathWaverViewCallback)callback {
    if (_isStopAnimating) {
        return;
    }
    self.delay = NO;
    _isStopAnimating = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(voiceWaveDisappearDuration * 0.5  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        callback();
    });
}

#pragma mark - 第二动画部分
- (void)secondAnaimation {
    self.secondAnimationImageView.hidden = NO;
    if (self.secondAnimation) {
        self.secondAnimationImageView.image = [UIImage imageNamed:@"volumeWaverViewRight"];
        [self.secondAnimationImageView.layer addAnimation:[self pointTranslationWithFromValue:_waveWidth+48 toValue:0] forKey:@"imageView_transform.translation.right"];
    }else {
        self.secondAnimationImageView.image = [UIImage imageNamed:@"volumeWaverViewLeft"];
        [self.secondAnimationImageView.layer addAnimation:[self pointTranslationWithFromValue:0 toValue:_waveWidth+48] forKey:@"imageView_transform.translation.left"];
    }
}

- (void)stopSecondAnaimation {
    [self.secondAnimationImageView.layer removeAllAnimations];
    self.secondAnimationImageView.hidden = YES;
}

- (UIImageView *)secondAnimationImageView {
    if (!_secondAnimationImageView) {
        _secondAnimationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"volumeWaverViewLeft"]];
        [self addSubview:_secondAnimationImageView];
        [_secondAnimationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(self).offset(-48);
        }];
        //_secondAnimationImageView.frame = CGRectMake(-48, self.bounds.size.height/2.0-13/2.0, 48, 13);
    }
    return _secondAnimationImageView;
}

#pragma mark - CAAnimationDelegate
- (CABasicAnimation *)pointTranslationWithFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    anima.fromValue = [NSNumber numberWithFloat:fromValue];
    anima.toValue = [NSNumber numberWithFloat:toValue];
    anima.duration = 0.75f;
    anima.delegate = self;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    return anima;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        if (anim == [self.secondAnimationImageView.layer animationForKey:@"imageView_transform.translation.left"] ||anim == [self.secondAnimationImageView.layer animationForKey:@"imageView_transform.translation.right"]) {
            if (anim == [self.secondAnimationImageView.layer animationForKey:@"imageView_transform.translation.left"]) {
                if (_delegate && [_delegate respondsToSelector:@selector(allAnaimationFinish)]) {
                    [_delegate allAnaimationFinish];
                }
            }
            _secondAnimation = !_secondAnimation;
            [self secondAnaimation];
        }
    }
}

#pragma mark - 重新方法，防止循环引用
- (void)removeFromSuperview {
    [_displayLink invalidate];
    _displayLink = nil;
    [super removeFromSuperview];
}

#pragma mark - setter methods
#pragma mark - 设置波浪条数
- (void)setVoiceWaveNumber:(NSInteger)waveNumber {
    _waveNumber = waveNumber;
}

#pragma mark - getters
- (BPVolumeQueueHelper *)volumeQueueHelper {
    if (!_volumeQueueHelper) {
        self.volumeQueueHelper = [[BPVolumeQueueHelper alloc] init];
    }
    return _volumeQueueHelper;
}

- (void)dealloc {
    [_displayLink invalidate];
    _displayLink = nil;
    BPLog(@"BPVolumeWaverView_dealloc");
}

@end
