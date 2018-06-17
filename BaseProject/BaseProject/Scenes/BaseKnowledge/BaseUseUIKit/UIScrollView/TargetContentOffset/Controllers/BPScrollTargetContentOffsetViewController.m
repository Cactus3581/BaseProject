//
//  BPScrollTargetContentOffsetViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPScrollTargetContentOffsetViewController.h"
#define BUBBLE_DIAMETER     60.0
#define BUBBLE_PADDING      10.0

@interface BPScrollTargetContentOffsetViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIView *contentView;
@end

@implementation BPScrollTargetContentOffsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPages];
}

#pragma mark - lazy methods
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        _scrollView = scrollView;
        _scrollView.backgroundColor = kExplicitColor;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.leading.trailing.equalTo(self.view);
            make.height.mas_equalTo(100);
        }];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        _contentView.backgroundColor = kExplicitColor;
        [self.scrollView addSubview:_contentView];

    }
    return _contentView;
}

- (void)setupPages {
    int totalNum = 10;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    CGFloat x = (kScreenWidth - BUBBLE_DIAMETER) / 2.0;
    CGFloat y = (100 - BUBBLE_DIAMETER) / 2.0;
    for (int i = 0; i < totalNum; ++i) {
        CGRect frame = CGRectMake(x, y, BUBBLE_DIAMETER, BUBBLE_DIAMETER);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"#%d", i];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = kThemeColor;
        label.layer.cornerRadius = frame.size.width / 2.0;
        label.layer.masksToBounds = YES;
        label.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
        [self.contentView addSubview:label];
        x += BUBBLE_DIAMETER + BUBBLE_PADDING;
    }
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.mas_equalTo(x + (self.scrollView.frame.size.width) / 2.0);
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
    targetContentOffset->x = targetOffset.x;
    targetContentOffset->y = targetOffset.y;
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset {
    CGFloat pageSize = BUBBLE_DIAMETER + BUBBLE_PADDING;
    NSInteger page = roundf(offset.x / pageSize);
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}

@end
