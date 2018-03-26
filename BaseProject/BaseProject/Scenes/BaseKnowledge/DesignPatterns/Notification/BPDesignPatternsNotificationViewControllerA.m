//
//  BPDesignPatternsNotificationViewControllerA.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsNotificationViewControllerA.h"

@interface BPDesignPatternsNotificationViewControllerA ()

@end

@implementation BPDesignPatternsNotificationViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)test {
    //2.1注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"传值" object:nil];
}

//2.2获取值。userInfo是固定的！@"传值"，@"value"是自定义写的，前后必须写一致。
- (void)getValue:(NSNotification *)nofitication {
    //nofitication 不是字典。虽然可以用valueforKey，但是不只是字典可以用这个方法，只要是对象都可以用。所以此方法NSString *str1 = [nofitication[@"userInfo"]][@"value"]; 不可用
    //    NSDictionary *dic = [nofitication valueForKey:@"userInfo"];
    //    NSString *str = [dic valueForKey:@"value"];
    //    NSString *str = [dic objectForKey:@"value"];
    NSString *str1 = [nofitication valueForKey:@"userInfo"][@"value"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
