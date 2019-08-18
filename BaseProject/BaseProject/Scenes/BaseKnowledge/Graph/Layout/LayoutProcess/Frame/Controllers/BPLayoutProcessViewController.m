//
//  BPLayoutProcessViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/28.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPLayoutProcessViewController.h"
#import "BPLayoutProcessView.h"
#import "UIView+BPAdd.h"
#import <Masonry.h>

static CGFloat layoutProcessViewWidth = 200;
static CGFloat layoutProcessViewMetaValue = 20;

@interface BPLayoutProcessViewController ()

@property (nonatomic,weak) BPLayoutProcessView *layoutProcessView;
@property (nonatomic,weak) UIScrollView *scrollView;//测试滑动对layoutSubViews的影响

@end


@implementation BPLayoutProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initializeViews];
    
    
    #pragma mark - 测试滑动对lauoutSubViews的回调效果
    self.scrollView.backgroundColor = kGreenColor;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BPLog(@"ViewController: viewWillAppear");
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    BPLog(@"ViewController: updateViewConstraints");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    BPLog(@"ViewController: viewWillLayoutSubviews");
}

//在view的layoutSubViews或者ViewController的viewDidLayoutSubviews方法里后可以拿到view的实际frame，所以当我们真的需要frame的时候需要在这个时间点以后才能拿到。
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    BPLog(@"ViewController: viewDidLayoutSubviews");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BPLog(@"ViewController: viewDidAppear");
}

- (void)initializeViews {
    BPLayoutProcessView *layoutProcessView = [[BPLayoutProcessView alloc] init];
    _layoutProcessView = layoutProcessView;
    _layoutProcessView.backgroundColor = kGreenColor;
    
    // addSubview会引起layoutSubViews，即使没有frame
    [self.view addSubview:_layoutProcessView];
    
    // 测试frame 布局
//    _layoutProcessView.bounds = CGRectMake(0, 0, layoutProcessViewWidth, layoutProcessViewWidth);
//    _layoutProcessView.center = CGPointMake(self.view.width/2.0, self.view.height/2.0);
    
    // 测试 autoLayout 布局

    [_layoutProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(200);
        make.leading.equalTo(self.view).offset(30);
        make.trailing.equalTo(self.view).offset(-30);
    }];
    
    NSArray *array = @[@"0"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:bt];
        [bt setTitle:obj forState:UIControlStateNormal];
        [bt setTitleColor:kWhiteColor forState:UIControlStateNormal];
        bt.backgroundColor = kBlackColor;
        bt.frame = CGRectMake(10+10*idx+idx*20, 100, 20, 30);
        [bt addTarget:self action:NSSelectorFromString([NSString stringWithFormat:@"change%lu",(unsigned long)idx]) forControlEvents:UIControlEventTouchUpInside];
    }];
}

#pragma mark - 强制布局方法
- (void)change0 {

    BPLog(@"layoutProcessView.frame = %@",NSStringFromCGRect(_layoutProcessView.frame));

    // 修改frame或者约束
        
    [_layoutProcessView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.centerX.equalTo(self.view).offset(10);
    }];
    
    // 获取修改后的值
    BPLog(@"layoutProcessView.frame = %@",NSStringFromCGRect(_layoutProcessView.frame));

    // 强制布局。在这里相当于提前回调了viewWillLayoutSubviews方法，并遍历superview。
    
    // 一般用来立即获取frame；
    // 用来修改约束或者frame的view，被称为目标view。目标view的父view来调用该方法；
    // 父view调用layout后，父view自身的layoutsubviews会先调用，随后调用subview的layoutsubviews；

    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
//
//    // 下面两个方法，用来对比
//    [_layoutProcessView setNeedsLayout];
//    [_layoutProcessView layoutIfNeeded];
    
    // 约束方法
    // 因为frame只能通过layoutsubviews才能拿到。所以即使使用标记方法+强制更新约束的方法，也拿不到正确的frame。所以一般不会主动的调用
    // 修改某个view的约束，该view就调用该方法
    // 先从该view自身调用UpdateConstraints，然后再是该view的父view调用updateConstraints方法。

    [_layoutProcessView setNeedsUpdateConstraints];
    [_layoutProcessView updateConstraintsIfNeeded];

    //[self.view setNeedsUpdateConstraints];
    //[self.view updateConstraintsIfNeeded];
    
    BPLog(@"layoutProcessView.frame = %@",NSStringFromCGRect(_layoutProcessView.frame));
}

#pragma mark - 滑动不会引起layoutSubViews
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc] init];
        _scrollView = scrollView;
        scrollView.backgroundColor = kGreenColor;
        scrollView.pagingEnabled = NO;
        scrollView.clipsToBounds = YES;
        scrollView.bounces = NO;
        scrollView.alwaysBounceVertical = NO;
        scrollView.alwaysBounceHorizontal = NO;
        scrollView.showsVerticalScrollIndicator = YES;
        scrollView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:scrollView];
        scrollView.frame = self.view.bounds;
        scrollView.contentSize = CGSizeMake(self.view.width, 1000);
        
        BPLayoutProcessView *layoutProcessView = [[BPLayoutProcessView alloc] init];
        layoutProcessView.backgroundColor = kGreenColor;
        [scrollView addSubview:layoutProcessView];
        
        // scrollView.frame = self.view.bounds;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        //leftView.frame = CGRectMake(0, 0, self.view.width, 1000);
        [layoutProcessView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.width.mas_equalTo(1000);
        }];
    }
    return _scrollView;
}

@end
