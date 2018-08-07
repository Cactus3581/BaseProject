//
//  BPTableViewNestGestureBottomTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTableViewNestGestureBottomTableViewCell.h"
#import "BPFlowCatergoryView.h"
#import "BPTableViewNestGestureDetailViewController.h"

@interface BPTableViewNestGestureBottomTableViewCell ()<BPFlowCatergoryViewDelegate>
@property (nonatomic, weak) BPFlowCatergoryView *flowCatergoryView;
@property (weak, nonatomic) UIScrollView *scroll;

@end

@implementation BPTableViewNestGestureBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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

- (BPFlowCatergoryView *)flowCatergoryView {
    if (!_flowCatergoryView) {
        BPFlowCatergoryView * flowCatergoryView = [[BPFlowCatergoryView alloc] init];
        _flowCatergoryView = flowCatergoryView;
        /* 关于交互:滑动、点击 */
        _flowCatergoryView.delegate = self;//监听item按钮点击
        [self.contentView addSubview:_flowCatergoryView];
        [_flowCatergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _flowCatergoryView;
}

- (UIViewController *)flowCatergoryView:(BPFlowCatergoryView *)flowCatergoryView cellForItemAtIndexPath:(NSInteger)row {
    BPTableViewNestGestureDetailViewController *vc = [[BPTableViewNestGestureDetailViewController alloc] init];
    vc.index = row;
    return vc;
}

#pragma mark - 在下面的collectionView左右滑动的时候：禁止外面（上面）的scroll上下互动；禁止子vc里的tableView上下滑动
- (void)flowCatergoryViewDidScroll:(BPFlowCatergoryView *)flowCatergoryView {
    _scroll.scrollEnabled = NO;
    for (BPTableViewNestGestureDetailViewController *vc in _flowCatergoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = NO;
    }
}

- (void)flowCatergoryViewDidEndDecelerating:(BPFlowCatergoryView *)flowCatergoryView {
    _scroll.scrollEnabled = YES;
    for (BPTableViewNestGestureDetailViewController *vc in _flowCatergoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
