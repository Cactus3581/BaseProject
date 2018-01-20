//
//  BPSliderViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSliderViewController.h"

@interface BPSliderViewController ()<UIScrollViewDelegate>

@end

@implementation BPSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)configScrollView_2 {
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor greenColor];
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
    leftView.backgroundColor = [UIColor redColor];
    
    
    UIView *centerView = [[UIView alloc] init];
    [scrollView addSubview:centerView];
    centerView.backgroundColor = [UIColor yellowColor];
    
    UIView *rightView = [[UIView alloc] init];
    [scrollView addSubview:rightView];
    rightView.backgroundColor = [UIColor blueColor];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(scrollView).offset(0);
        make.height.mas_equalTo(100);
    }];
}

- (void)configScrollView_1 {
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor greenColor];
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
    view.backgroundColor = [UIColor redColor];
    scrollView.contentOffset = CGPointMake(0, 0.0);
    
    //    [self.sliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.center.left.right.equalTo(self.view);
    //        make.height.mas_equalTo(100);
    //    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
