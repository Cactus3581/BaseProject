//
//  BPPresentAViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/4/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPresentAViewController.h"
#import "BPPresentBViewController.h"

@interface BPPresentAViewController ()

@end

@implementation BPPresentAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"present";
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            case 0:{
                [self presentAndPush];//模态->push
            }
                break;
                
            case 1:{
                [self present];
            }
                break;
                
            case 2:{
                [self presentWithAnimation];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)presentAndPush {
    BPPresentBViewController *vc = [[BPPresentBViewController alloc] init];
    //在这个模态中视图的跳转就可以用这个刚创建的导航控制器完成了,表现在代码里则:self.navigationController是存在的.
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    //如果想让模态的页面有导航栏，那就必须presentViewController:navi，不能是vc
    //[self.navigationController presentViewController:navi animated:YES completion:nil];//包括这个及以下都可以
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)present {
    BPPresentBViewController *vc = [[BPPresentBViewController alloc] init];

    //设置模态视图弹出样式
    /*
     //跳转之后覆盖整个屏幕，不透明
     UIModalPresentationFullScreen = 0,
     //跳转之后覆盖整个屏幕，不透明
     UIModalPresentationPageSheet
     //跳转之后覆盖整个屏幕，不透明
     UIModalPresentationFormSheet
     //跳转之后覆盖当前内容（除导航栏和标签栏部分），不透明
     UIModalPresentationCurrentContext
     //跳转之后显示自定制视图（默认是覆盖整个屏幕），可以透明
     UIModalPresentationCustom
     //跳转之后覆盖整个屏幕，可以透明
     UIModalPresentationOverFullScreen
     //跳转之后覆盖当前内容（除导航栏和标签栏部分），可以透明
     UIModalPresentationOverCurrentContext
     //跳转之后覆盖整个屏幕，不透明
     UIModalPresentationPopover
     */
    //把当前控制器作为背景
//    self.definesPresentationContext = YES;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;//转场动画效果
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen; //关于即将模态页面的显示
//    vc.view.backgroundColor = kClearColor; //如果想让第二个页面半透明或者透明，需要设置以上两句代码
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)presentWithAnimation {
    BPPresentBViewController *vc = [[BPPresentBViewController alloc] init];
    //把当前控制器作为背景
//    self.definesPresentationContext = YES;
    //设置模态视图弹出样式
//    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    //移除当前window的layer层的动画
    [self.view.window.layer removeAllAnimations];
    [[self.view.window layer] addAnimation:[self animation] forKey:@"SwitchToView"];//自定义扩展转场动画
    [self presentViewController:vc animated:YES completion:nil];
}

- (CATransition *)animation {
    //创建动画
    CATransition * transition = [CATransition animation];
    //设置动画类型（这个是字符串，可以搜索一些更好看的类型）
    transition.type = kCATransitionPush;
    //动画出现类型
    transition.subtype = kCATransitionFromRight;
    //动画时间
    transition.duration = 0.3;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    return transition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
