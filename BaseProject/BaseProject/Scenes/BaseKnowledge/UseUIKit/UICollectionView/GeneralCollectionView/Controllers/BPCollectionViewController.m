//
//  BPCollectionViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/12/3.
//  Copyright © 2017年 cactus. All rights reserved.
//

//1. loadView  Nib
//2. flowLayout使用及自定义

#import "BPCollectionViewController.h"
#import "BPCollectionReusableHeadView.h"
#import "BPCollectionReusableFootView.h"
#import "BPCollectionViewCell.h"
#import "MJRefresh.h"

@interface BPCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSIndexPath *selectedIndex;
@end

static CGFloat section_headerH = 30;
static CGFloat section_footerH = 30;
static CGFloat cellH = 50;

static NSString *cell_identifier = @"cell";
static NSString *header_identifier = @"header";
static NSString *footer_identifier = @"footer";

static NSString *cell_nib_identifier = @"nib_cell";
static NSString *header_nib_identifier = @"nib_header";
static NSString *footer_nib_identifier = @"nib_footer";

@implementation BPCollectionViewController

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
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 20;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        if (kiOS9) {
            flowLayout.sectionHeadersPinToVisibleBounds = YES;//悬停
            flowLayout.sectionFootersPinToVisibleBounds = YES;
        }

        [flowLayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, section_headerH)];
        [flowLayout setFooterReferenceSize:CGSizeMake(kScreenWidth, section_footerH)];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, cellH);

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.backgroundColor = kLightGrayColor;

        //_collectionView.contentInset = UIEdgeInsetsMake(headViewHeight, 0, 0, 0);
        //_collectionView.scrollIndicatorInsets = self.collectionView.contentInset;

        //nib
        //注册cell
        [_collectionView registerNib:[BPCollectionViewCell bp_loadNib] forCellWithReuseIdentifier:cell_nib_identifier];
        //注册页眉
        [_collectionView registerNib:[BPCollectionReusableHeadView bp_loadNib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_nib_identifier];
        //注册页脚
        [_collectionView registerNib:[BPCollectionReusableFootView bp_loadNib] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer_nib_identifier];
        
        //纯代码
        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cell_identifier];
        //注册页眉
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_identifier];
        //注册页脚
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer_identifier];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier forIndexPath:indexPath];
        cell.backgroundColor = kGreenColor;
        return cell;
    }
    BPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_nib_identifier forIndexPath:indexPath];
    cell.backgroundColor = kYellowColor;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//设定Cell尺寸，定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.width/2.0-1, cellH);
    
//    if (((indexPath.row+1) % 3) == 0) {
//        return CGSizeMake((kScreenWidth - (int)(kScreenWidth/3)*2),80);
//    }
//    return CGSizeMake((int)(kScreenWidth/3), 80);
}

//设定Cell间距，设定指定区内Cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设定行间距，设定指定区内Cell的最小行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//设定区内边距，设定指定区的内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section ==0) {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//head/foot_view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header_identifier forIndexPath:indexPath];
            headerView.backgroundColor = kPurpleColor;
            return headerView;
        }
        BPCollectionReusableHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header_nib_identifier forIndexPath:indexPath];
        headerView.backgroundColor = kBlueColor;
        return headerView;
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        if (indexPath.section == 0) {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer_identifier forIndexPath:indexPath];
            footerView.backgroundColor = kRedColor;
            return footerView;
        }
        BPCollectionReusableFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer_nib_identifier forIndexPath:indexPath];
        footerView.backgroundColor = kOrangeColor;
        return footerView;
    }
    return nil;
}

//设定页眉的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, section_headerH);
}

//设定页脚的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, section_footerH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView reloadData];
}

//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//
//}

//已经结束拖拽 触发
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    BPLog(@"3 - 已经结束拖拽");
    
    CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    CGPoint targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2, CGRectGetHeight(self.collectionView.bounds) / 2);
    NSIndexPath *indexPath = nil;
    NSInteger i = 0;
    while (indexPath == nil) {
        targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2 + 10*i, CGRectGetHeight(self.collectionView.bounds) / 2);
        indexPath = [self.collectionView indexPathForItemAtPoint:targetCenter];
        i++;
    }
    self.selectedIndex = indexPath;
    //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes) {
        *targetContentOffset = CGPointMake(attributes.center.x - CGRectGetWidth(self.collectionView.bounds)/2, originalTargetContentOffset.y);
        
        BPLog(@"targetContentOffset = %.2f",targetContentOffset->x);
    } else {
        BPLog(@"center is %@; indexPath is {%@, %@}; cell is %@",NSStringFromCGPoint(targetCenter), @(indexPath.section), @(indexPath.item), attributes);
    }
    //    [self.collectionView setContentOffset:CGPointMake(targetContentOffset->x, targetContentOffset->y) animated:YES];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
}

@end
