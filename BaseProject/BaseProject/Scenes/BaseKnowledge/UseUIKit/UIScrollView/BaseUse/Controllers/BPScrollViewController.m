//
//  BPScrollViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/1/10.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPScrollViewController.h"

@interface BPScrollViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat lastContentOffset;
@end

@implementation BPScrollViewController
//http://tech.glowing.com/cn/practice-in-uiscrollview/
//http://blog.csdn.net/wolf_hong/article/details/53389406
//http://blog.csdn.net/l_j_x_/article/details/50458161

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
}

- (void)initializeViews {
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    _scrollView = scrollView;
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

#pragma mark - scrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    BPLog(@"1 - 将开始拖拽");
    //全局变量记录滑动前的contentOffset
    self.lastContentOffset = scrollView.contentOffset.y;//判断上下滑动时
    //self.lastContentOffset = scrollView.contentOffset.x;//判断左右滑动时
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BPLog(@"2 - 在滚动着");
    if (scrollView.contentOffset.y < self.lastContentOffset ){
        //向上
        BPLog(@"上滑");
    } else if (scrollView.contentOffset.y > self.lastContentOffset ){
        //向下
        BPLog(@"下滑");
    }
    
    //判断左右滑动时
    //    if (scrollView.contentOffset.x < self.lastContentOffset ){
    //        //向右
    //        BPLog(@"左滑");
    //    } else if (scrollView. contentOffset.x > self.lastContentOffset ){
    //        //向左
    //        BPLog(@"右滑");
    //    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    BPLog(@"3 - 将要结束拖拽");
    BPLog(@"%s velocity: %@, targetContentOffset: %@", __PRETTY_FUNCTION__,
          [NSValue valueWithCGPoint:velocity],
          [NSValue valueWithCGPoint:*targetContentOffset]);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    BPLog(@"4 - 已经结束拖拽");
    if (decelerate == NO) {
        BPLog(@"scrollView停止滚动，完全静止"); //不走这个log？
    } else {
        BPLog(@"4(end) - 用户停止拖拽，但是scrollView由于惯性，会继续滚动，并且减速");
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    BPLog(@"6 - 开始减速");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BPLog(@"6 - 彻底停止滚动");
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    BPLog(@"非触摸拖拽 - 偏移动画完成时调用：彻底停止滚动");
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    int page = roundf(self.scrollView.contentOffset.x / self.scrollView.frame.size.width);
    BPLog(@"page = %ld",page);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.pageBeforeRotation, 0.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
