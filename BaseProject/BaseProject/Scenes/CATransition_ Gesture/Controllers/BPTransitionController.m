//
//  BPTransitionController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTransitionController.h"
#import "BPCoreAnimationVC.h"

@interface BPTransitionController ()

@end

@implementation BPTransitionController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)transitionAnimation {
    CATransition  *transition = [CATransition animation];
    //    2.设置动画时长,设置代理人
    transition.duration = 1.0f;
    transition.delegate = self;
    //    3.设置切换速度效果
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    transition.type = kCATransitionFade;
    
    transition.subtype = kCATransitionFromTop;//顶部
    BPCoreAnimationVC *vc = [[BPCoreAnimationVC alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
