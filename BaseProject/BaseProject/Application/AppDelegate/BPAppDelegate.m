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
    
#pragma mark - cgfloat转NSNumber&NSString
    CGFloat CGFloat_number = 89.99;

    //1.转NSNumber
    NSNumber *NSNumber_number = [NSNumber numberWithDouble:CGFloat_number];
    NSLog(@"%@",NSNumber_number); //此时输出89.9899999999999；

    NSNumber_number = @(CGFloat_number);
    NSLog(@"%@",NSNumber_number); //此时输出89.9899999999999；
    
    NSNumber_number = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",CGFloat_number]];
    NSLog(@"%@",NSNumber_number); //完美


    //2.转NSString
    NSLog(@"%@",[NSString stringWithFormat:@"%.2f",CGFloat_number]);
    NSLog(@"%@",[NSString stringWithFormat:@"%g",CGFloat_number]);//完美

#pragma mark - NSNumber转CGFloat，NSString
    NSNumber *moneyNum = @(89.99);
    NSLog(@"%@",moneyNum); //此时输出89.9899999999999；
    
    moneyNum = [NSNumber numberWithDouble:89.99];
    NSLog(@"NSNumber %@",moneyNum); //此时输出89.9899999999999；
    
    moneyNum = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%g",89.99]];
    NSLog(@"%@",moneyNum);//

    //1.转CGFloat
    CGFloat conversionValue = [moneyNum doubleValue];
    NSLog(@"%g",conversionValue);//完美


    //2.转NSString
    NSString *sds = [NSString stringWithFormat:@"%@",moneyNum];
    NSLog(@"%@",sds);//此时输出89.9899999999999；
    NSString *sds1 = [NSString stringWithFormat:@"%g",conversionValue];
    NSLog(@"%@",sds1);//完美

#pragma mark - NSString转CGFloat，NSNumber

    //1.转CGFloat
    NSString *number = @"89.99";
    NSLog(@"%@",number);//完美
    CGFloat numberFloat = [number doubleValue];
    NSLog(@"%g",numberFloat);//完美
    
    //2.转NSNumber
    //NSNumber * number_number = @([number doubleValue]);//此时输出89.9899999999999；
    
    NSNumber * number_number = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%g",[number doubleValue]]];
    NSLog(@"%@",number_number);//完美

    return YES;
}

- (NSString *)stringDecimalNumber:(NSNumber *)number {
    double conversionValue = [number doubleValue];
    return [[self decimalNumber:conversionValue] stringValue];
}

- (double)doubleDecimalNumber:(NSNumber *)number {
    double conversionValue = [number doubleValue];
    return [[self decimalNumber:conversionValue] doubleValue];
}

- (NSString *)stringWithDecimalNumber:(double)num {
    return [[self decimalNumber:num] stringValue];
}

- (double)doubleWithDecimalNumber:(double)num {
    return [[self decimalNumber:num] doubleValue];
}

- (NSDecimalNumber *)decimalNumber:(double)num {
    NSString *numString = [NSString stringWithFormat:@"%lf", num];
    return [NSDecimalNumber decimalNumberWithString:numString];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    //safari跳转app
    NSString *urlstr=[url absoluteString];
    if([urlstr rangeOfString:@"BaseProject"].location !=NSNotFound) {
        
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //safari跳转app
    NSString *urlstr=[url absoluteString];
    if([urlstr rangeOfString:@"BaseProject"].location !=NSNotFound) {
        
    }
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //safari跳转app
    NSString *urlstr=[url absoluteString];
    if([urlstr rangeOfString:@"BaseProject"].location !=NSNotFound) {
        
    }
    return YES;
}

@end

