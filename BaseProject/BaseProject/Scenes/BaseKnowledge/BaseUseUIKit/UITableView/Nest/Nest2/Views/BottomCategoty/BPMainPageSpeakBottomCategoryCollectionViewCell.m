//
//  BPMainPageSpeakBottomCategoryCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMainPageSpeakBottomCategoryCollectionViewCell.h"
#import "BPFlowCatergoryImageView.h"
#import "BPMainPageSpeakCategotyController.h"
#import "BPFlowCatergoryImageTagView.h"

@interface BPMainPageSpeakBottomCategoryCollectionViewCell()<BPFlowCatergoryImageViewDelegate>
@property (weak, nonatomic) BPFlowCatergoryImageView *flowCatergoryView;
@property (weak, nonatomic) UIScrollView *scroll;
@end

@implementation BPMainPageSpeakBottomCategoryCollectionViewCell

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
    self.contentView.backgroundColor = [UIColor blueColor];
    self.flowCatergoryView.backgroundColor = kWhiteColor;
    self.flowCatergoryView.titles = @[@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester"];
}

- (BPFlowCatergoryImageView *)flowCatergoryView {
    if (!_flowCatergoryView) {
        BPFlowCatergoryImageView * flowCatergoryView = [[BPFlowCatergoryImageView alloc] init];
        _flowCatergoryView = flowCatergoryView;
        _flowCatergoryView.delegate  = self;
        [self.contentView addSubview:flowCatergoryView];
        [_flowCatergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _flowCatergoryView;
}

- (UIViewController *)flowCatergoryView:(BPFlowCatergoryImageView *)flowCatergoryView cellForItemAtIndexPath:(NSInteger)row {
    BPMainPageSpeakCategotyController *vc = [[BPMainPageSpeakCategotyController alloc] init];
//    BPMainPageSpeakCategotyController *vc = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BPMainPageSpeakCategotyController class]) owner:self options:nil] lastObject];
    vc.index = row;
    return vc;
}

- (void)flowCatergoryViewDidScroll:(BPFlowCatergoryImageView *)flowCatergoryView {
    _scroll.scrollEnabled = NO;
    for (BPMainPageSpeakCategotyController *vc in _flowCatergoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = NO;
    }
    BPLog(@"flowCatergoryViewDidScroll = %@",_scroll);
    
}

- (void)flowCatergoryViewDidEndDecelerating:(BPFlowCatergoryImageView *)flowCatergoryView {
    _scroll.scrollEnabled = YES;
    BPLog(@"flowCatergoryViewDidEndDecelerating = %@",_scroll);
    for (BPMainPageSpeakCategotyController *vc in _flowCatergoryView.vcCacheDic.allValues) {
        vc.tableView.scrollEnabled = YES;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
