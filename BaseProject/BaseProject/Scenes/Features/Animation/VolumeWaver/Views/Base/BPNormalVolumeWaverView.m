//
//  BPNormalVolumeWaverView.m
//  BaseProject
//
//  Created by Ryan on 2018/2/3.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNormalVolumeWaverView.h"

@interface BPNormalVolumeWaverView ()
@property (nonatomic,strong) CAShapeLayer *shapeLayer1;
@property (nonatomic,strong) CAShapeLayer *shapeLayer2;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat phase;
@property (nonatomic, assign) CGFloat stopOffset;
@end

@implementation BPNormalVolumeWaverView {
    dispatch_queue_t queue;
}

/*
 
 几个需求点：
 1. 是否标准曲线；
 2. 整个曲线的Y值中心，k；
 3. 最高点到centerY的距离
 4. 一个屏幕出现几个周期
 5. 开始点在哪里，尾点在哪里
 6. 结束的时候成什么样的曲线
 7. 循环引用问题及内存cpu问题
 8. 支持autolayout
 9.扩展功能：水波纹动画
 10. button的重复点击
 11. afn的缓存及重试
 12. init及更多init方法
 */

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initLayer];
    }
    return self;
}

- (void)initLayer {
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    self.shapeLayer1 = [CAShapeLayer layer];
    self.shapeLayer1.lineCap       = kCALineCapButt;
    self.shapeLayer1.lineJoin      = kCALineJoinRound;
    self.shapeLayer1.strokeColor   = [kClearColor CGColor];
    self.shapeLayer1.fillColor     = [kClearColor CGColor];
    [self.shapeLayer1 setLineWidth:3];
    self.shapeLayer1.strokeColor   =  kRedColor.CGColor;
    [self.layer addSublayer:self.shapeLayer1];
    self.shapeLayer1.path = [self creatPath].CGPath;
    
    self.shapeLayer2 = [CAShapeLayer layer];
    self.shapeLayer2.lineCap       = kCALineCapButt;
    self.shapeLayer2.lineJoin      = kCALineJoinRound;
    self.shapeLayer2.strokeColor   = [kClearColor CGColor];
    self.shapeLayer2.fillColor     = [kClearColor CGColor];
    [self.shapeLayer2 setLineWidth:kOnePixel*3];
    self.shapeLayer2.strokeColor   =  kGreenColor.CGColor;
    //    [self.layer addSublayer:self.shapeLayer2];
    //    self.shapeLayer2.path = [self creatPath].CGPath;
    
    //自定义串行串行队列
    queue = dispatch_queue_create("com.test.gcd", DISPATCH_QUEUE_SERIAL);
}

- (void)update {
    self.phase -= 0.1;
    //异步任务1加入串行队列中
    dispatch_sync(queue, ^{
        self.shapeLayer1.path = [self creatPathWithValue:self.value].CGPath;
    });
}

- (void)setStop:(BOOL)stop {
    _stop = stop;
    self.stopOffset = 15;
}

- (void)setValue:(CGFloat)value {
    _value = value;
}

- (UIBezierPath *)creatPathWithValue:(CGFloat)value {
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat height = 60;
    CGFloat width = kScreenWidth;
#pragma mark 标准参数及用法
    CGFloat A =  height/2.0 ;
    
    CGFloat frequency = 2.0f;//一个周期，数字是几，相当于，屏幕里有几个这样的曲线
    CGFloat ω =  frequency * 2 * M_PI;//控制周期大小,当等于2 *M_PI屏幕里出现一个完整的，4 * M_PI出现两个，可以改变
    
    CGFloat phase = 0.f;//如果是‘-’，表示向右偏移，正数表示向左偏移
    CGFloat φ = phase;//向左或者向右移动的单位，可以改变
    
    CGFloat k = height / 2.0; //整个椭圆坐标的Y值。固定不变
    
    CGFloat waveMid = width / 2.0f;
    CGFloat normedAmplitude = 1.0;
#pragma mark 自定义参数
    A =  height/2.0 * value;
    if (A<15) {
        A = 15;
    }
    
    if (self.stop) {
        A =  (self.stopOffset -= 0.5);
        if (A<=0) {
            A = 0;
            [self.displayLink invalidate];
            self.displayLink = nil;
        }
    }
    
    φ = self.phase;
    for(CGFloat x = 0; x < width; x++) {
        CGFloat scaling = -pow(x / waveMid - 1, 2) + 1; // make center bigger
        //NSInteger A = scaling * height/2.0 * normedAmplitude ;//决定
        CGFloat y = A * sinf(ω *(x / width) + φ) + k;
        if (x == 0) {
            //            [path moveToPoint:CGPointMake(0, height/2.0)];
            [path moveToPoint:CGPointMake(0, y)];
        }
        else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    return path;
}

- (UIBezierPath *)creatPath {
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    /*
     正弦型函数解析式：y = Asin(ωx+φ)+k
     各常数值对函数图像的影响：
     A：振幅，决定峰值，决定最高位和最低位的顶点Y值
     ω：角速度,用于控制周期大小，单位x中起伏的个数（最小正周期 T = 2π / ω ）
     φ：初相,向左或者向右移动的单位
     k：偏距,表示波形在Y轴的位置关系
     */
    
    CGFloat height = 60;
    CGFloat width = kScreenWidth;
    
    CGFloat frequency = 2.0f;//一个周期，数字是几，相当于，屏幕里有几个这样的曲线
    NSInteger ω =  frequency * 2 * M_PI;//控制周期大小,当等于2 *M_PI屏幕里出现一个完整的，4 * M_PI出现两个，可以改变
    
    CGFloat phase = -50.f;//如果是‘-’，表示向右偏移，正数表示向左偏移
    NSInteger φ = phase;//向左或者向右移动的单位，可以改变
    
    NSInteger k = height / 2.0; //整个椭圆坐标的Y值。固定不变
    
    CGFloat waveMid = width / 2.0f;
    CGFloat normedAmplitude = 1.0;
    
    NSInteger A =  height/2.0 ;
    
    for(CGFloat x = 0; x < width; x++) {
        
        CGFloat scaling = -pow(x / waveMid - 1, 2) + 1; // make center bigger
        NSInteger A = scaling * height/2.0 * normedAmplitude ;//决定
        
        
        //        CGFloat y =  height/2.0 * sinf(ω *(x / width)  + φ) + k;
        
        //        CGFloat y =  (height-10)/2.0 * sinf(ω *(x / width) + φ) + k;
        
        CGFloat y = A * sinf(ω *(x / width) + φ) + k;
        if (x == 0) {
            //[path moveToPoint:CGPointMake(0, height/2.0)];
            [path moveToPoint:CGPointMake(0, y)];
        }
        else {
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }
    return path;
}

@end
