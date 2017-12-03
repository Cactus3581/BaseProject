//
//  BPCollectionViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/3.
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
    [self configCollectionView];
}

- (void)configCollectionView {
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
        if (@available(iOS 9,*)) {
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
        _collectionView.backgroundColor = BPLightGrayColor;

        //_collectionView.contentInset = UIEdgeInsetsMake(headViewHeight, 0, 0, 0);
        //_collectionView.scrollIndicatorInsets = self.collectionView.contentInset;

        //nib
        //注册cell
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BPCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cell_nib_identifier];
        //注册页眉
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BPCollectionReusableHeadView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_nib_identifier];
        //注册页脚
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BPCollectionReusableFootView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer_nib_identifier];
        
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
        cell.backgroundColor = BPGreenColor;
        return cell;
    }
    BPCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_nib_identifier forIndexPath:indexPath];
    cell.backgroundColor = BPYellowColor;
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//设定Cell尺寸，定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth, cellH);
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
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//head/foot_view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header_identifier forIndexPath:indexPath];
            headerView.backgroundColor = BPPurpleColor;
            return headerView;
        }
        BPCollectionReusableHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header_nib_identifier forIndexPath:indexPath];
        headerView.backgroundColor = BPBlueColor;
        return headerView;
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        if (indexPath.section == 0) {
            UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer_identifier forIndexPath:indexPath];
            footerView.backgroundColor = BPRedColor;
            return footerView;
        }
        BPCollectionReusableFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footer_nib_identifier forIndexPath:indexPath];
        footerView.backgroundColor = BPOrangeColor;
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

- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
