//
//  BPFlowCategoryImageView.m
//  BaseProject
//
//  Created by Ryan on 2018/6/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPFlowCategoryImageView.h"
#import "BPFlowCategoryImageTagView.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"

static NSString *identifier  = @"cell";

@interface BPFlowCategoryImageView ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCategoryImageTagViewDelegate>
@property (nonatomic, weak) UICollectionView *contentCollectionView;
@property (nonatomic, weak) BPFlowCategoryImageTagView *categoryView;
@property (nonatomic, strong,readwrite) NSMutableDictionary *vcCacheDic;
@end

@implementation BPFlowCategoryImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeSubViews];
}

- (void)setTagViewHeight:(CGFloat)tagViewHeight {
    _tagViewHeight = tagViewHeight;
    if (_categoryView) {
        [_categoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_tagViewHeight);
        }];
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (_categoryView) {
        _categoryView.titles = _titles;//数据源titles，必须设置;
    }
}

- (void)reloadData {
    [self.categoryView bp_realoadData];
    [self.contentCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kWhiteColor;
    //    UIViewController *vc = self.vcCacheDic[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    //    if (vc) {
    //        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //        //vc.view.frame = cell.contentView.bounds;
    //        [cell.contentView addSubview:vc.view];
    //        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.edges.equalTo(cell.contentView);
    //        }];
    //    }else {
    //        if (_delegate && [_delegate respondsToSelector:@selector(flowCategoryView:cellForItemAtIndexPath:)]) {
    //            UIViewController *childVC =  [_delegate flowCategoryView:self cellForItemAtIndexPath:indexPath.row];
    //            [self.vcCacheDic setObject:childVC forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    //            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //            //childVC.view.frame = cell.contentView.bounds;
    //            [cell.contentView addSubview:childVC.view];
    //            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
    //                make.edges.equalTo(cell.contentView);
    //            }];
    //        }
    //    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = self.vcCacheDic[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (vc) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        vc.view.frame = cell.contentView.bounds;
        [cell.contentView addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else {
        if (_delegate && [_delegate respondsToSelector:@selector(flowCategoryView:cellForItemAtIndexPath:)]) {
            UIViewController *childVC =  [_delegate flowCategoryView:self cellForItemAtIndexPath:indexPath.row];
            [self.vcCacheDic setObject:childVC forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//            childVC.view.frame = cell.contentView.bounds;
            [cell.contentView addSubview:childVC.view];
            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
    }
}

- (void)initializeSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.contentCollectionView = contentCollectionView;
    contentCollectionView.backgroundColor = kWhiteColor;
    contentCollectionView.dataSource = self;
    contentCollectionView.delegate = self;
    contentCollectionView.pagingEnabled = YES;
    contentCollectionView.scrollsToTop = NO;
    contentCollectionView.showsHorizontalScrollIndicator = NO;
    [contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:contentCollectionView];
    
    //categoryView
    BPFlowCategoryImageTagView * categoryView = [[BPFlowCategoryImageTagView alloc] init];
    categoryView.backgroundColor = kWhiteColor;
    self.categoryView = categoryView;
    [self addSubview:categoryView];
    
    /* 关于数据*/
    //categoryView.titles = self.titles;//数据源titles，必须设置
    categoryView.defaultIndex = 0;//默认优先显示的下标
    
    /* 关于交互:滑动、点击 */
    categoryView.scrollView = contentCollectionView;//必须设置关联的scrollview
    categoryView.delegate = self;//监听item按钮点击
    
    /* 关于横线*/
    categoryView.bottomLineEable = YES;//开启底部线条
    categoryView.bottomLineHeight = 2.0f;//横线高度，默认2.0f
    categoryView.bottomLineWidth = 15.0f;//横线宽度
    categoryView.bottomLineColor = kThemeColor;//下方横线颜色
    categoryView.bottomLineSpacingFromTitleBottom = 6;//设置底部线条距离item底部的距离
    
    
    /* 关于背景图:椭圆*/
    categoryView.backEllipseEable = NO;//是否开启背后的椭圆，默认NO
    //categoryView.backEllipseColor = kGreenColor;/**椭圆颜色，默认黄色*/
    //categoryView.backEllipseSize = CGSizeMake(10, 10);/**椭圆大小，默认CGSizeZero，表示椭圆大小随文字内容而定*/
    
    /* 关于缩放*/
    categoryView.scaleEnable = YES;//是否开启缩放， 默认NO
    categoryView.scaleRatio = 1.05f;//缩放比例， 默认1.1
    
    /* 关于cell 间距*/
    categoryView.itemSpacing = 30;//item间距，默认10
    categoryView.edgeSpacing = 25;//左右边缘间距，默认20
    
    /* 关于字体*/
    categoryView.titleColorChangeEable = YES;//是否开启文字颜色变化效果
    categoryView.titleColorChangeGradually = NO;//设置文字左右渐变
    categoryView.titleColor = kLightGrayColor;
    categoryView.titleSelectColor = kBlackColor;
    categoryView.titleFont = [UIFont systemFontOfSize:15];//item字体
    
    /* 关于动画*/
    categoryView.clickedAnimationDuration = 0.3;//点击item后各个控件（底部线条和椭圆）动画的时间，默认0.3秒，可设置为0*/
    categoryView.scrollWithAnimaitonWhenClicked = NO;//禁用点击item滚动scrollView的动画
    categoryView.holdLastIndexAfterUpdate = NO;/**刷新后是否保持在原来的index上，默认NO，表示刷新后回到第0个item*/
    
    [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(categoryView.mas_bottom);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCategoryViewDidScroll:)]) {
        [self.delegate flowCategoryViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCategoryViewDidEndDecelerating:)]) {
        [self.delegate flowCategoryViewDidEndDecelerating:self];
    }
}

- (NSMutableDictionary *)vcCacheDic {
    if (!_vcCacheDic) {
        _vcCacheDic = [NSMutableDictionary dictionary];
    }
    return _vcCacheDic;
}

- (void)dealloc {

}

@end
