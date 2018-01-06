//
//  BPCircleView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/8/5.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPCircleView.h"
@interface BPCircleView()
@property (nonatomic,assign) BOOL showAnimation;

@end

static CGFloat radius = 85.0f;
static CGFloat shapeLayerW = 16.0f;
static CGFloat layerW = 186.0f;
static CGFloat layerH = 140.0f;

@implementation BPCircleView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configureAnimationViews];
    }
    return self;
}


#pragma mark - 油表进度动画
- (void)configureAnimationViews {
    //背景shapelayer
    self.backShapeLayer =[CAShapeLayer layer] ;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(layerW/2.0, layerW/2.0) radius:radius startAngle:M_PI * 0.85 endAngle:M_PI * 0.15 clockwise:YES];
    self.backShapeLayer.lineCap = kCALineCapRound;
    self.backShapeLayer.path = path.CGPath;
    
    self.backShapeLayer.fillColor = kClearColor.CGColor;
    self.backShapeLayer.lineWidth = shapeLayerW;
    
    UIColor *color = [kDarkGrayColor colorWithAlphaComponent:.1f];
    self.backShapeLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:self.backShapeLayer];
    
    //背景layer
    self.backLayer = [CALayer layer];
    self.backLayer.frame = CGRectMake(0, 0, layerW, layerH);
    [self.layer addSublayer:self.backLayer];
    
    //渐变层gradientLayer
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = CGRectMake(0, 0, layerW/2.0f, layerH);
    self.gradientLayer.startPoint = CGPointMake(0.5, 1.0);
    self.gradientLayer.endPoint = CGPointMake(0.5, 0);
    
    self.gradientLayer1 = [CAGradientLayer layer];
    self.gradientLayer1.frame = CGRectMake(layerW/2.0, 0, layerW/2.0, layerH);
    self.gradientLayer1.startPoint = CGPointMake(0.5, 0);
    self.gradientLayer1.endPoint = CGPointMake(0.5, 1);
    
    //maskShapeLayer & mask
    self.maskShapeLayer = [CAShapeLayer layer];
    self.maskShapeLayer.path = path.CGPath;
    self.maskShapeLayer.lineWidth = shapeLayerW;
    self.maskShapeLayer.fillColor = kClearColor.CGColor;
    self.maskShapeLayer.strokeColor = kRedColor.CGColor;
    self.maskShapeLayer.lineCap = kCALineCapRound;
    self.maskShapeLayer.path = path.CGPath;
    
//    [self.backLayer addSublayer:self.gradientLayer];
//    [self.backLayer addSublayer:self.gradientLayer1];
    //    self.backLayer.mask = self.maskShapeLayer;
    

}
- (void)setTotlaScore:(NSInteger)totalScore score:(NSInteger)score {
    if (_showAnimation) {
        return;
    }
    _showAnimation = YES;
    NSString *persent = [NSString stringWithFormat:@"%.2f",1.00*score/totalScore];
//    self.animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
//    self.animation.duration = 1.5;
//    self.animation.fromValue = @0;
//    self.animation.toValue = [NSNumber numberWithDouble:[persent doubleValue]];
//    
////    self.animation.removedOnCompletion = NO;
////    self.animation.fillMode = kCAFillModeForwards;
////    [self.maskShapeLayer addAnimation:self.animation forKey:nil];
    
    self.animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.animation.duration = 1.5;
    self.animation.fromValue = @0;
    self.animation.toValue = [NSNumber numberWithDouble:[persent doubleValue]];
    
    self.animation.removedOnCompletion = NO;
    self.animation.fillMode = kCAFillModeForwards;
    [self.backShapeLayer addAnimation:self.animation forKey:nil];
    
    CAKeyframeAnimation *colorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeColor"];
    colorAnimation.values               = @[(id)[kBlueColor CGColor],
                                            (id)[kYellowColor CGColor],
                                            (id)[kRedColor CGColor]];
    colorAnimation.duration             = 3.0;  // "animate over 3 seconds or so.."
    colorAnimation.repeatCount          = 1.0;  // Animate only once..
    colorAnimation.removedOnCompletion  = NO;   // Remain stroked after the animation..
    colorAnimation.fillMode             = kCAFillModeForwards;
//    colorAnimation.timingFunction       = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.backShapeLayer addAnimation:colorAnimation forKey:nil];

}

@end
