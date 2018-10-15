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

    [self initializeRootViewController];
    
    //[self initializeLaunchImage]; // 代码启动图片（在info里把launch key删除，防止展示两次）
    
    //[self configStyleByAppearance]; //统一设置style
    
    [self initializeSDKS];
    
    return YES;
}

- (void)initializeRootViewController {
    self.rootTabbarViewController = [[BPRootTabBarController alloc]init];
    self.window.rootViewController = self.rootTabbarViewController;
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

- (void)initializeLaunchImage {
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

- (void)testCurrentViewController {
    UIViewController *visibleViewController = [self currentViewController];
//    if ([visibleViewController isKindOfClass:[BPScanPaperContainerController class]]) {
//    }
}

// 获取导航栏控制器
- (UINavigationController *)selectedNavigationController {
    return self.rootTabbarViewController.selectedViewController;
}

#pragma mark - 追逐label
- (UILabel *)trackWindowLabel {
    if (!_trackWindowLabel) {
        UILabel *trackWindowLabel = [[UILabel alloc] init];
        _trackWindowLabel = trackWindowLabel;
        _trackWindowLabel.textAlignment = NSTextAlignmentLeft;
        _trackWindowLabel.numberOfLines = 0;
        _trackWindowLabel.backgroundColor = kBlackColor;
        _trackWindowLabel.alpha = 0.9;
        _trackWindowLabel.textColor = kWhiteColor;
        _trackWindowLabel.preferredMaxLayoutWidth = kScreenWidth/3*2.0;
        [self.window addSubview:_trackWindowLabel];
        [_trackWindowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.window).offset(-10);
            make.bottom.equalTo(self.window).offset(-49);
        }];
    }
    [self.window bringSubviewToFront:_trackWindowLabel];
    return _trackWindowLabel;
}

- (NSString *)trackString:(NSString *)string {
    if (!BPValidateString(string).length) {
        return nil;
    }
    NSMutableString *mutableString =  [self.trackWindowLabel.text mutableCopy];
    [mutableString appendString:string];
    self.trackWindowLabel.text = [NSString stringWithFormat:@"%@;\n",[mutableString copy]] ;
    return self.trackWindowLabel.text;
}

- (void)reserTrackString {
    self.trackWindowLabel.text = @"";
}

#pragma mark - 获取当前展示的vc(参数传入导航试图控制器或者UITabBarController,self.window.rootViewController 也可。（这个比较通用）)
- (UIViewController*)currentViewController {
    // Find best view controller
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findcurrentViewController:viewController];
}

- (UIViewController*)findcurrentViewController:(UIViewController*)vc {
    if (vc.presentedViewController) {
        // Return presented view controller
        return [self findcurrentViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findcurrentViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findcurrentViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [self findcurrentViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

- (void)initializeSDKS {
    BuglyConfig *debugMode = [[BuglyConfig alloc] init];
    debugMode.debugMode = YES;
    [Bugly startWithAppId:@"dc9e61f4db" developmentDevice:YES config:debugMode];
}

//程序将要取消活跃状态 执行的方法  我们可以进行歌曲 视频的暂停操作
- (void)applicationWillResignActive:(UIApplication *)application {
    BPLog(@"程序将要取消活跃状态");
}

//程序已经进入到后台  执行的方法(一般用来保存临时的数据)
- (void)applicationDidEnterBackground:(UIApplication *)application {
    BPLog(@"程序已经进入到后台执行的方法");
}

//程序将要进入到前台  执行的方法(一般进行视频 歌曲数据的恢复)
- (void)applicationWillEnterForeground:(UIApplication *)application {
    BPLog(@"程序将要进入到前台");
}

//程序已经变成活跃状态执行的方法   一般进行UI界面刷新
- (void)applicationDidBecomeActive:(UIApplication *)application {
    BPLog(@"程序已经变成活跃状态");
}

//程序将要退出执行的方法
- (void)applicationWillTerminate:(UIApplication *)application {
    BPLog(@"程序将要退出");
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [self openUrl:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self openUrl:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self openUrl:url];
}

- (BOOL)openUrl:(NSURL *)url {
    NSString *urlstr = [url absoluteString];
    if([urlstr rangeOfString:@"BaseProject"].location !=NSNotFound) {
        return YES;
    }
    return NO;
}

#pragma mark - 屏幕旋转
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - 统一设置 style
- (void)configStyleByAppearance {
    // 项目中所有的UIBarButtonItem统一设置
    //iOS 11 之前 把系统的backButton的文字去掉，11之后不管用了
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    // 项目中所有的导航栏统一设置
    [UINavigationBar appearance].tintColor = kThemeColor;
    //[[UINavigationBar appearance] setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
}

@end
