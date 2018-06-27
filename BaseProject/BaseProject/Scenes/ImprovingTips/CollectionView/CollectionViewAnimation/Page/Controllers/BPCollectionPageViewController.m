//
//  BPCollectionPageViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCollectionPageViewController.h"
#import "BPCollectionViewCell.h"
#import "MJRefresh.h"
#import "UIView+BPAdd.h"

@interface BPCollectionPageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger currentIndex;
@end

@implementation BPCollectionPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
}

- (void)initializeViews {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.collectionView reloadData];
}

#pragma mark - 布局collectionview
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
//        _collectionView.bounces = YES;
//        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.backgroundColor = kLightGrayColor;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BPCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
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
    BPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.aniamationBackView.backgroundColor = kRandomColor;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//设定Cell尺寸，定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width, collectionView.height);
}

//设定Cell间距，设定指定区内Cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设定行间距，设定指定区内Cell的最小行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设定区内边距，设定指定区的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    BPCollectionViewCell *currentCell = (BPCollectionViewCell *)cell;
    currentCell.aniamationBackView.center = currentCell.contentView.center;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    BPLog(@"1 - 将开始拖拽");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BPLog(@"2 - 图片在滚动着呢");
    BPCollectionViewCell *currentCell = (BPCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    CGRect currentRect = [currentCell convertRect:currentCell.bounds toView:self.view.window];
    if (currentRect.origin.x < 0) {
        //左滑
        NSArray *indexArray = [self.collectionView indexPathsForVisibleItems];
        for(NSIndexPath *indexPath in indexArray){
            if (indexPath.item > self.currentIndex) {
                //需要移动cell里面内容的center 以实现动画效果
                BPCollectionViewCell *cell = (BPCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                CGPoint centerPoint = cell.contentView.center;
                CGRect rect = [cell convertRect:cell.bounds toView:self.view.window];
                centerPoint.x -= rect.origin.x+CGRectGetWidth(self.collectionView.bounds)/2-self.collectionView.center.x;
                cell.aniamationBackView.center = centerPoint;
                BPLog(@"左滑 = %@",NSStringFromCGPoint(centerPoint));
                BPLog(@"indexPath = %ld",indexPath.row);
            }
        }
    }else if(currentRect.origin.x > 0){
        //右滑
        NSArray *indexArray = [self.collectionView indexPathsForVisibleItems];
        for(NSIndexPath *indexPath in indexArray){
            if (indexPath.item == self.currentIndex) {
                //需要移动cell里面内容的center 以实现动画效果
                BPCollectionViewCell *cell = (BPCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                CGPoint centerPoint = cell.contentView.center;
                CGRect rect = [cell convertRect:cell.bounds toView:self.view.window];
                centerPoint.x -= rect.origin.x+CGRectGetWidth(self.collectionView.bounds)/2-self.collectionView.center.x;
//                cell.aniamationBackView.center = centerPoint;
                BPLog(@"右滑 = %@",NSStringFromCGPoint(centerPoint));
            }
        }
    }
}

//已经结束拖拽 触发
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    BPLog(@"3 - 已经结束拖拽");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BPLog(@"4 - 已经结束减速（停止）");
    CGPoint point = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if(self.currentIndex == indexPath.item){
        return;
    }
    self.currentIndex = indexPath.item;
}

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

