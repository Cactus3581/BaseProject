//
//  BPVolumeWaverView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPVolumeWaverView.h"
#import "BPVolumeQueueHelper.h"

@interface BPVolumeWaverView ()<CAAnimationDelegate>
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) BPVolumeQueueHelper *volumeQueueHelper;
@property (nonatomic, assign) NSInteger waveNumber;
@end

const static CGFloat voiceWaveDisappearDuration = 0.25;
const static NSInteger defaultWaveNumber = 2;
static NSRunLoop *_voiceWaveRunLoop;

@implementation BPVolumeWaverView {
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
    
    CGFloat _stopAnimationRatio;//松手后避免音量过大，波纹振幅大，乘以衰减系数
    
    BOOL _isStopAnimating;//正在进行消失动画

    NSMutableArray<UIBezierPath *> *_waveLinePathArray;
    NSLock *_lock;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //[self startVoiceWaveThread];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self startVoiceWaveThread];
    }
    return self;
}

- (void)setup {
    _frequency = 3.0f;//频率
    _amplitude = 1.0f;//振幅
    _idleAmplitude = 0.05f;//闲置的振幅
    
    _phase1 = 0.0f;
    _phase2 = 0.0f;
    _phaseShift1 = -0.22f;//移相
    _phaseShift2 = -0.2194f;//移相
    _density = 1.f;//密度
    
    _waveHeight = CGRectGetHeight(self.bounds);
    _waveWidth  = CGRectGetWidth(self.bounds);
    _waveMid    = _waveWidth / 2.0f;
    _maxAmplitude = _waveHeight * 0.5;//最大振幅
    
    NSInteger centerX = _waveWidth / 2;
    _lineCenter1 = CGPointMake(centerX, 0);
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

- (NSThread *)startVoiceWaveThread {
    self.backgroundColor = [UIColor lightGrayColor];
    [self setup];
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
        [[NSThread currentThread] setName:@"com.ysc.VoiceWave"];
        _voiceWaveRunLoop = [NSRunLoop currentRunLoop];
        [_voiceWaveRunLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [_voiceWaveRunLoop run];
    }
}

- (void)setVoiceWaveNumber:(NSInteger)waveNumber {
    _waveNumber = waveNumber;
}

- (void)startVoiceWave {
    if (_isStopAnimating) {
        return;
    }
    [self setup];
    if (_voiceWaveRunLoop) {
        [self.displayLink invalidate];
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
        [self.displayLink addToRunLoop:_voiceWaveRunLoop forMode:NSRunLoopCommonModes];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_voiceWaveRunLoop) {
                [self.displayLink invalidate];
                self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
                [self.displayLink addToRunLoop:_voiceWaveRunLoop forMode:NSRunLoopCommonModes];
            }
        });
    }
}

- (void)stopVoiceWaveWithShowLoadingViewCallback:(YSCShowLoadingCircleCallback)showLoadingCircleCallback {
    if (_isStopAnimating) {
        return;
    }
    _isStopAnimating = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(voiceWaveDisappearDuration * 0.5  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        showLoadingCircleCallback();
    });
}


- (void)secondAnaimation {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"volumeWaverView"]];
    [self addSubview:imageView];
    imageView.frame = CGRectMake(0, 0, 0, 0);
    
//    CABasicAnimation
}

- (void)changeVolume:(CGFloat)volume {
    @synchronized (self) {
        _lastVolume = _currentVolume;
        _currentVolume = volume;
        NSArray *volumeArray = [self generatePointsOfSize:6 withPowFactor:1 fromStartY:_lastVolume toEndY:_currentVolume];
        [self.volumeQueueHelper pushVolumeWithArray:volumeArray];
    }
}

- (void)removeFromSuperview {
    [_displayLink invalidate];
    [super removeFromSuperview];
}

- (void)invokeWaveCallback {
    [self updateMeters];
}

- (void)updateMeters {
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
        waveWidth = i==0 ? _mainWaveWidth : _mainWaveWidth / 2.0;
        progress = 1.0f - (CGFloat)i / _waveNumber;
        amplitudeFactor = 1.5f * progress - 0.5f;
        UIBezierPath *linePath = [self generateGradientPathWithFrequency:_frequency maxAmplitude:_maxAmplitude * amplitudeFactor phase:_phase1 lineCenter:&_lineCenter1 yOffset:waveWidth / 2.0];
        [_waveLinePathArray addObject:linePath];
    }
    [_lock unlock];
    [self performSelectorOnMainThread:@selector(updateShapeLayerPath:) withObject:nil waitUntilDone:NO];
}

- (void)updateShapeLayerPath:(NSDictionary *)dic {
    [self setNeedsDisplay];
}

#pragma mark - CAAnimationDelegate
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    static NSInteger offset = 0;
    CGFloat colorOffset = sin(M_PI * fmod(offset++, 255.0) / 255.0);
    UIColor *startColor = kGreenColor;
    UIColor *endColor = kGreenColor;
    //绘制渐变
    [_lock lock];
    CGFloat progress = 1.0f;
    if (_waveLinePathArray.count == _waveNumber && _waveNumber > 0) {
        for (NSInteger i = 0; i < _waveNumber; i++) {
            progress = 1.0f - (CGFloat)i / _waveNumber;
            CGFloat multiplier = MIN(1.0, (progress / 3.0f * 2.0f) + (1.0f / 3.0f));
            CGFloat colorFactor = i == 0 ? 1.0 : 1.0 * multiplier * 0.4;
            endColor = [UIColor colorWithRed:0.0/255.0 green:1 - colorOffset blue:0.0/255.0 alpha:colorFactor];
            [self drawLinearGradient:context path:_waveLinePathArray[i].CGPath startColor:startColor.CGColor endColor:endColor.CGColor];
        }
    }
    [_lock unlock];
}

- (void)drawLinearGradient:(CGContextRef)context path:(CGPathRef)path startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0);
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (UIBezierPath *)generateGradientPathWithFrequency:(CGFloat)frequency maxAmplitude:(CGFloat)maxAmplitude phase:(CGFloat)phase lineCenter:(CGPoint *)lineCenter yOffset:(CGFloat)yOffset {
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

#pragma mark - getters
- (BPVolumeQueueHelper *)volumeQueueHelper {
    if (!_volumeQueueHelper) {
        self.volumeQueueHelper = [[BPVolumeQueueHelper alloc] init];
    }
    return _volumeQueueHelper;
}

- (void)dealloc {
    [_displayLink invalidate];
}

@end
