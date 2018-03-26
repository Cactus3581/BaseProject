//
//  BPButtonViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPButtonViewController.h"

@interface BPButtonViewController ()

@end

@implementation BPButtonViewController
//https://www.cnblogs.com/OIMM/p/5576853.html
//addTarget uibutton 参数
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)test {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    
    //属性
    button.frame = CGRectMake(100, 300, 150, 100);
    //    button.backgroundColor = [UIColor brownColor];
    
    //    (1)设置文字-title     :两种不同状态下，可以同时设置不同的
    
    //   正常状态下  title的设置
    //    [button setTitle:@"登陆" forState:UIControlStateNormal];
    //
    ////    高亮状态下 title的设置
    //    [button setTitle:@"登陆中..." forState:UIControlStateHighlighted];
    
    
    //    核心功能：点击事件
    //    (2)添加点击事件：title.UIControlEventTouchUpInside：触发
    
    //    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [button addTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchDown];
    //
    ////    (3)移除点击事件
    //    [button removeTarget:self action:@selector(buttonAction2:) forControlEvents:UIControlEventTouchDown];
    
    //    (4)设置title的颜色
    //    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    
    //    (5)设置tite阴影颜色
    //    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    //设置阴影大小。
    ////    button.titleShadowOffset = CGSizeMake(5, 5);
    //    [button setTitleShadowColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    //
    
    //    (6)设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateHighlighted];
    //    设置前景图片
    //    [button setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:button];
}

//点击事件
-(void)btAction:(UIButton *)bt{
    BPLog(@"upInside");
    //    获取正常状态下的title
    BPLog(@"title = %@",[bt titleForState:UIControlStateNormal]);
    //    获取高亮状态下的title
    BPLog(@"title = %@",[bt titleForState:UIControlStateHighlighted]);
    
    
}
-(void)btAction2:(UIButton *)bt{
    BPLog(@"down");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
