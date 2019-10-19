//
//  BPCardPageCollectionViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/10/19.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPCardPageCollectionViewController.h"
#import "UIView+BPAdd.h"
#import "BPCycleCollectionViewFlowLayout.h"
#import "BPCycleCollectionViewCell.h"

@interface BPCardPageCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger lastContentOffset;
@end

@implementation BPCardPageCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentIndex = 0;
    [self initializeViews];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.x;//判断上下滑动时
}

//将要结束拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    BPLog(@"3 - 将要结束拖拽");

    //判断左右滑动时
    if (scrollView.contentOffset.x < self.lastContentOffset ){
        //向右
        if (self.currentIndex<=0) {
            return;
        }
        --self.currentIndex;
        BPLog(@"右滑 = %ld",self.currentIndex);
    } else if (scrollView. contentOffset.x > self.lastContentOffset ){
        //向左
        if (self.currentIndex>=4) {
            return;
        }
        ++self.currentIndex;
        
        BPLog(@"左滑 = %ld",self.currentIndex);
    } else {
        return;
    }
    [self sccrollTo];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    BPLog(@"5 - 已经结束拖拽");
    if (decelerate == NO) {
        BPLog(@"scrollView停止滚动，完全静止"); //不走这个log？
    } else {
    }
    [self sccrollTo];
}

//开始减速
- (void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView {
    BPLog(@"6 - 开始减速 = %ld",self.currentIndex);
    [self sccrollTo];
}

- (void)sccrollTo {
    if (self.currentIndex>4 || self.currentIndex<0) {
        return;
    }
    //松开手指滑动开始减速的时候，设置滑动动画
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)initializeViews {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.centerY.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    [self.collectionView reloadData];
}

#pragma mark - 布局collectionview
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView = collectionView;
//        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        //_collectionView.bounces = YES;
        //_collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.backgroundColor = kLightGrayColor;
        [_collectionView registerNib:[BPCycleCollectionViewCell bp_loadNib] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPCycleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kRandomColor;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//设定Cell尺寸，定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width-30, collectionView.height);
}

//设定Cell间距，设定指定区内Cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

//设定行间距，设定指定区内Cell的最小行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


