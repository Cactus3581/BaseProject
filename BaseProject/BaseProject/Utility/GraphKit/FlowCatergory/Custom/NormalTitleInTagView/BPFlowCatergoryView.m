//
//  BPFlowCatergoryView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPFlowCatergoryView.h"
#import "BPFlowCatergoryTagView.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"

static NSString *identifier  = @"cell";

@interface BPFlowCatergoryView ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryTagViewDelegate>
@property (nonatomic, weak) UICollectionView *contentCollectionView;
@property (nonatomic, weak) BPFlowCatergoryTagView *catergoryView;
@property (nonatomic, strong,readwrite) NSMutableDictionary *vcCacheDic;
@end

@implementation BPFlowCatergoryView

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

- (void)initializeSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _contentCollectionView = contentCollectionView;
    contentCollectionView.backgroundColor = kWhiteColor;
    contentCollectionView.dataSource = self;
    contentCollectionView.delegate = self;
    contentCollectionView.pagingEnabled = YES;
    contentCollectionView.scrollsToTop = NO;
    contentCollectionView.showsHorizontalScrollIndicator = NO;
    [contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:contentCollectionView];
    BPFlowCatergoryTagView * catergoryView = [[BPFlowCatergoryTagView alloc] init];
    catergoryView.backgroundColor = kWhiteColor;
    _catergoryView = catergoryView;
    [self addSubview:catergoryView];
    catergoryView.scrollView = contentCollectionView;//必须设置关联的scrollview
    catergoryView.delegate = self;//监听item按钮点击
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(catergoryView.mas_bottom);
    }];
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
//        if (_delegate && [_delegate respondsToSelector:@selector(flowCatergoryView:cellForItemAtIndexPath:)]) {
//            UIViewController *childVC =  [_delegate flowCatergoryView:self cellForItemAtIndexPath:indexPath.row];
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
        vc.view.frame = cell.contentView.bounds;
        [cell.contentView addSubview:vc.view];
//        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(cell.contentView);
//        }];
    }else {
        if (_delegate && [_delegate respondsToSelector:@selector(flowCatergoryView:cellForItemAtIndexPath:)]) {
            UIViewController *childVC =  [_delegate flowCatergoryView:self cellForItemAtIndexPath:indexPath.row];
            [self.vcCacheDic setObject:childVC forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            childVC.view.frame = cell.contentView.bounds;
            [cell.contentView addSubview:childVC.view];
//            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(cell.contentView);
//            }];
        }
    }
}

#pragma mark - reloadData methods
- (void)bp_realoadData {
    [self.catergoryView bp_realoadData];
    //[self.contentCollectionView reloadData];
}

#pragma mark - delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCatergoryViewDidScroll:)]) {
        [self.delegate flowCatergoryViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCatergoryViewDidEndDecelerating:)]) {
        [self.delegate flowCatergoryViewDidEndDecelerating:self];
    }
}

#pragma mark - lazy methods
- (NSMutableDictionary *)vcCacheDic {
    if (!_vcCacheDic) {
        _vcCacheDic = [NSMutableDictionary dictionary];
    }
    return _vcCacheDic;
}

#pragma mark - setter methods
- (void)setTagViewHeight:(CGFloat)tagViewHeight {
    if (_tagViewHeight != tagViewHeight) {
        _tagViewHeight = tagViewHeight;
        [_catergoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_tagViewHeight);
        }];
    }
}

- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        _titles = titles;
        _catergoryView.titles = _titles;//数据源titles，必须设置;
    }
}

- (void)setClickedAnimationDuration:(NSTimeInterval)clickedAnimationDuration {
    if (_clickedAnimationDuration != clickedAnimationDuration) {
        _clickedAnimationDuration = clickedAnimationDuration;
        self.catergoryView.clickedAnimationDuration = clickedAnimationDuration;
    }
}

- (void)setScrollWithAnimaitonWhenClicked:(BOOL)scrollWithAnimaitonWhenClicked  {
    if (_scrollWithAnimaitonWhenClicked != scrollWithAnimaitonWhenClicked) {
        _scrollWithAnimaitonWhenClicked = scrollWithAnimaitonWhenClicked;
        self.catergoryView.scrollWithAnimaitonWhenClicked = scrollWithAnimaitonWhenClicked;
    }
}

- (void)setDefaultIndex:(NSUInteger)defaultIndex {
    if (_defaultIndex != defaultIndex) {
        _defaultIndex = defaultIndex;
        _catergoryView.defaultIndex = defaultIndex;
    }
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    if (_itemSpacing != itemSpacing) {
        _itemSpacing = itemSpacing;
        _catergoryView.itemSpacing = itemSpacing;
    }
}

- (void)setEdgeSpacing:(CGFloat)edgeSpacing {
    if (_edgeSpacing != edgeSpacing) {
        _edgeSpacing = edgeSpacing;
        _catergoryView.edgeSpacing = edgeSpacing;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
        _catergoryView.titleFont = titleFont;
    }
}

- (void)setTitleSelectFont:(UIFont *)titleSelectFont {
    if (_titleSelectFont != titleSelectFont) {
        _titleSelectFont = titleSelectFont;
        _catergoryView.titleSelectFont = titleSelectFont;
    }
}

- (void)setTitleColorChangeEable:(BOOL)titleColorChangeEable {
    if (_titleColorChangeEable != titleColorChangeEable) {
        _titleColorChangeEable = titleColorChangeEable;
        _catergoryView.titleColorChangeEable = titleColorChangeEable;
    }
}

- (void)setTitleColorChangeGradually:(BOOL)titleColorChangeGradually {
    if (_titleColorChangeGradually != titleColorChangeGradually) {
        _titleColorChangeGradually = titleColorChangeGradually;
        _catergoryView.titleColorChangeGradually = titleColorChangeGradually;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
        _catergoryView.titleColor = titleColor;
    }
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor {
    if (_titleSelectColor != titleSelectColor) {
        _titleSelectColor = titleSelectColor;
        _catergoryView.titleSelectColor = titleSelectColor;
    }
}

- (void)setScaleEnable:(BOOL)scaleEnable {
    if (_scaleEnable != scaleEnable) {
        _scaleEnable = scaleEnable;
        _catergoryView.scaleEnable = scaleEnable;
    }
}

- (void)setScaleRatio:(CGFloat)scaleRatio {
    if (_scaleRatio != scaleRatio) {
        _scaleRatio = scaleRatio;
        _catergoryView.scaleRatio = scaleRatio;
    }
}

- (void)setBottomLineEable:(BOOL)bottomLineEable {
    if (_bottomLineEable != bottomLineEable) {
        _bottomLineEable = bottomLineEable;
        _catergoryView.bottomLineEable = bottomLineEable;
    }
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    if (_bottomLineColor != bottomLineColor) {
        _bottomLineColor = bottomLineColor;
        _catergoryView.bottomLineColor = bottomLineColor;
    }
}
- (void)setBottomLineHeight:(CGFloat)bottomLineHeight {
    if (_bottomLineHeight != bottomLineHeight) {
        _bottomLineHeight = bottomLineHeight;
        _catergoryView.bottomLineHeight = bottomLineHeight;
    }
}
- (void)setBottomLineWidth:(CGFloat)bottomLineWidth {
    if (_bottomLineWidth != bottomLineWidth) {
        _bottomLineWidth = bottomLineWidth;
        _catergoryView.bottomLineWidth = bottomLineWidth;
    }
}

- (void)setBottomLineCornerRadius:(BOOL)bottomLineCornerRadius {
    if (_bottomLineCornerRadius != bottomLineCornerRadius) {
        _bottomLineCornerRadius = bottomLineCornerRadius;
        _catergoryView.bottomLineCornerRadius = bottomLineCornerRadius;
    }
}
- (void)setBottomLineSpacingFromTitleBottom:(CGFloat)bottomLineSpacingFromTitleBottom {
    if (_bottomLineSpacingFromTitleBottom != bottomLineSpacingFromTitleBottom) {
        _bottomLineSpacingFromTitleBottom = bottomLineSpacingFromTitleBottom;
        _catergoryView.bottomLineSpacingFromTitleBottom = bottomLineSpacingFromTitleBottom;
    }
}

- (void)setBackEllipseEable:(BOOL)backEllipseEable {
    if (_backEllipseEable != backEllipseEable) {
        _backEllipseEable = backEllipseEable;
        _catergoryView.backEllipseEable = backEllipseEable;
    }
}

- (void)setBackEllipseColor:(UIColor *)backEllipseColor {
    if (_backEllipseColor != backEllipseColor) {
        _backEllipseColor = backEllipseColor;
        _catergoryView.backEllipseColor = backEllipseColor;
    }
}
- (void)setBackEllipseSize:(CGSize)backEllipseSize {
    _backEllipseSize = backEllipseSize;
    _catergoryView.backEllipseSize = backEllipseSize;
}

- (void)setHoldLastIndexAfterUpdate:(BOOL)holdLastIndexAfterUpdate {
    if (_holdLastIndexAfterUpdate != holdLastIndexAfterUpdate) {
        _holdLastIndexAfterUpdate = holdLastIndexAfterUpdate;
        _catergoryView.holdLastIndexAfterUpdate = holdLastIndexAfterUpdate;
    }
}

- (void)dealloc {
}

@end
