//
//  BPStackViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/7/9.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPStackViewController.h"

@interface BPStackViewController ()

@end

@implementation BPStackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStackView *containerView = [[UIStackView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 200)];
    // 布局方向，水平或垂直
    containerView.axis = UILayoutConstraintAxisHorizontal;
    // 子控件依据何种规则布局
    /*
     UIStackViewDistributionFill
     UIStackViewDistributionFillEqually:子控件d尺寸均分
     
     */
    containerView.distribution = UIStackViewDistributionFillEqually;
    // 子控件之间的最小间距
    containerView.spacing = 10;
    
    // 子控件对其方式
    containerView.alignment = UIStackViewAlignmentFill;
    
    // arrangedSubviews 使用数组进行增删查
    for (NSInteger i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1];
        [containerView addArrangedSubview:view];
    }
    
    [self.view addSubview:containerView];
    
}

@end
