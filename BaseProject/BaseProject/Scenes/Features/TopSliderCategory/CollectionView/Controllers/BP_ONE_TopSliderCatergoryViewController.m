//
//  BP_ONE_TopSliderCatergoryViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP_ONE_TopSliderCatergoryViewController.h"
#import "BPFlowCatergoryView.h"
#import "UIView+BPAdd.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"
#import "Masonry/Masonry.h"
#import "BPFlowCatergoryViewCell.h"
#import "BPTopSliderCategoryCollectionViewCell.h"

@interface BP_ONE_TopSliderCatergoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@end

@implementation BP_ONE_TopSliderCatergoryViewController

- (void)dealloc{
    BPLog(@"销毁了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //有导航控制器必须设置为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = kWhiteColor;
    //主collectionView
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.height - 50) collectionViewLayout:layout];
    mainView.backgroundColor = kWhiteColor;
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[BPTopSliderCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"BPTopSliderCategoryCollectionViewCell"];
    [self.view addSubview:mainView];
    //    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.bottom.equalTo(self.view);
    //    }];
    //catergoryView
    BPFlowCatergoryView * catergoryView = [[BPFlowCatergoryView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 50)];
    //必须设置titles数据源
    catergoryView.titles = self.titles;
    //必须设置关联的scrollview
    catergoryView.scrollView = mainView;
    //代理坚挺点击;
    catergoryView.delegate = self;
    //设置文字左右渐变
    catergoryView.titleColorChangeGradually = YES;
    //开启底部线条
    catergoryView.bottomLineEable = YES;
    catergoryView.titleFont = [UIFont boldSystemFontOfSize:15];
    //设置底部线条距离item底部的距离
    catergoryView.bottomLineSpacingFromTitleBottom = 6;
    //禁用点击item滚动scrollView的动画
    catergoryView.scrollWithAnimaitonWhenClicked = NO;
    catergoryView.backgroundColor = kGrayColor;
    catergoryView.titleColorChangeGradually = YES;
    catergoryView.backEllipseEable = YES;
    catergoryView.defaultIndex =15;
    //    self.navigationItem.titleView = catergoryView;
    [self.view addSubview:catergoryView];
    //    [catergoryView layoutSubviews];
    //    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.equalTo(self.view);
    //        make.top.equalTo(self.view.mas_top).offset(64);
    //        make.height.equalTo(@50);
    //        make.bottom.equalTo(mainView.mas_top);
    //    }];
    
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"Cactus", @"Cactus", @"Cactus", @"Cactus", @"Cactus", @"Cactus",@"Cactus",@"Cactus",@"Cactus",@"Cactus",@"Cactus",@"Cactus", @"Cactus", @"Cactus", @"Cactus", @"Cactus", @"Cactus",@"Cactus",@"Cactus",@"Cactus",@"Cactus",@"Cactus",@"Cactus", @"Cactus", @"Cactus", @"Cactus", @"Cactus", @"Cactus",@"Cactus",@"Cactus",@"Cactus"];
    }
    return _titles;
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
    cell.backgroundColor = kRGB((arc4random() % 255),(arc4random() % 255),(arc4random() % 255));
    cell.title = _titles[indexPath.item];
    return cell;
}
@end

