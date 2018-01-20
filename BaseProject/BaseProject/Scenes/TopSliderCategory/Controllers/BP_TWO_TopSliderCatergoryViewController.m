//
//  BP_TWO_TopSliderCatergoryViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP_TWO_TopSliderCatergoryViewController.h"
#import "BPFlowCatergoryView.h"
#import "UIView+BPAdd.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"
#import "Masonry/Masonry.h"
#import "BPTopSliderCategoryCollectionViewCell.h"

@interface BP_TWO_TopSliderCatergoryViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@end

@implementation BP_TWO_TopSliderCatergoryViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //主collectionView
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[BPTopSliderCategoryCollectionViewCell class] forCellWithReuseIdentifier:@"BPTopSliderCategoryCollectionViewCell"];
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
    }];
    //catergoryView
    BPFlowCatergoryView * catergoryView = [BPFlowCatergoryView new];
    catergoryView.titles = self.titles;
    catergoryView.scrollView = mainView;
    catergoryView.delegate = self;
    catergoryView.titleSelectColor = [UIColor purpleColor];
    catergoryView.itemSpacing = 15;
    /**开启背后椭圆*/
    catergoryView.backEllipseEable = YES;
    catergoryView.scrollWithAnimaitonWhenClicked = NO;
    /**设置默认defaultIndex*/
    catergoryView.defaultIndex = 6;
    catergoryView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:catergoryView];
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@50);
        make.bottom.equalTo(mainView.mas_top);
    }];
    
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@"热门", @"新上榜", @"连载", @"生活家",@"世间事", @"@IT", @"市集", @"七日热门", @"三十日热门"];
    }
    return _titles;
}


/**监听item点击*/
- (void)catergoryView:(BPFlowCatergoryView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了%zd个item", indexPath.item);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BPTopSliderCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPTopSliderCategoryCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0f green:(arc4random() % 255) / 255.0f blue:(arc4random() % 255) / 255.0f alpha:1.0];
    cell.title = _titles[indexPath.item];
    return cell;
}


@end

