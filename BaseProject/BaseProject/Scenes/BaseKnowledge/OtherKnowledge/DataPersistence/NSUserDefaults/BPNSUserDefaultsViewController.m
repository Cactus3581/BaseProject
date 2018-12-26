//
//  BPNSUserDefaultsViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/26.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPNSUserDefaultsViewController.h"

@interface BPNSUserDefaultsViewController ()

@end

@implementation BPNSUserDefaultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     这种情况下，当key值@“ShowTutorial”已设置后会运行正确。但如果默认数据库没有这个key的默认值时，将会返回NO，这或许就不一定是你需要的值了，因为无法区分NO和no value。
     注意需要在每次启动app并且没有在user defaules中读取数据的时候调用以上方法，因为registerDefaults:不能把这些默认数据存储到硬盘上，所以application:didFinishLaunchingWithOptions是最合适的地方。
     
     如果没有找到，NSUserDefaults就会在注册域中查找并返回默认值。

     域
     user defaults数据库中其实是由多个层级的域组成的，当你读取一个键值的数据时，NSUserDefaults从上到下透过域的层级寻找正确的值，不同的域有不同的功能，有些域是可持久的，有些域则不行。
     
     应用域（application domain）是最重要的域，它存储着你app通过NSUserDefaults set...forKey添加的设置。
     注册域（registration domain）仅有较低的优先权，只有在应用域没有找到值时才从注册域去寻找。
     全局域（global domain）则存储着系统的设置
     语言域（language-specific domains）则包括地区、日期等
     参数域（ argument domain）有最高优先权
     
     */
    static NSString *key = @"userDefaults_registerDefaults";
    
    BPLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:key]);
    
    NSDictionary *dic = @{key:@(1)};
    [[NSUserDefaults standardUserDefaults] registerDefaults:dic];
    BPLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:key]);
    
    [[NSUserDefaults standardUserDefaults] setBool:1 forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    BPLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:key]);

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    BPLog(@"%d",[[NSUserDefaults standardUserDefaults] boolForKey:key]);
}

@end
