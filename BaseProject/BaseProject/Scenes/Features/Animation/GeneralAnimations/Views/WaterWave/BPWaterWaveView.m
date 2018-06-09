//
//  BPWaterWaveView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/7/14.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPWaterWaveView.h"

@interface BPWaterWaveView () {
    CGFloat _waveHeight; // 水纹高度
    CGFloat _offSet;
    CGFloat _changePercent;
}
@property (nonatomic,strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic,strong) CAShapeLayer *secondWaveLayer;
@property (nonatomic,strong) CADisplayLink *displayLink;
@end

@implementation BPWaterWaveView
+ (instancetype)waterWaveView {
    BPWaterWaveView *view = [[BPWaterWaveView alloc]init];
    view.backgroundColor = kWhiteColor;
    return view;
}

- (void)layoutSubviews {
    [self setDefaultProperty];
    [self layoutWaveLayers];
}

#pragma mark - 圆环图片赋值
/*
- (void)drawRect:(CGRect)rect {
    UIImage *cycleImage = [UIImage imageNamed:@"waterWave_cycleBorder"];
    [cycleImage drawInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
}
 */

#pragma mark - 开始动画
- (void)startWave {
    if (_displayLink == nil) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkAction)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - 停止动画
- (void)stopWave {
    _changePercent = 0.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_displayLink invalidate];
        _displayLink = nil;
    });
}

#pragma mark - 添加水波纹Layer
- (void)layoutWaveLayers {
    if (!self.firstWaveColor ) self.firstWaveColor = kFIRSTWAVE_DEFAULT_COLOR;
    if (!self.secondWaveColor) self.secondWaveColor = kSECONDEWAVE_DEFAULT_COLOR;
    
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_firstWaveLayer];
    }
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        [self.layer addSublayer:_secondWaveLayer];
    }
    _firstWaveLayer.strokeColor = self.firstWaveColor.CGColor;
    _secondWaveLayer.strokeColor = self.secondWaveColor.CGColor;
}

#pragma mark - 定时器事件
- (void)displayLinkAction {
    _offSet -= _speed;
    [self percentChange];
    // 正弦曲线
    CGMutablePathRef sinPath = [self pathWithCurveType:kCurveTypeSin];
    _firstWaveLayer.path = sinPath;
    CGPathRelease(sinPath);
    
    // 余弦曲线
    CGMutablePathRef cosPath = [self pathWithCurveType:kCurveTypeCos];
    _secondWaveLayer.path = cosPath;
    CGPathRelease(cosPath);
}

#pragma mark - 通过改变percent的值实现动画效果
- (void)percentChange {
    if (_changePercent > _percent) {// 当定时器改变的值(_changePercent)大于设定的值(_percent)时停止变化【注意:不可以使用等于号】
        _changePercent -= 0.005;
    }
}

#pragma mark  通过曲线类型获得对应的曲线路径
- (CGMutablePathRef)pathWithCurveType:(mCurveType)curveType {
    _waveHeight = (1 - _changePercent) * self.bounds.size.height;
    CGMutablePathRef mutablePath = CGPathCreateMutable();
    CGPathMoveToPoint(mutablePath, nil, 0, _waveHeight);
    CGFloat y;
    for (CGFloat x = 0.0f; x < self.bounds.size.width; x++) {
        switch (curveType) {
            case 0:
                y = _peak * sin(_period * M_PI / self.bounds.size.width * x + _offSet) + _waveHeight;
                break;
            case 1:
                y = _peak * cos(_period * M_PI / self.bounds.size.width * x + _offSet) + _waveHeight;
                break;
                
            default:
                break;
        }
        CGPathAddLineToPoint(mutablePath, nil, x, y);
    }
    CGPathAddLineToPoint(mutablePath, nil, self.bounds.size.width, self.bounds.size.height);
    CGPathAddLineToPoint(mutablePath, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(mutablePath);
    return mutablePath;
}

#pragma mark - 设置默认值
- (void)setDefaultProperty {
    // 设置默认值
    _waveHeight = self.bounds.size.height;
    _speed = kWATERWAVE_DEFAULT_SPEED;
    _peak = kWATERWAVE_DEFAULT_PEAK;
    _period = kWATERWAVE_DEFAULT_PERIOD;
}

#pragma mark - Configue propery
- (void)setPercent:(CGFloat)percent {
    NSAssert(percent >= 0.0f && percent <= 1, @"水波纹完成比例不得小于0或大于1!");
    _percent = percent;
}

- (void)setSpeed:(CGFloat)speed {
    NSAssert(speed >= 0, @"水波纹横向移动速度不得小于0!");
    _speed = speed;
}

- (void)setPeak:(CGFloat)peak {
    NSAssert(peak >= 0, @"水波纹峰值不得小于0!");
    _peak = peak;
}

- (void)setPeriod:(CGFloat)period {
    NSAssert(period > 0, @"水波纹周期数必须大于0!");
    _period = period;
}

@end
