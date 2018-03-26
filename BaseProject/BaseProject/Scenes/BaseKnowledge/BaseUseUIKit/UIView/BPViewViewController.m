//
//  BPViewViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPViewViewController.h"

@interface BPViewViewController ()

@end

@implementation BPViewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
}

- (void)test {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kGreenColor;
    //切圆
    view.layer.cornerRadius = 100;
    view.layer.masksToBounds = YES;
    //通过下标将视图添加到指定位置。
    [self.view insertSubview:view atIndex:0];
    [self.view insertSubview:view aboveSubview:view];


    //将红色视图 移动到最前面
    [self.view bringSubviewToFront:view];
    //黄色视图移到最后面
    [self.view sendSubviewToBack:view];
    //将视图互换位置
    [self.view exchangeSubviewAtIndex:4 withSubviewAtIndex:0];

    NSArray *arr = view.subviews;

    //tag 值，一般设置大于100的数值
    view.tag = 101;

    //tag方法：通过tag值获取对应控件对象
    UIView *tagView = [self.view viewWithTag:101];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
