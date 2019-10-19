//
//  BPCollectionViewNestGestureBottomCategoryCollectionCell.m
//  BaseProject
//
//  Created by Ryan on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCollectionViewNestGestureBottomCategoryCollectionCell.h"
#import "BPFlowCategoryImageView.h"
#import "BPCollectionViewNestGestureCategotyDetailController.h"

@interface BPCollectionViewNestGestureBottomCategoryCollectionCell()<BPFlowCategoryImageViewDelegate>
@property (weak, nonatomic) BPFlowCategoryImageView *flowCategoryView;
@property (weak, nonatomic) UIScrollView *scroll;
@end

@implementation BPCollectionViewNestGestureBottomCategoryCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)setScrollView:(UIScrollView *)scroll {
    _scroll = scroll;
}

- (void)initViews {
    self.contentView.backgroundColor = kWhiteColor;
    self.flowCategoryView.backgroundColor = kWhiteColor;
    self.flowCategoryView.titles = @[@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester"];
}

- (BPFlowCategoryImageView *)flowCategoryView {
    if (!_flowCategoryView) {
        BPFlowCategoryImageView * flowCategoryView = [[BPFlowCategoryImageView alloc] init];
        _flowCategoryView = flowCategoryView;
        _flowCategoryView.tagViewHeight = 118;
        _flowCategoryView.delegate  = self;
        [self.contentView addSubview:flowCategoryView];
        [_flowCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _flowCategoryView;
}

- (UIViewController *)flowCategoryView:(BPFlowCategoryImageView *)flowCategoryView cellForItemAtIndexPath:(NSInteger)row {
    BPCollectionViewNestGestureCategotyDetailController *vc = [[BPCollectionViewNestGestureCategotyDetailController alloc] init];
    vc.index = row;
    return vc;
}

#pragma mark - 在下面的collectionView左右滑动的时候：禁止外面（上面）的scroll上下互动；禁止子vc里的tableView上下滑动
- (void)flowCategoryViewDidScroll:(BPFlowCategoryImageView *)flowCategoryView {
    _scroll.scrollEnabled = NO;
    for (BPCollectionViewNestGestureCategotyDetailController *vc in _flowCategoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = NO;
    }
}

- (void)flowCategoryViewDidEndDecelerating:(BPFlowCategoryImageView *)flowCategoryView {
    _scroll.scrollEnabled = YES;
    for (BPCollectionViewNestGestureCategotyDetailController *vc in _flowCategoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = YES;
    }
}

@end
