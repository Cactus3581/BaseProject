//
//  BPVolumeWaverView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPVolumeWaverView.h"
#import "CADisplayLink+BPAdd.h"

@interface BPVolumeWaverView ()
@property (nonatomic,strong) CAShapeLayer *shapeLayer1;
@property (nonatomic,strong) CAShapeLayer *shapeLayer2;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat phase;
@property (nonatomic, assign) CGFloat lastValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat currentA;
@property (nonatomic,copy,nullable)  dispatch_block_t callback;
@property (nonatomic, assign) BOOL stop;
@property (nonatomic, strong) NSThread *thread;//常驻线程
@end

static NSRunLoop *_voiceWaveRunLoop;
static NSThread *_voiceWaveThread = nil;
/*
 1. 开辟子线程的问题
 2. 卡的原因
 3. 起始点的位置
 */

@implementation BPVolumeWaverView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLayer];
        [self startVoiceWaveThread];
    }
    return self;
}

#pragma mark - 开启子线程准备进行异步绘制
- (NSThread *)startVoiceWaveThread {
    static NSThread *_voiceWaveThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _voiceWaveThread =
        [[NSThread alloc] initWithTarget:self
                                selector:@selector(voiceWaveThreadEntryPoint:)
                                  object:nil];
        [_voiceWaveThread setName:@"bPVolumeWaver_thread"];
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
    if (_voiceWaveRunLoop) {
        [self.displayLink invalidate];
        __weak typeof (self) weakSelf = self;
        self.displayLink = [CADisplayLink displayLinkWithRunLoop:_voiceWaveRunLoop executeBlock:^(CADisplayLink *displayLink) {
            [weakSelf update];
        }];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_voiceWaveRunLoop) {
                [self.displayLink invalidate];
                __weak typeof (self) weakSelf = self;
                self.displayLink = [CADisplayLink displayLinkWithRunLoop:_voiceWaveRunLoop executeBlock:^(CADisplayLink *displayLink) {
                    [weakSelf update];
                }];
            }
        });
    }
}

- (void)initLayer {
    [self initGesture];
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


- (void)update {
    self.phase -= 0.1;
//    if (self.stop) {
//        self.phase -= 0.05;//改变横向速度
//    }else {
//        self.phase -= 0.1;
//    }
    BPLog(@"isMainThread %d",[NSThread isMainThread]);
    self.shapeLayer1.path = [self creatPathWithValue:self.value frequency:2.00f].CGPath;
    self.shapeLayer2.path = [self creatPathWithValue:self.value frequency:3.00f].CGPath;
}

- (void)setValue:(CGFloat)value {
    _value = value;
}

- (UIBezierPath *)creatPathWithValue:(CGFloat)value frequency:(CGFloat)frequency {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = 60.00;
    CGFloat width = kScreenWidth;
    
    CGFloat midH =  height / 2.00;
#pragma mark 标准参数及用法
    //frequency;//一个周期，数字是几，相当于，屏幕里有几个这样的曲线
    CGFloat ω =  frequency * 2 * M_PI;//控制周期大小,当等于2 *M_PI屏幕里出现一个完整的，4 * M_PI出现两个，可以改变
    CGFloat k = midH; //整个椭圆坐标的Y值。固定不变
    
#pragma mark 自定义参数
    CGFloat A =  midH * value ;
    CGFloat waveMid = width / 2.00f;
    
    CGFloat φ = self.phase;
    
    self.minValue = 10.00;
    
    //先判断是否小于最小值
    if (A<self.minValue) {
        A = self.minValue;
    }
    
    self.currentA = A;
    
    //再判断是否停止，从停止的value开始计算
    if (self.stop) {
        A =  (self.lastValue -= 0.50);
        if (A<=0) {
            A = 0;
            if (self.callback) {
//                self.callback();
            }
        }
    }
    for(CGFloat x = 0; x < width; x++) {

//    for(CGFloat x = 0; x < width; x+=0.1) {
        CGFloat scaling = -pow(x / waveMid - 1, 2) + 1; // 0-1之间,先从0加到1，再从1减到0
        CGFloat a =  A * scaling;
        CGFloat y = a  * sinf(ω *(x / width) + φ) + k;
        if (x == 0) {
            [path moveToPoint:CGPointMake(x, y)];
            BPLog(@"%.2f,%.2f",x,y);
        }
        else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    return path;
}

- (void)stopVoiceWaveWithCallback:(dispatch_block_t)callback {
    self.lastValue = self.currentA;
    _stop = YES;
    _callback = callback;
}

/**
 *  开始第二部分动画
 */
- (void)secondAnaimation {
    
}

- (void)initGesture {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesCallback:)];
    [self addGestureRecognizer:tap];
}

- (void)tapGesCallback:(UIGestureRecognizer *)gestureRecognizer {
    if (_delegate && [_delegate respondsToSelector:@selector(tapGesCallback)]) {
        [_delegate tapGesCallback];
    }
}

- (void)removeFromSuperview {
    [_displayLink invalidate];
    _displayLink = nil;
    [super removeFromSuperview];
}

@end
