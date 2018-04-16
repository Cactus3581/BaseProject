//
//  BPCardPageFlowViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCardPageFlowViewController.h"
#import "BPCardPageFlowView.h"
#import "BPCardPageFlowViewCell.h"
#import "BPCustomCardPageFlowViewController.h"

@interface BPCardPageFlowViewController ()<BPCardPageFlowViewDelegate, BPCardPageFlowViewDataSource>

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

/**
 *  指示label
 */
@property (nonatomic, strong) UILabel *indicateLabel;

@end

@implementation BPCardPageFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"自定义cell";
    [self setupUI];
}

#pragma mark --push控制器
- (void)rightBarButtonItemClickAction:(id)sender {
    //完全自定义,注意两处
    BPCustomCardPageFlowViewController *customVC = [[BPCustomCardPageFlowViewController alloc] init];
    [self.navigationController pushViewController:customVC animated:YES];
}

- (void)setupUI {
    BPCardPageFlowView *pageFlowView = [[BPCardPageFlowView alloc] initWithFrame:CGRectMake(0, 72, kScreenWidth, kScreenWidth * 9 / 16)];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.1;
    pageFlowView.isCarousel = NO;
    pageFlowView.orientation = BPCardPageFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 32, kScreenWidth, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    [pageFlowView reloadData];
    [self.view addSubview:pageFlowView];
    
    //添加到主view上
    [self.view addSubview:self.indicateLabel];
}

#pragma mark BPCardPageFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(BPCardPageFlowView *)flowView {
    return self.imageArray.count;
}

- (BPCardPageFlowViewCell *)flowView:(BPCardPageFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    BPCardPageFlowViewCell *cell = [flowView dequeueReusableCell];
    if (!cell) {
        cell = [[BPCardPageFlowViewCell alloc] init];
        cell.tag = index;
        cell.layer.cornerRadius = 4;
        cell.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [cell.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    cell.mainImageView.image = self.imageArray[index];
    return cell;
}

#pragma mark BPCardPageFlowView Delegate
- (CGSize)sizeForPageInFlowView:(BPCardPageFlowView *)flowView {
    return CGSizeMake(kScreenWidth - 60, (kScreenWidth - 60) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    BPLog(@"点击了第%ld张图",(long)subIndex + 1);
    self.indicateLabel.text = [NSString stringWithFormat:@"点击了第%ld张图",(long)subIndex + 1];
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(BPCardPageFlowView *)flowView {
    BPLog(@"ViewController 滚动到了第%ld页",pageNumber);
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
    if (!_indicateLabel) {
        _indicateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, kScreenWidth, 16)];
        _indicateLabel.textColor = [UIColor blueColor];
        _indicateLabel.font = [UIFont systemFontOfSize:16.0];
        _indicateLabel.textAlignment = NSTextAlignmentCenter;
        _indicateLabel.text = @"指示Label";
    }
    return _indicateLabel;
}

@end
