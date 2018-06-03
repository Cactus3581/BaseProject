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
@property (nonatomic,strong) BPLayoutProcessView *layoutProcessView;
@property (nonatomic,weak) UIScrollView *scrollView;//测试滑动对layoutSubViews的影响
@end



@implementation BPLayoutProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BPLog(@"ViewController: 1-viewDidLoad");
    self.rightBarButtonTitle = @"changeFrame";
    [self initSubView];
    [self testClick];
    #pragma mark - 测试滑动对lauoutSubViews的回调效果
    //self.scrollView.backgroundColor = kGreenColor;
}

- (void)testClick {
    NSArray *array = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"reset"];
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

#pragma mark -  测试1:外部直接修改值
- (void)change0 {
    //没效果
    self.layoutProcessView.center = CGPointMake(self.view.width/2.0-layoutProcessViewMetaValue, self.view.height/2.0-layoutProcessViewMetaValue);//如果不改变size，不会引起layoutProcessView的lauoutSubViews
}

- (void)change1 {
    //viewWillLayoutSubviews
    //viewWillLayoutSubviews
    //UIView:layoutSubviews
    self.layoutProcessView.bounds = CGRectMake(0, 0, 200-layoutProcessViewMetaValue, 200-layoutProcessViewMetaValue);
}

#pragma mark - 测试2:外部调用View对象，在里面修改自身的值
- (void)change2 {
    //UIView:layoutSubviews 奇怪了
    [self.layoutProcessView changeCenter];
}
- (void)change3 {
    /*
     viewWillLayoutSubviews
     viewDidLayoutSubviews
     UIView:layoutSubviews
     */
    [self.layoutProcessView changeSize];
#pragma mark - 使用layoutIfNeeded会立即调用viewWillLayoutSubviews，如果不调用，会在下一个runloop里回调
    [self.view layoutIfNeeded];
    BPLog(@"%@",NSStringFromCGRect(self.layoutProcessView.frame));
}

#pragma mark -  测试3:外部调用View对象，在里面修改它的子view的值：修改size值，会引起它的父view的layoutSubViews的回调，而且size必须前后的值必须有变化；center不会；
- (void)change4 {
    //没效果
    [self.layoutProcessView changeSubViewCenter];
}
- (void)change5 {
    /*
     UIView:layoutSubviews
     */
    [self.layoutProcessView changeSubViewSize];
//    [self.view layoutIfNeeded];
//    [self.layoutProcessView layoutIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));//立马就能改变layoutProcessView的frame
}
- (void)change6 {
    //没效果
    self.layoutProcessView.button.center = CGPointMake(200/2.0-30, 200/2.0-30);
}
- (void)change7 {
    /*
     UIView:layoutSubviews
     */
    self.layoutProcessView.button.bounds = CGRectMake(0, 0,200-80,200-80);
}

// 恢复
- (void)change8 {
    self.layoutProcessView.bounds = CGRectMake(0, 0, layoutProcessViewWidth, layoutProcessViewWidth);
    self.layoutProcessView.center = CGPointMake(self.view.width/2.0, self.view.height/2.0);
}

- (void)rightBarButtonItemClickAction:(id)sender {
#pragma mark - 对使用frame布局的对象没有用，修改frame直接生效了，如果是对约束布局的viw对象，可能不会立即生效，需要在下一个runloop更新UI的时机生效，如果需要立即生效，就可以使用下面这句话了
    [self.view layoutIfNeeded];
    BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(self.layoutProcessView.frame));//立马就能改变layoutProcessView的frame
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BPLog(@"ViewController: 2-viewWillAppear");
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    BPLog(@"ViewController: 5-updateViewConstraints");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    BPLog(@"ViewController: 6-viewWillLayoutSubviews");
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    BPLog(@"ViewController: 7-viewDidLayoutSubviews");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BPLog(@"ViewController: 8-viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    BPLog(@"ViewController: 9-viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    BPLog(@"ViewController: 10-viewDidDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    BPLog(@"ViewController: didReceiveMemoryWarning");
}

- (void)dealloc {
    BPLog(@"ViewController: dealloc");
}

- (void)initSubView {
    BPLog(@"ViewController: initSubView");
    self.layoutProcessView.bounds = CGRectMake(0, 0, layoutProcessViewWidth, layoutProcessViewWidth);
    self.layoutProcessView.center = CGPointMake(self.view.width/2.0, self.view.height/2.0);
}

#pragma mark - 滑动不会引起layoutSubViews
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.backgroundColor = [UIColor greenColor];
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
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1000)];
        [scrollView addSubview:leftView];
        leftView.backgroundColor = [UIColor redColor];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (BPLayoutProcessView *)layoutProcessView {
    if (!_layoutProcessView) {
        BPLayoutProcessView *view = [[BPLayoutProcessView alloc] init];
        _layoutProcessView = view;
        _layoutProcessView.backgroundColor = kGreenColor;
#pragma mark - addSubview会引起layoutSubViews，哪怕没有frame
        [self.view addSubview:_layoutProcessView];
    }
    return _layoutProcessView;
}

@end
