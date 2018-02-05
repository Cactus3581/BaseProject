//
//  BPDrawWaverView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDrawWaverView.h"

#import "KSVolumeQueueHelper.h"

@interface BPDrawWaverView ()<CAAnimationDelegate>
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) KSVolumeQueueHelper *volumeQueueHelper;
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

@implementation BPDrawWaverView {
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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initLayer];
        [self startVoiceWaveThread];
    }
    return self;
}

- (void)initLayer {
    

    
    self.shapeLayer1 = [CAShapeLayer layer];
    self.shapeLayer1.lineCap       = kCALineCapSquare;
    self.shapeLayer1.lineJoin      = kCALineJoinBevel;
    self.shapeLayer1.strokeColor   =  kGreenColor.CGColor;
    self.shapeLayer1.fillColor     = [[UIColor clearColor] CGColor];
    [self.shapeLayer1 setLineWidth:kOnePixel*3];
    [self.layer addSublayer:self.shapeLayer1];
    
    self.shapeLayer2 = [CAShapeLayer layer];
    self.shapeLayer2.lineCap       = kCALineCapSquare;
    self.shapeLayer2.lineJoin      = kCALineJoinBevel;
    self.shapeLayer2.strokeColor   =  kGreenColor.CGColor;
    self.shapeLayer2.fillColor     = [[UIColor clearColor] CGColor];
    [self.shapeLayer2 setLineWidth:kOnePixel];
    [self.layer addSublayer:self.shapeLayer2];

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
    //    a=Asin(2πft)　　A为振幅，f为频率，t为时间，a为瞬时值。
    _frequency = 2.0f;//频率，几个圆圈
    _amplitude = 1.3f;//振幅
    _idleAmplitude = .15f;//闲置的振幅
    _phase1 = 0.0f;
    _phase2 = 0.0f;
    _phaseShift1 = -0.22f;//移相
    _phaseShift2 = -0.11f;//移相
    _density = 1.f;//密度
    _waveWidth  = CGRectGetWidth(self.bounds);
    _waveHeight = CGRectGetHeight(self.bounds);
    _waveMid    = _waveWidth / 2.0f;
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
    _mainWaveWidth = kOnePixel*3;
    _waveNumber = _waveNumber > 0 ? _waveNumber : defaultWaveNumber;
    _waveLinePathArray = [NSMutableArray array];
    _lock = [[NSLock alloc] init];
}

#pragma mark - 开启子线程准备进行异步绘制
- (NSThread *)startVoiceWaveThread {
    self.backgroundColor = kWhiteColor;
    [self configDefaultValue];
    [self updateMeters];
    static NSThread *_voiceWaveThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _voiceWaveThread =
        [[NSThread alloc] initWithTarget:self
                                selector:@selector(voiceWaveThreadEntryPoint:)
                                  object:nil];
        [_voiceWaveThread start];
    });
    return _voiceWaveThread;
}

- (void)voiceWaveThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"bpVolumeWaver_thread"];
        _voiceWaveRunLoop = [NSRunLoop currentRunLoop];
        [_voiceWaveRunLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [_voiceWaveRunLoop run];
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
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
        [self.displayLink addToRunLoop:_voiceWaveRunLoop forMode:NSRunLoopCommonModes];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_voiceWaveRunLoop) {
                [self.displayLink invalidate];
                __weak typeof (self) weakSelf = self;
                self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
                [self.displayLink addToRunLoop:_voiceWaveRunLoop forMode:NSRunLoopCommonModes];
            }
        });
    }
}

#pragma mark - 定时器方法：时时绘制
- (void)invokeWaveCallback {
    [self updateMeters];
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
    BPLog(@"isMainThread1 %d",[NSThread isMainThread]);
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
            UIBezierPath *linePath = [self generatePathWithFrequency:_frequency maxAmplitude:_maxAmplitude * amplitudeFactor phase:_phase2 lineCenter:&_lineCenter2 yOffset:waveWidth / 2.0];
            if (linePath) {
                [_waveLinePathArray addObject:linePath];
            }
        }
    }
    [_lock unlock];
    [self customDraw];
}

#pragma mark - drawRect方法
- (void)customDraw {
    //绘制渐变
    [_lock lock];
    if (_waveLinePathArray.count == _waveNumber && _waveNumber > 0) {
        for (NSInteger i = 0; i < _waveNumber; i++) {
            CGPathRef path = _waveLinePathArray[i].CGPath;


            
            if (i==0) {
                
                self.shapeLayer1.path = path;


            }else {

                if (self.delay) {
                    self.shapeLayer2.path = path;
                }
            }
        }
    }
    [_lock unlock];
}

- (void)drawLine:(CGContextRef)context path:(CGPathRef)path color:(CGColorRef)color {
    CGContextSetLineJoin(context, kCGLineJoinBevel);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
}

#pragma mark - 生成贝塞尔曲线
- (UIBezierPath *)generatePathWithFrequency:(CGFloat)frequency maxAmplitude:(CGFloat)maxAmplitude phase:(CGFloat)phase lineCenter:(CGPoint *)lineCenter yOffset:(CGFloat)yOffset {
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

#pragma mark - getters
- (KSVolumeQueueHelper *)volumeQueueHelper {
    if (!_volumeQueueHelper) {
        self.volumeQueueHelper = [[KSVolumeQueueHelper alloc] init];
    }
    return _volumeQueueHelper;
}


@end

