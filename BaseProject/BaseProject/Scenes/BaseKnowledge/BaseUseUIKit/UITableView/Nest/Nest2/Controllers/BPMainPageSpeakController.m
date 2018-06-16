//
//  BPMainPageSpeakController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMainPageSpeakController.h"
#import "BPMainPageSpeakBannerCollectionViewCell.h"
#import "BPMainPageSpeakTopCategoryCollectionViewCell.h"
#import "BPMainPageSpeakClassifiedHeaderView.h"
#import "BPMainPageSpeakBottomCategoryCollectionViewCell.h"
#import "MJRefresh.h"

static NSString *cell_identifier1 = @"BPMainPageSpeakBannerCollectionViewCell";
static NSString *cell_identifier2 = @"BPMainPageSpeakTopCategoryCollectionViewCell";
static NSString *cell_identifier4 = @"BPMainPageSpeakBottomCategoryCollectionViewCell";
static NSString *header_identifier1 = @"BPMainPageSpeakClassifiedHeaderView";

static NSString *notificationNameFromInsideScrollEnable = @"notificationNameFromInsideScrollEnable";//外部可以滑动，内部互斥
static NSString *notificationNameFromInsideScrollNotEnable = @"notificationNameFromInsideScrollNotEnable";//外部不可以滑动，内部互斥
static NSString *notificationNameFromOutsideScrollNotEnable = @"notificationNameFromOutsideScrollNotEnable";//外部不可以滑动，内部互斥

@interface BPMainPageSpeakController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,assign) BOOL isScrollEnabled;
@property (nonatomic,weak) BPMainPageSpeakBottomCategoryCollectionViewCell * bottomCategoryCell;

@end

@implementation BPMainPageSpeakController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCollectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollEnabled) name:notificationNameFromInsideScrollEnable object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollNotEnabled) name:notificationNameFromInsideScrollNotEnable object:nil];
    self.isScrollEnabled = YES;
}

//外现在外部可以滑动了
- (void)changeScrollEnabled {
//    BPLog(@"外部收到可以滑动的通知，");

    self.isScrollEnabled = YES;
    if (!self.collectionView.scrollEnabled) {
//        self.collectionView.scrollEnabled = YES;
    }
}

//外现在外部不可以滑动了
- (void)changeScrollNotEnabled {
//    BPLog(@"外部收到不可以滑动的通知，");

    self.isScrollEnabled = NO;
    if (self.collectionView.scrollEnabled) {
//        self.collectionView.scrollEnabled = NO;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //BPMainPageSpeakBottomCategoryCollectionViewCell * cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier4 forIndexPath:[NSIndexPath indexPathForItem:0 inSection:3]];
    CGRect cellRect = [_collectionView convertRect:self.bottomCategoryCell.frame toView:_collectionView];
    CGFloat bottomCellOffset = cellRect.origin.y;//计算_collectionView上的cell相对于_collectionView的frame。
    if (scrollView.contentOffset.y >= bottomCellOffset || !self.isScrollEnabled) { //说明到达内部列表区了
        scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        if (scrollView.scrollEnabled) {
//            scrollView.scrollEnabled = NO;
        }
        if (self.isScrollEnabled) {
            self.isScrollEnabled = NO;
            //BPLog(@"说明到达内部列表区了，外部发通知告知内部可以滑动了");
            [[NSNotificationCenter defaultCenter] postNotificationName:notificationNameFromOutsideScrollNotEnable object:nil];//到顶通知父视图改变状态
        }
    }else {
        if (!self.isScrollEnabled) {//子视图没到顶部
            scrollView.contentOffset = CGPointMake(0, bottomCellOffset);
        }
        
//        BPLog(@"外部可以滑动");
        if (!scrollView.scrollEnabled) {
//            scrollView.scrollEnabled = YES;
        }
    }
}
#pragma mark - 布局collectionview
- (void)configureCollectionView {
    _collectionView.backgroundColor = kWhiteColor;
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.bounces = YES;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = kWhiteColor;
    

    [self.collectionView registerClass:[BPMainPageSpeakBannerCollectionViewCell class] forCellWithReuseIdentifier:cell_identifier1];

    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BPMainPageSpeakTopCategoryCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cell_identifier2];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([BPMainPageSpeakClassifiedHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_identifier1];

    
    [self.collectionView registerClass:[BPMainPageSpeakBottomCategoryCollectionViewCell class] forCellWithReuseIdentifier:cell_identifier4];

    //self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset;
    [self setUpRefresh];
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 4;
            break;
        case 2:
            return 2;
            break;
            
        case 3:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BPMainPageSpeakBannerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier1 forIndexPath:indexPath];
        return cell;
    } if (indexPath.section == 1) {
        BPMainPageSpeakTopCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier2 forIndexPath:indexPath];
        return cell;
    }if (indexPath.section == 2) {
        BPMainPageSpeakTopCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier2 forIndexPath:indexPath];
        return cell;
    }else {
        BPMainPageSpeakBottomCategoryCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier4 forIndexPath:indexPath];
        self.bottomCategoryCell = cell;
        [cell setScrollView:self.collectionView];
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(20, 0, 0, 0);
    } else if (section == 1 ) {
        return UIEdgeInsetsMake(15, 15, 20, 15);
    } else if (section == 2 ) {
        return UIEdgeInsetsMake(15, 15, 0, 15);
    }
    return UIEdgeInsetsMake(15, 0, 0, 0);
}

#pragma mark --UICollectionViewDelegateFlowLayout
//设定Cell尺寸，定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.width, 110);
    }else if (indexPath.section == 1) {
        return CGSizeMake(floor((self.view.width-15*2-10)/2.0), 69);
    }else if (indexPath.section == 2) {
        return CGSizeMake(floor((self.view.width-15*2-10)/2.0), 69);
    }
    return CGSizeMake(self.view.width, self.view.height);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1 ||  section == 2) {
        return 10;
    }
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 1 ||  section == 2) {
        return 10;
    }
    return 0;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 ) {
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            BPMainPageSpeakClassifiedHeaderView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:header_identifier1 forIndexPath:indexPath];
            return sectionView;
        }
    }
    return nil;
}

//设定页眉的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 2 ) {
        return CGSizeMake(self.view.width, 39);
    }
    return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView reloadData];
}

#pragma mark - 请求数据
/*集成刷新组件*/
- (void) setUpRefresh {
//    [self.collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
//    [self.collectionView addHeaderWithTarget:self action:@selector(configureData)];
//    self.collectionView.headerPullToRefreshText = kHeaderPullToRefreshText;
//    self.collectionView.headerReleaseToRefreshText = kHeaderReleaseToRefreshText;
//    self.collectionView.headerRefreshingText = kHeaderRefreshingText;
}

- (void)endHeadRefresh {
//    [self.collectionView headerEndRefreshing];
}

- (void)configureData {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
