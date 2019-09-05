//
//  BPCASpringAnimationViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/9/4.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPCASpringAnimationViewController.h"

@interface BPCASpringAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIView *animationView;

@end


@implementation BPCASpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self springAnimation];
            }
                break;
        }
    }
}

#pragma mark - springAnimation
// iOS9新加入动画类型
- (void)springAnimation {
    CASpringAnimation *animation = [CASpringAnimation animationWithKeyPath:@"position.y"];
    
    animation.mass = 1; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
    animation.stiffness = 100; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
    animation.damping = 5;//阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
    animation.initialVelocity = 0.f;//初始速率，动画视图的初始速度大小;速率为正数时，速度方向与运动方向一致，速率为负数时，速度方向与运动方向相反
    
    animation.duration = animation.settlingDuration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    animation.toValue = @(_animationView.layer.position.y + 200);
    [_animationView.layer addAnimation:animation forKey:@"positionY"];
}

@end
