//
//  BPTestViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPTestViewController.h"

@interface BPTestViewController ()<UIGestureRecognizerDelegate>

@end


@implementation BPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *str1 = @"a";
    NSString *str2 = @"a";

    NSNumber *number1 = @(1);
    NSNumber *number2 = @(1);

    
    NSArray *array = @[str1,number1];
    
    BPLog(@"%d,%d,%d,%d",[str1 isEqual:str2],[number1 isEqual:number2],[array containsObject:str2],[array containsObject:number2]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
