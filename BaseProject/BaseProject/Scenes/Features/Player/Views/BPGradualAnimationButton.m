//
//  BPGradualAnimationButton.m
//  WPSExcellentClass
//
//  Created by xiaruzhen on 2018/12/13.
//  Copyright © 2018 Kingsoft. All rights reserved.
//

#import "BPGradualAnimationButton.h"

@interface BPGradualAnimationButton ()
@property (nonatomic,weak) CALayer *animationLayer;
@property (nonatomic,weak) CAShapeLayer *shapeLayer;
@property (nonatomic,weak) CAGradientLayer *gradientLayer;
@end

static NSInteger size = 38;

@implementation BPGradualAnimationButton

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    CALayer *animationLayer = [CALayer layer];
    _animationLayer = animationLayer;
    UIColor *themeColor = kThemeColor;
    animationLayer.backgroundColor = themeColor.CGColor; //圆环底色
    CGRect frame = CGRectMake(-3, -3, size, size);

    animationLayer.frame = frame;
    //创建一个圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2.0, frame.size.height/2.0) radius:frame.size.width/2.0-2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    _shapeLayer = shapeLayer;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = themeColor.CGColor;
    shapeLayer.lineWidth = 2;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 0.7;
    shapeLayer.lineCap = @"round";
    shapeLayer.lineDashPhase = 0.7;
    shapeLayer.path = bezierPath.CGPath;
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)themeColor.CGColor,(id)[UIColor whiteColor].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    _gradientLayer = gradientLayer;
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(frame.size.width/2.0-5, frame.size.width/2.0-5, frame.size.width/2.0+5, frame.size.width/2.0+5);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    
    [animationLayer addSublayer:gradientLayer]; //设置颜色渐变
    [animationLayer setMask:shapeLayer]; //设置圆环遮罩
    [self.layer addSublayer:animationLayer];
    
    [self stopLoading];
}

- (void)startLoading {
    [self stopLoading];
    _animationLayer.hidden = NO;
    _shapeLayer.hidden = NO;
    /*
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    //scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.duration = 0.8;
    */
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.beginTime = 0.0;
    rotationAnimation.duration = 2;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.repeatCount = HUGE;
    rotationAnimation.removedOnCompletion = NO;//进入后台后，再回到前台，防止动画停止
    [_animationLayer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopLoading {
    [_animationLayer removeAllAnimations];
    _animationLayer.hidden = YES;
    _shapeLayer.hidden = YES;
}

@end
