//
//  BPCalenderView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalenderView.h"
#import "BPBaseCollectionView.h"
#import "BPCalendarCollectionCell.h"
#import "BPCalendarCollectionHeadView.h"
#import <Masonry.h>

@interface BPCalenderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) BPBaseCollectionView *calenderCollectionView;
@property (strong, nonatomic) NSArray *datArray;
@end

@implementation BPCalenderView
- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = BPWhiteColor;
    }
    return self;
}

#pragma mark - 布局collectionview
- (void)configureCollectionView {
    [self addSubview:self.calenderCollectionView];
    [self.calenderCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0.0f;//设置同一排中 间隔的cell最小间距。
    flowLayout.minimumLineSpacing = 0.0f;//设置同一区内最小行间距
    _calenderCollectionView.collectionViewLayout = flowLayout;
    _calenderCollectionView.dataSource = self;
    _calenderCollectionView.delegate = self;
    _calenderCollectionView.bounces = NO;
    _calenderCollectionView.scrollEnabled = NO;
    _calenderCollectionView.alwaysBounceVertical = NO;
    _calenderCollectionView.showsVerticalScrollIndicator = NO;
    
    //注册cell
    [_calenderCollectionView registerClass:[BPCalendarCollectionCell class] forCellWithReuseIdentifier:@"BPCalendarCollectionCell"];
    
    //注册页眉
    [_calenderCollectionView registerClass:[BPCalendarCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BPCalendarCollectionHeadView"];//表格头部视图
}

- (BPBaseCollectionView *)calenderCollectionView {
    if (!_calenderCollectionView) {
        _calenderCollectionView = [[BPBaseCollectionView alloc] init];
    }
    return _calenderCollectionView;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPCalendarCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPCalendarCollectionCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//设定Cell尺寸，定义某个Cell的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(0, 0);
}

//设定Cell间距，设定指定区内Cell的最小间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设定行间距，设定指定区内Cell的最小行距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//设定区内边距，设定指定区的内边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//head/foot_view
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        BPCalendarCollectionHeadView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BPCalendarCollectionHeadView" forIndexPath:indexPath];
        return sectionView;
    }
    return nil;
}

//设定页眉的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(0, 0);
}

//设定页脚的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    return CGSizeMake(0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (NSArray *)datArray {
    if (!_datArray) {
        _datArray = [NSArray array];
    }
    return _datArray;
}

@end
