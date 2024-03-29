//
//  BPSliderViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSliderViewController.h"

@interface BPSliderViewController ()<UIScrollViewDelegate>

@end

@implementation BPSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initializeScrollView_2 {
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
    scrollView.contentSize = CGSizeMake(150, 100);
    
    //    scrollView.contentSize = CGSizeMake(200, 100);
    //    scrollView.contentInset = UIEdgeInsetsMake(30, 30, 0, 30);
    
    
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
        make.leading.mas_equalTo(0);
        make.trailing.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(scrollView).offset(0);
        make.height.mas_equalTo(100);
    }];
}

- (void)initializeScrollView_1 {
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
    
    scrollView.bounds = CGRectMake(0, 0, 100, 100);
    scrollView.center = self.view.center;
    
    scrollView.contentSize = CGSizeMake(200, 100);
    scrollView.contentInset = UIEdgeInsetsMake(30, 30, 0, 30);
    
    
    UIView *view = [[UIView alloc] init];
    [scrollView addSubview:view];
    
    view.frame = CGRectMake(10, 10, 190, 50); // contentSize.width(200) + contentInset.left(30) + contentInset.right(30) = size.width(260)，但是可展示的size = 200；
    //当有contentInset的时候，开始显示的时候，显示的非inset的位置。
    view.backgroundColor = kRedColor;
    scrollView.contentOffset = CGPointMake(0, 0.0);
    
    //    [self.sliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.leading.trailing.equalTo(self.view);
    //        make.height.mas_equalTo(100);
    //    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
