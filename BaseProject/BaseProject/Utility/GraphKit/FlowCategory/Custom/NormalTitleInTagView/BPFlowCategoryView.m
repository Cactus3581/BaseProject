//
//  BPFlowCategoryView.m
//  BaseProject
//
//  Created by Ryan on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPFlowCategoryView.h"
#import "BPFlowCategoryTagView.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"

static NSString *identifier  = @"cell";

@interface BPFlowCategoryView ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCategoryTagViewDelegate>
@property (nonatomic, weak) UICollectionView *contentCollectionView;
@property (nonatomic, weak) BPFlowCategoryTagView *categoryView;
@property (nonatomic, strong,readwrite) NSMutableDictionary *vcCacheDic;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UIView *moveLineView;
@end

@implementation BPFlowCategoryView

@synthesize lineHidden = _lineHidden;

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

// 解决屏幕旋转问题
- (void)layoutSubviews {
    [super layoutSubviews];
    [self performBatchUpdates];
}

- (void)performBatchUpdates {
    [self.contentCollectionView performBatchUpdates:nil completion:nil];
}

- (void)initializeSubViews {
    self.backgroundColor = kWhiteColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    //layout.estimatedItemSize = CGSizeMake(self.width, self.height-40);
    //layout.itemSize = CGSizeMake(self.width, self.height-40);
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
    
    BPFlowCategoryTagView * categoryView = [[BPFlowCategoryTagView alloc] init];
    categoryView.backgroundColor = kWhiteColor;
    _categoryView = categoryView;
    [self addSubview:categoryView];
    categoryView.scrollView = contentCollectionView;//必须设置关联的scrollview
    categoryView.delegate = self;//监听item按钮点击
    [self configDefaultPropery];
    [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    _lineView = lineView;
    lineView.backgroundColor = kThemeColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(categoryView);
        make.height.mas_equalTo(kOnePixel);
    }];
    
    [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(categoryView.mas_bottom);
    }];
}

- (void)configDefaultPropery {
    self.categoryView.defaultIndex = 0;//默认显示的下标
    /* 关于横线*/
    self.categoryView.bottomLineEable = YES;//开启底部线条
    self.categoryView.bottomLineHeight = 3.0f;//横线高度
    self.categoryView.bottomLineWidth = 15.0f;//横线宽度
    self.categoryView.bottomLineColor = kExplicitColor;//下方横线颜色
    self.categoryView.bottomLineSpacingFromTitleBottom = 4;//设置底部线条距离item底部的距离
    self.categoryView.bottomLineCornerRadius = YES;
    
    /* 关于缩放*/
    self.categoryView.scaleEnable = NO;//是否开启缩放
    //self.categoryView.scaleRatio = 1.01f;//缩放比例
    
    /* 关于cell 间距*/
    self.categoryView.itemSpacing = 35;//item间距
    self.categoryView.edgeSpacing = 25;//左右边缘间距
    
    /* 关于字体*/
    self.categoryView.titleColorChangeEable = YES;//是否开启文字颜色变化效果
    self.categoryView.titleColorChangeGradually = NO;//设置文字左右渐变
    self.categoryView.titleColor = kThemeColor;//item颜色
    self.categoryView.titleSelectColor = kDarkTextColor;//item选中颜色
    self.categoryView.titleFont = [UIFont systemFontOfSize:15];//item字体
    self.categoryView.titleSelectFont = [UIFont fontOfSize:15 weight:UIFontWeightMedium];//item选中字体
    
    /* 关于动画*/
    self.categoryView.clickedAnimationDuration = 0.25;//点击item后各个控件动画的时间，默认0.3秒
    self.categoryView.scrollWithAnimaitonWhenClicked = NO;//禁用点击item滚动scrollView的动画
    self.categoryView.holdLastIndexAfterUpdate = NO;//刷新后是否保持在原来的index上
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kWhiteColor;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self displayWithCollectionView:collectionView cell:cell forItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    //[self displayWithCollectionView:collectionView cell:cell forItemAtIndexPath:indexPath];
}

- (void)displayWithCollectionView:(UICollectionView *)collectionView cell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = self.vcCacheDic[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (!vc) {
        if (_delegate && [_delegate respondsToSelector:@selector(flowCategoryView:cellForItemAtIndexPath:)]) {
            vc =  [_delegate flowCategoryView:self cellForItemAtIndexPath:indexPath.row];
            [self.vcCacheDic setObject:vc forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        }
    }
    //vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
}

#pragma mark - reloadData methods

#warning collectionView的reloadData

- (void)bp_realoadData {
    [self.vcCacheDic removeAllObjects];
    [self.categoryView bp_realoadData];
    [self.contentCollectionView reloadData];
}

- (void)bp_realoadDataForTag {
    [self.categoryView bp_realoadData];
}

- (void)bp_realoadDataForContentView {
    [self.vcCacheDic removeAllObjects];
    [self.contentCollectionView reloadData];
}

#pragma mark - delegate methods

- (void)categoryView:(BPFlowCategoryTagView *)categoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCategoryView:didSelectItemAtIndex:)]) {
        [self.delegate flowCategoryView:self didSelectItemAtIndex:indexPath.row];
    }
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
        [_categoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_tagViewHeight);
        }];
    }
}

- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        _titles = titles;
        if (titles.count>=2) {
            [self.button removeFromSuperview];
            [self.moveLineView removeFromSuperview];
            _categoryView.titles = _titles;//数据源titles，必须设置;
        } else {
            [self handleDataWhenExcept];
        }
    }
}

- (void)handleDataWhenExcept {
    if (_titles.count == 1) {
        if (self.button) {
            [self.button setTitle:_titles.firstObject forState:UIControlStateNormal];
            return;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button = button;
        [self.categoryView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.categoryView);
        }];
        [button setTitle:_titles.firstObject forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
        button.adjustsImageWhenDisabled = NO;
        button.highlighted = NO;
        [button setTitleColor: kDarkTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontOfSize:15 weight:UIFontWeightMedium];
        
        UIView *moveLineView = [[UIView alloc] init];
        _moveLineView = moveLineView;
        [self.categoryView addSubview:moveLineView];
        [moveLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.categoryView);
            make.bottom.equalTo(self.categoryView).offset(-4);
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(3);
        }];
        moveLineView.backgroundColor = kExplicitColor;
        moveLineView.layer.cornerRadius = 1.5;
    } else {
        BPLog(@"no happen");
    }
}

- (void)clickAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCategoryView:didSelectItemAtIndex:)]) {
        [self.delegate flowCategoryView:self didSelectItemAtIndex:0];
    }
}

- (void)setFlowTagViewColor:(UIColor *)flowTagViewColor {
    _flowTagViewColor = flowTagViewColor;
    self.categoryView.backgroundColor = _flowTagViewColor;
}

- (void)setClickedAnimationDuration:(NSTimeInterval)clickedAnimationDuration {
    _clickedAnimationDuration = clickedAnimationDuration;
    self.categoryView.clickedAnimationDuration = clickedAnimationDuration;
}

- (void)setScrollWithAnimaitonWhenClicked:(BOOL)scrollWithAnimaitonWhenClicked  {
    _scrollWithAnimaitonWhenClicked = scrollWithAnimaitonWhenClicked;
    self.categoryView.scrollWithAnimaitonWhenClicked = scrollWithAnimaitonWhenClicked;
}

#warning collectionView的默认跳转
- (void)setDefaultIndex:(NSUInteger)defaultIndex {
    _defaultIndex = defaultIndex;
    _categoryView.defaultIndex = defaultIndex;
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    _categoryView.itemSpacing = itemSpacing;
}

- (void)setEdgeSpacing:(CGFloat)edgeSpacing {
    _edgeSpacing = edgeSpacing;
    _categoryView.edgeSpacing = edgeSpacing;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _categoryView.titleFont = titleFont;
}

- (void)setTitleSelectFont:(UIFont *)titleSelectFont {
    _titleSelectFont = titleSelectFont;
    _categoryView.titleSelectFont = titleSelectFont;
}

- (void)setTitleColorChangeEable:(BOOL)titleColorChangeEable {
    _titleColorChangeEable = titleColorChangeEable;
    _categoryView.titleColorChangeEable = titleColorChangeEable;
}

- (void)setTitleColorChangeGradually:(BOOL)titleColorChangeGradually {
    _titleColorChangeGradually = titleColorChangeGradually;
    _categoryView.titleColorChangeGradually = titleColorChangeGradually;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _categoryView.titleColor = titleColor;
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor {
    _titleSelectColor = titleSelectColor;
    _categoryView.titleSelectColor = titleSelectColor;
}

- (void)setScaleEnable:(BOOL)scaleEnable {
    _scaleEnable = scaleEnable;
    _categoryView.scaleEnable = scaleEnable;
}

- (void)setScaleRatio:(CGFloat)scaleRatio {
    _scaleRatio = scaleRatio;
    _categoryView.scaleRatio = scaleRatio;
}

- (void)setBottomLineEable:(BOOL)bottomLineEable {
    _bottomLineEable = bottomLineEable;
    _categoryView.bottomLineEable = bottomLineEable;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    _categoryView.bottomLineColor = bottomLineColor;
}

- (void)setBottomLineHeight:(CGFloat)bottomLineHeight {
    _bottomLineHeight = bottomLineHeight;
    _categoryView.bottomLineHeight = bottomLineHeight;
}

- (void)setBottomLineWidth:(CGFloat)bottomLineWidth {
    _bottomLineWidth = bottomLineWidth;
    _categoryView.bottomLineWidth = bottomLineWidth;
}

- (void)setBottomLineCornerRadius:(BOOL)bottomLineCornerRadius {
    _bottomLineCornerRadius = bottomLineCornerRadius;
    _categoryView.bottomLineCornerRadius = bottomLineCornerRadius;
}

- (void)setBottomLineSpacingFromTitleBottom:(CGFloat)bottomLineSpacingFromTitleBottom {
    _bottomLineSpacingFromTitleBottom = bottomLineSpacingFromTitleBottom;
    _categoryView.bottomLineSpacingFromTitleBottom = bottomLineSpacingFromTitleBottom;
}

- (void)setBackEllipseEable:(BOOL)backEllipseEable {
    _backEllipseEable = backEllipseEable;
    _categoryView.backEllipseEable = backEllipseEable;
}

- (void)setBackEllipseColor:(UIColor *)backEllipseColor {
    _backEllipseColor = backEllipseColor;
    _categoryView.backEllipseColor = backEllipseColor;
}

- (void)setBackEllipseSize:(CGSize)backEllipseSize {
    _backEllipseSize = backEllipseSize;
    _categoryView.backEllipseSize = backEllipseSize;
}

- (void)setHoldLastIndexAfterUpdate:(BOOL)holdLastIndexAfterUpdate {
    _holdLastIndexAfterUpdate = holdLastIndexAfterUpdate;
    _categoryView.holdLastIndexAfterUpdate = holdLastIndexAfterUpdate;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    _lineView.backgroundColor = lineColor;
}

- (void)setLineHidden:(BOOL)lineHidden {
    _lineHidden = lineHidden;
    _lineView.hidden = lineHidden;
}

- (BOOL)isLineHidden {
    return _lineView.hidden;
}

- (void)dealloc {
}

@end
