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
        _flowCatergoryView.defaultIndex = 0;//默认优先显示的下标
        
        /* 关于交互:滑动、点击 */
        _flowCatergoryView.delegate = self;//监听item按钮点击
        
        /* 关于横线*/
        _flowCatergoryView.bottomLineEable = YES;//开启底部线条
        _flowCatergoryView.bottomLineHeight = 2.0f;//横线高度，默认2.0f
        _flowCatergoryView.bottomLineWidth = 15.0f;//横线宽度
        _flowCatergoryView.bottomLineColor = kThemeColor;//下方横线颜色
        _flowCatergoryView.bottomLineSpacingFromTitleBottom = 6;//设置底部线条距离item底部的距离
        
        
        /* 关于背景图:椭圆*/
        _flowCatergoryView.backEllipseEable = NO;//是否开启背后的椭圆，默认NO
        //catergoryView.backEllipseColor = kGreenColor;/**椭圆颜色，默认黄色*/
        //catergoryView.backEllipseSize = CGSizeMake(10, 10);/**椭圆大小，默认CGSizeZero，表示椭圆大小随文字内容而定*/
        
        /* 关于缩放*/
        _flowCatergoryView.scaleEnable = YES;//是否开启缩放， 默认NO
        _flowCatergoryView.scaleRatio = 1.05f;//缩放比例， 默认1.1
        
        /* 关于cell 间距*/
        _flowCatergoryView.itemSpacing = 35;//item间距，默认10
        _flowCatergoryView.edgeSpacing = 25;//左右边缘间距，默认20
        
        /* 关于字体*/
        _flowCatergoryView.titleColorChangeEable = YES;//是否开启文字颜色变化效果
        _flowCatergoryView.titleColorChangeGradually = NO;//设置文字左右渐变
        _flowCatergoryView.titleColor = kLightGrayColor;
        _flowCatergoryView.titleSelectColor = kBlackColor;
        _flowCatergoryView.titleFont = [UIFont systemFontOfSize:15];//item字体
        
        /* 关于动画*/
        _flowCatergoryView.clickedAnimationDuration = 0.3;//点击item后各个控件（底部线条和椭圆）动画的时间，默认0.3秒，可设置为0*/
        _flowCatergoryView.scrollWithAnimaitonWhenClicked = NO;//禁用点击item滚动scrollView的动画
        _flowCatergoryView.holdLastIndexAfterUpdate = NO;/**刷新后是否保持在原来的index上，默认NO，表示刷新后回到第0个item*/
        _flowCatergoryView.tagViewHeight = 40;
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
