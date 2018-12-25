//
//  BPNSValueViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/25.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPNSValueViewController.h"

@interface BPNSValueViewController ()

@end

@implementation BPNSValueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

//NSNumber是NSValue的子类,而NSValue可以包装任何类型,包括结构体
- (void)test {
    CGPoint point1 = CGPointMake(10, 20);
    NSValue *value1 = [NSValue valueWithCGPoint:point1];//对于系统自带类型一般都有直接的方 法进行包装
    NSArray *array1 = [NSArray arrayWithObject:value1];//放到数组中
    NSValue *value2 = [array1 lastObject];
    CGPoint point2 = [value2 CGPointValue];//同样对于系统自带的结构体有对应的取值方法(例如 本例pointValue)
    NSLog(@"x=%f,y=%f", point2.x, point2.y);//结果:x=10.000000,y=20.000000
}

@end
