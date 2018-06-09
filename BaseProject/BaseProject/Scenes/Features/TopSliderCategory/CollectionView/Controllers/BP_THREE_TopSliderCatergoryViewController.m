//
//  BP_THREE_TopSliderCatergoryViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP_THREE_TopSliderCatergoryViewController.h"
#import "BPFlowCatergoryView.h"
#import "BPFlowCatergoryViewCell.h"
#import "UIView+BPAdd.h"
#import "UIActivityIndicatorView+BPAdd.h"
#import "Masonry/Masonry.h"
#import "BPTopSliderCategoryCollectionViewCell.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"
#import "BPTopSliderCategoryCollectionViewCell.h"

@interface BP_THREE_TopSliderCatergoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) BPFlowCatergoryView *catergoryView;
@property (nonatomic, weak) UICollectionView *mainView;
@end

@implementation BP_THREE_TopSliderCatergoryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kWhiteColor;
    //主collectionView
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _mainView = mainView;
    mainView.backgroundColor = kWhiteColor;
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[BPTopSliderCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"BPTopSliderCategoryCollectionViewCell"];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    //catergoryView
    BPFlowCatergoryView * catergoryView = [BPFlowCatergoryView new];
    _catergoryView = catergoryView;
    catergoryView.titles = self.titles;
    catergoryView.scrollView = mainView;
    catergoryView.itemSpacing = 30;
    catergoryView.delegate = self;
    catergoryView.backgroundColor = kGrayColor;
    //刷新后保持原来的index
    catergoryView.holdLastIndexAfterUpdate = YES;
    //开启缩放
    catergoryView.scaleEnable = YES;
    //设置缩放等级
    catergoryView.scaleRatio = 1.2;
    //开启点击item滑动scrollView的动画
    catergoryView.scrollWithAnimaitonWhenClicked = YES;
    catergoryView.defaultIndex = 1;
    [self.view addSubview:catergoryView];
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@50);
        make.bottom.equalTo(mainView.mas_top);
    }];
    UIBarButtonItem *loadButton = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(bp_netReload:)];
    self.navigationItem.rightBarButtonItem = loadButton;
    
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"热门", @"新上榜", @"连载",@"七日热门"];
    }
    return _titles;
}


/**模拟网络刷新*/
- (void)bp_netReload:(UIBarButtonItem *)sender{
    sender.enabled = NO;
    [UIActivityIndicatorView bp_showAnimationInView:self.view indicatorColor:kGreenColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_titles.count == 4) {
            _titles = @[@"连载",@"七日热门",@"热门", @"新上榜", @"连载", @"生活家",@"世间事", @"@IT", @"市集", @"七日热门", @"三十日热门"];
            _catergoryView.itemSpacing = 30;
            
        }else{
            _titles = @[@"热门", @"新上榜", @"连载",@"七日热门"];
        }
        [UIActivityIndicatorView bp_stopAnimationInView:self.view];
        sender.enabled = YES;
        //重新设置数据源
        _catergoryView.titles = _titles;
        //调用如下方法，刷新控件数据
        [_catergoryView bp_realoadData];
        //刷新你自己的collectionview数据
        [_mainView reloadData];
    });
}

/**监听item点击*/
- (void)catergoryView:(BPFlowCatergoryView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BPLog(@"点击了%zd个item", indexPath.item);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BPTopSliderCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPTopSliderCategoryCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = kRGBA((arc4random() % 255) / 255.0f,(arc4random() % 255) / 255.0f,(arc4random() % 255) / 255.0f,1.0);
    cell.title = _titles[indexPath.item];
    return cell;
}


@end

