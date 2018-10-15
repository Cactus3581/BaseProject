//
//  BPCALayerBasePropertyViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCALayerBasePropertyViewController.h"

@interface BPCALayerBasePropertyViewController ()

@end

@implementation BPCALayerBasePropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    backView.backgroundColor = kThemeColor;
    [self.view addSubview:backView];
    backView.center = self.view.center;
    
    backView.layer.shadowColor = kRedColor.CGColor;//阴影颜色
    backView.layer.shadowOpacity = 0.5f; //颜色透明度
    backView.layer.shadowRadius = 5; // 阴影宽度
    backView.layer.shadowOffset = CGSizeMake(0, 5); //不露出上边的阴影，左右下露出
   // UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 100, 80)];
//    backView.layer.shadowPath = [path CGPath];
//    backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:backView.layer.bounds].CGPath;
    //backView.layer.masksToBounds = YES;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:backView.layer.bounds].CGPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
