//
//  BPAppDelegate.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPAppDelegate.h"
#import "BPRootTabBarController.h"
#import <Bugly/Bugly.h>
#import "BPBaseViewController.h"
#import "BPBaseNavigationController.h"

@interface BPAppDelegate ()

@end

@implementation BPAppDelegate

//程序准备就绪 将要运行时执行 我们一般用来进行 window创建 以及视图控件等等配置
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    BPRootTabBarController *RootVC = [[BPRootTabBarController alloc]init];
    self.window.rootViewController = RootVC;
    //[self configLaunchImage]; // 代码启动图片（在info里把launch key删除，防止展示两次）
    [self configSDKS];
    return YES;
}

- (UIWindow *)window{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    _window.backgroundColor = kWhiteColor;
    [_window makeKeyAndVisible];
    return _window;
}

- (void)addChildController {
    //1.
    BPBaseNavigationController *nav = [[BPBaseNavigationController alloc] init];
    self.window.rootViewController = nav;
    BPBaseViewController  *vc = [[BPBaseViewController  alloc] init];
    [nav pushViewController:vc animated:YES];

    //2.
    [nav addChildViewController:vc];//注意该属性是只读的，因此不能像下面这样写。nav.childViewControllers = @[one];
    
    //3.
    nav.viewControllers=@[vc];
    
    //4.最常用的方法
    BPBaseNavigationController *nav_1 = [[BPBaseNavigationController alloc] initWithRootViewController:vc];
}

- (void)configLaunchImage {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    viewController.view.backgroundColor = kWhiteColor;
    UIView *launchView = viewController.view;
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    
    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        /*
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
         */
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
    }];
     
}

- (void)configSDKS {
    BuglyConfig *debugMode = [[BuglyConfig alloc] init];
    debugMode.debugMode = YES;
    [Bugly startWithAppId:@"dc9e61f4db" developmentDevice:YES config:debugMode];
}

//程序将要取消活跃状态 执行的方法  我们可以进行歌曲 视频的暂停操作
- (void)applicationWillResignActive:(UIApplication *)application {
    BPLog(@"程序将要取消活跃状态%s %d",__FUNCTION__,__LINE__);
}

//程序已经进入到后台  执行的方法(一般用来保存临时的数据)

- (void)applicationDidEnterBackground:(UIApplication *)application {
    BPLog(@"程序已经进入到后台执行的方法 %s %d",__FUNCTION__,__LINE__);

}

//程序将要进入到前台  执行的方法(一般进行视频 歌曲数据的恢复)

- (void)applicationWillEnterForeground:(UIApplication *)application {
    BPLog(@"程序将要进入到前台 %s %d",__FUNCTION__,__LINE__);

}

//程序已经变成活跃状态执行的方法   一般进行UI界面刷新

- (void)applicationDidBecomeActive:(UIApplication *)application {
    BPLog(@"程序已经变成活跃状态 %s %d",__FUNCTION__,__LINE__);

}

//程序将要退出执行的方法

- (void)applicationWillTerminate:(UIApplication *)application {
    BPLog(@"程序将要退出 %s %d",__FUNCTION__,__LINE__);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    return [self openUrl:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {

    return [self openUrl:url];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return [self openUrl:url];
}

- (BOOL)openUrl:(NSURL *)url {
    NSString *urlstr = [url absoluteString];
    if([urlstr rangeOfString:@"BaseProject"].location !=NSNotFound) {
        return YES;
    }
    return NO;
}

@end
