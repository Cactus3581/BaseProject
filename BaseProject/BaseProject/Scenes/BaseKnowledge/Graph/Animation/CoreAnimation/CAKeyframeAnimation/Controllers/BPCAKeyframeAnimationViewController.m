//
//  BPCAKeyframeAnimationViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/8/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCAKeyframeAnimationViewController.h"

@interface BPCAKeyframeAnimationViewController ()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *animationView;

@end


@implementation BPCAKeyframeAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self airplane];
            }
                break;
                
            case 1:{
                [self secondAnimation];
            }
                break;
                
            case 2:{
                [self path];
            }
                break;
                
            case 3:{
                [self values];
            }
                break;       
        }
    }
}

#pragma mark - 飞机动画
- (void)airplane {
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(10, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];

    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"airplane"].CGImage;
    [self.view.layer addSublayer:shipLayer];

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.autoreverses = YES;
    [shipLayer addAnimation:animation forKey:nil];
}

#pragma mark - 自由落体动画
- (void)secondAnimation {
    
    UIView *ballView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    ballView.backgroundColor = kThemeColor;
    [self.view addSubview:ballView];
    ballView.center = CGPointMake(150, 32);

    // 设置动画参数
    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(150, 32)];
    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(150, 268)];
    CFTimeInterval duration = 1.0;
    
    //generate keyframes
    NSInteger numFrames = duration * 60;
    NSMutableArray *frames = [NSMutableArray array];
    for (int i = 0; i < numFrames; i++) {
        float time = 1/(float)numFrames * i;
        //apply easing
        time = bounceEaseOut(time);
        //add keyframe
        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
    }
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = frames;
    
    //apply animation
    [ballView.layer addAnimation:animation forKey:nil];
}

float bounceEaseOut(float t) {
    if (t < 4/11.0) {
        return (121 * t * t)/16.0;
    } else if (t < 8/11.0) {
        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    } else if (t < 9/10.0) {
        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    }
    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time {
    if ([fromValue isKindOfClass:[NSValue class]]) {
        //get type
        const char *type = [fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolate(from.x, to.x, time), interpolate(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    //provide safe default implementation
    return (time < 0.5)? fromValue: toValue;
}

float interpolate(float from, float to, float time) {
    return (to - from) * time + from;
}

#pragma mark - path

- (void)path {
    //view没动。她的layer在动。
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    anima.beginTime = CACurrentMediaTime() + 1.0;
    anima.duration = 4.0f;
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kScreenWidth/2-100, kScreenHeight/2-100, 200, 200)];
    
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathAddEllipseInRect(path1, NULL, CGRectMake(130, 200, 100, 100));
    
    anima.path = path.CGPath;

    CGPathRelease(path1);
    [self.animationView.layer addAnimation:anima forKey:@"pathAnimation"];
}

#pragma mark - values+keyTimes
- (void)values {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 4.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    
    animation.values = @[value1, value2, value3, value4, value5];
    
    animation.keyTimes = @[@0,@0.25,@0.55,@1];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.animationView.layer addAnimation:animation forKey:@"valueAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
