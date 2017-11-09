//
//  BPAppDelegate.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPAppDelegate.h"
#import "BPRootTabBarController.h"

@interface BPAppDelegate ()

@end

@implementation BPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    BPRootTabBarController *RootVC = [[BPRootTabBarController alloc]init];
    self.window.rootViewController = RootVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
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
