//
//  BPScrollViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/10.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPScrollViewController.h"

@interface BPScrollViewController ()<UIScrollViewDelegate>

@end

@implementation BPScrollViewController
//http://tech.glowing.com/cn/practice-in-uiscrollview/
//http://blog.csdn.net/wolf_hong/article/details/53389406
//http://blog.csdn.net/l_j_x_/article/details/50458161
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configScrollView];
}

- (void)configScrollView {
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = kGreenColor;
    scrollView.delegate = self;
    scrollView.pagingEnabled = NO;
    scrollView.clipsToBounds = YES;
    scrollView.bounces = NO;
    
    scrollView.alwaysBounceVertical = NO;
    scrollView.alwaysBounceHorizontal = NO;
    
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:scrollView];
    
    scrollView.bounds = CGRectMake(0, 0, 150, 100);
    scrollView.center = self.view.center;
    scrollView.contentSize = CGSizeMake(150*3, 100);
    
    //scrollView.contentInset = UIEdgeInsetsMake(30, 30, 0, 30);    
    
    UIView *leftView = [[UIView alloc] init];
    [scrollView addSubview:leftView];
    leftView.backgroundColor = kRedColor;
    
    
    UIView *centerView = [[UIView alloc] init];
    [scrollView addSubview:centerView];
    centerView.backgroundColor = kYellowColor;
    
    UIView *rightView = [[UIView alloc] init];
    [scrollView addSubview:rightView];
    rightView.backgroundColor = kBlueColor;
    
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(scrollView);
        make.leading.equalTo(scrollView);
        make.height.equalTo(scrollView);
        make.width.mas_equalTo(scrollView);
    }];
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(scrollView);
        make.leading.equalTo(leftView.mas_trailing);
        make.height.width.equalTo(leftView);
    }];

    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(scrollView);
        make.trailing.equalTo(scrollView.mas_trailing);

        make.leading.equalTo(centerView.mas_trailing);
        make.height.width.equalTo(leftView);
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
