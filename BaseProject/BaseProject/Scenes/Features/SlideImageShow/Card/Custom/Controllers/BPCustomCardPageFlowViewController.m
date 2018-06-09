//
//  BPCustomCardPageFlowViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCustomCardPageFlowViewController.h"
#import "BPCardPageFlowView.h"
#import "BPCustomCardPageFlowViewCell.h"

@interface BPCustomCardPageFlowViewController ()<BPCardPageFlowViewDelegate, BPCardPageFlowViewDataSource>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 *  指示label
 */
@property (nonatomic, strong) UILabel *indicateLabel;

/**
 *  轮播图
 */
@property (nonatomic, strong) BPCardPageFlowView *pageFlowView;

@end

@implementation BPCustomCardPageFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"滚动到指定的页数";
    [self setupUI];
}

#pragma mark --滚动到指定的页数
- (void)rightBarButtonItemClickAction:(id)sender {
    //产生跳转的随机数
    int value = arc4random() % self.imageArray.count;
    BPLog(@"value~~%d",value);
    [self.pageFlowView scrollToPage:value];
}

- (void)setupUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    BPCardPageFlowView *pageFlowView = [[BPCardPageFlowView alloc] initWithFrame:CGRectMake(0, 72, kScreenWidth, kScreenWidth * 9 / 16)];
    pageFlowView.backgroundColor = kWhiteColor;
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    
#warning 假设产品需求左右卡片间距30,底部对齐
    pageFlowView.leftRightMargin = 30;
    pageFlowView.topBottomMargin = 0;
    
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24, kScreenWidth, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    [pageFlowView reloadData];
    [self.view addSubview:pageFlowView];
    
    self.pageFlowView = pageFlowView;
    //添加到主view上
    [self.view addSubview:self.indicateLabel];
}

#pragma mark --BPCardPageFlowView Delegate
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    BPLog(@"点击了第%ld张图",(long)subIndex + 1);
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(BPCardPageFlowView *)flowView {
    BPLog(@"BPCustomCardPageFlowViewController 滚动到了第%ld页",pageNumber);
}

#warning 假设产品需求左右中间页显示大小为 kScreenWidth - 50, (kScreenWidth - 50) * 9 / 16
- (CGSize)sizeForPageInFlowView:(BPCardPageFlowView *)flowView {
    return CGSizeMake(kScreenWidth - 50, (kScreenWidth - 50) * 9 / 16);
}

#pragma mark --BPCardPageFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(BPCardPageFlowView *)flowView {
    return self.imageArray.count;
}

- (BPCustomCardPageFlowViewCell *)flowView:(BPCardPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    BPCustomCardPageFlowViewCell *cell = (BPCustomCardPageFlowViewCell *)[flowView dequeueReusableCell];
    if (!cell) {
        cell = [[BPCustomCardPageFlowViewCell alloc] init];
        cell.layer.cornerRadius = 4;
        cell.layer.masksToBounds = YES;
    }
    
    //在这里下载网络图片
    //[cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    
    cell.mainImageView.image = self.imageArray[index];
    cell.indexLabel.text = [NSString stringWithFormat:@"第%ld张图",(long)index + 1];
    return cell;
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
        for (int index = 0; index < 5; index++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
            [_imageArray addObject:image];
        }
        
    }
    return _imageArray;
}

- (UILabel *)indicateLabel {
    if (_indicateLabel == nil) {
        _indicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, kScreenWidth, 16)];
        _indicateLabel.textColor = kBlueColor;
        _indicateLabel.font = [UIFont systemFontOfSize:16.0];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.text = @"指示Label";
    }
    return _indicateLabel;
}

#pragma mark --旋转屏幕改变newPageFlowView大小之后实现该方法
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id)coordinator {
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [coordinator animateAlongsideTransition:^(id context) {
            [self.pageFlowView reloadData];
        } completion:NULL];
    }
}

- (void)dealloc {
    //在dealloc或者返回按钮里停止定时器
    [self.pageFlowView stopTimer];
}

@end
