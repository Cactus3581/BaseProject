//
//  KSSlideView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/19.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "KSSlideView.h"
#import "KSSlideCell.h"


@interface KSSlideView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong)NSIndexPath *lastPath;

@end
@implementation KSSlideView

- (instancetype)initWithSelectedColor:(NSInteger)selectedColor UnselectedColor:(NSInteger)unselectedColor Cornus:(NSInteger)cornus LabelFont:(NSInteger)labelFont TagEdge:(CGFloat)tagEdge
{
    self = [super init];
    if (self) {
        self.backgroundColor = kWhiteColor;
        _selectedColor = selectedColor;
        _unselectedColor = unselectedColor;
        _cornus = cornus;
        _labelFont = labelFont;
        _tagEdge = tagEdge;
        self.lastPath = [NSIndexPath indexPathForItem:0 inSection:1];
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumInteritemSpacing = 32/2.0f;
    flowLayout.minimumLineSpacing = 32/2.0f;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.collectionViewLayout=flowLayout;
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    _collectionView.alwaysBounceHorizontal =NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    //注册item
    [_collectionView registerClass:[KSSlideCell class] forCellWithReuseIdentifier:@"KSSlideCell"];
    self.collectionView.backgroundColor = kWhiteColor;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 32/2.0, 0, 32/2.0);
}

#pragma mark --UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.goodsArray[indexPath.row];
    /* 根据每一项的字符串确定每一项的size */
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:11]};
    CGSize size = [str boundingRectWithSize:CGSizeMake(0, 25) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:dict context:nil].size;
    size.height = 25;
    size.width += _tagEdge*2;
    return size;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.goodsArray isKindOfClass:[NSArray class]] && _goodsArray.count>0) {
        return 1;
    }
    return 0;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if ([self.goodsArray isKindOfClass:[NSArray class]]) {
        return _goodsArray.count;
    }
    return 0;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellide = @"KSSlideCell";
    
    KSSlideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellide forIndexPath:indexPath];    
    cell.nameText = self.goodsArray[indexPath.row];

    
    if (self.lastPath == indexPath) {
        cell.isSelected = YES;
    }else {
        cell.isSelected = NO;
    }
    
    //方法二
    //    NSInteger row = [indexPath row];
    //    NSInteger oldRow = [self.lastPath row];
    //    if (row == oldRow && self.lastPath!=nil) {
    //        cell.isSelected = YES;
    //    }else{
    //        cell.isSelected = NO;
    //    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //之前选中的，取消选择
    KSSlideCell *celled = (KSSlideCell* )[collectionView cellForItemAtIndexPath:self.lastPath];
    //记录当前选中的位置索引
    self.lastPath = indexPath;
    //当前选择的打勾
    KSSlideCell *cell = (KSSlideCell* )[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSelected = YES;
    celled.isSelected = NO;

    //方法二
    //    NSInteger newRow = [indexPath row];
    //    NSInteger oldRow = (self.lastPath !=nil)?[self.lastPath row]:-1;
    //    if (newRow != oldRow) {
    //        KSSlideCell *newCell = (KSSlideCell* )[collectionView cellForItemAtIndexPath:indexPath];
    //        KSSlideCell *oldCell = (KSSlideCell* )[collectionView cellForItemAtIndexPath:self.lastPath];
    //        newCell.isSelected = YES;
    //        oldCell.isSelected = NO;
    //        self.lastPath = indexPath;
    //    }else
    //    {
    //        KSSlideCell *cell = (KSSlideCell* )[collectionView cellForItemAtIndexPath:indexPath];
    //        cell.isSelected = YES;
    //    }
    //    [collectionView deselectRowAtIndexPath:indexPath animated:YES];

}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)setGoodsArray:(NSMutableArray *)goodsArray
{
    if (_goodsArray !=goodsArray) {
        _goodsArray = goodsArray;
    }
    [self.collectionView reloadData];
}

@end
