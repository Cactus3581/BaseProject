//
//  BPRouteViewController.m
//  BaseProject
//
//  Created by ryan on 2020/2/19.
//  Copyright © 2020 cactus. All rights reserved.
//

#import "BPRouteViewController.h"
#import <JLRoutes/JLRoutes.h>
#import "UIViewController+BPAdd.h"
#import "BPRouter.h"

@interface BPRouteViewController ()

@end


@implementation BPRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)jumpAction:(id)sender {
    [self useRoute];
}

- (void)useRoute {
    // 1. 注册
    [[JLRoutes globalRoutes] addRoute:@"/:module/:target/:Modal" handler:^BOOL(NSDictionary<NSString *,id>  *_Nonnull parameters) {
        return [self jump:parameters];
    }];

    // 自定义block注册
//    JLRoutes.globalRoutes[@"/:module/:target/:Modal"] = ^BOOL(NSDictionary *parameters) {
//        // 3. 实际跳转操作
//        return [self jump:parameters];
//    };

    // 2. 触发跳转操作
    NSURL *url = [NSURL URLWithString:@"BaseProject://MouduleA/BPTagViewController/push"];
    [JLRoutes routeURL:url];

    //使用 [BPRouter openURL:BPRouteAppear]; push 到 AppearVC，并携带参数 name;
//    [BPRouter openURL:BPRouteAppear parameters:@{kRouteSegue: kRouteSeguePush, @"name": @"jersey"}];
//    [BPRouter openURL:BPRouteAppear];

    // 4. 跳转后的页面需要遵守协议并实现协议方法，可以在协议方法里获取参数

    // 相比词霸多了个注册的操作
}

- (BOOL)jump:(NSDictionary *)parameters {
    NSString *targetClassString = parameters[@"target"];
    Class targetClass = NSClassFromString(targetClassString);
    id object = [[targetClass alloc] init];
    NSString *modal = parameters[@"Modal"];
    if ([object isKindOfClass:[UIViewController class]]) {
       // 目标视图控制器
       UIViewController *taegetVC = (UIViewController *)object;
       // 获取当前视图控制器
       UIViewController *currentViewController = [UIViewController bp_currentViewController];
       // Push
       if ([modal isEqualToString:@"push"]) {
           [currentViewController.navigationController pushViewController:taegetVC animated:YES];
       }
       else{
           // present
    //                   if ([taegetVC respondsToSelector:@selector(setVCModal:)]) {
    //                       [taegetVC performSelector:@selector(setVCModal:) withObject:@"present"];
    //                   }
    //                   BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:taegetVC];
    //                   [currentViewController presentViewController:nav animated:YES completion:nil];
       }
       return YES;
    } else {
       return NO;
    }
}


@end
