//
//  BPCollectionViewNestGestureBottomCategoryCollectionCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCollectionViewNestGestureBottomCategoryCollectionCell.h"
#import "BPFlowCatergoryImageView.h"
#import "BPCollectionViewNestGestureCategotyDetailController.h"

@interface BPCollectionViewNestGestureBottomCategoryCollectionCell()<BPFlowCatergoryImageViewDelegate>
@property (weak, nonatomic) BPFlowCatergoryImageView *flowCatergoryView;
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
    self.flowCatergoryView.backgroundColor = kWhiteColor;
    self.flowCatergoryView.titles = @[@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester"];
}

- (BPFlowCatergoryImageView *)flowCatergoryView {
    if (!_flowCatergoryView) {
        BPFlowCatergoryImageView * flowCatergoryView = [[BPFlowCatergoryImageView alloc] init];
        _flowCatergoryView = flowCatergoryView;
        _flowCatergoryView.tagViewHeight = 118;
        _flowCatergoryView.delegate  = self;
        [self.contentView addSubview:flowCatergoryView];
        [_flowCatergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _flowCatergoryView;
}

- (UIViewController *)flowCatergoryView:(BPFlowCatergoryImageView *)flowCatergoryView cellForItemAtIndexPath:(NSInteger)row {
    BPCollectionViewNestGestureCategotyDetailController *vc = [[BPCollectionViewNestGestureCategotyDetailController alloc] init];
    vc.index = row;
    return vc;
}

#pragma mark - 在下面的collectionView左右滑动的时候：禁止外面（上面）的scroll上下互动；禁止子vc里的tableView上下滑动
- (void)flowCatergoryViewDidScroll:(BPFlowCatergoryImageView *)flowCatergoryView {
    _scroll.scrollEnabled = NO;
    for (BPCollectionViewNestGestureCategotyDetailController *vc in _flowCatergoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = NO;
    }
}

- (void)flowCatergoryViewDidEndDecelerating:(BPFlowCatergoryImageView *)flowCatergoryView {
    _scroll.scrollEnabled = YES;
    for (BPCollectionViewNestGestureCategotyDetailController *vc in _flowCatergoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = YES;
    }
}

@end
