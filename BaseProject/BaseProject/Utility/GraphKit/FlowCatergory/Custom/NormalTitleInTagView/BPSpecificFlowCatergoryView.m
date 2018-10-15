//
//  BPSpecificFlowCatergoryView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/8/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSpecificFlowCatergoryView.h"
#import "BPFlowCatergoryTagView.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"

static NSString *identifier  = @"cell";

@interface BPSpecificFlowCatergoryView ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryTagViewDelegate>
@property (nonatomic, weak) UICollectionView *contentCollectionView;
@property (nonatomic, weak) BPFlowCatergoryTagView *catergoryView;
@property (nonatomic, strong,readwrite) NSMutableDictionary *vcCacheDic;
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, weak) UIView *moveLineView;
@end

@implementation BPSpecificFlowCatergoryView

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
    if (self.titles.count == 2) {
        CGFloat leftWidth = [self.titles.firstObject sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
        CGFloat rightWidth = [self.titles.lastObject sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
        CGFloat leftEdge = (self.width/2.0 - leftWidth)/2.0;
        CGFloat rightEdge = (self.width/2.0 - rightWidth)/2.0;
//        self.edgeSpacing = leftEdge;
        self.edgeSpacing = 0;

        [self.catergoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(leftEdge);
            make.trailing.equalTo(self).offset(-rightEdge);
        }];
        
        [self.catergoryView bp_simpleRealoadData];
    }
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
    
    BPFlowCatergoryTagView * catergoryView = [[BPFlowCatergoryTagView alloc] init];
    catergoryView.backgroundColor = kWhiteColor;
    _catergoryView = catergoryView;
    [self addSubview:catergoryView];
    catergoryView.scrollView = contentCollectionView;//必须设置关联的scrollview
    catergoryView.delegate = self;//监听item按钮点击
    [self configDefaultPropery];
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    _lineView = lineView;
    lineView.backgroundColor = kThemeColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(catergoryView);
        make.height.mas_equalTo(kOnePixel);
    }];
    
    [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(catergoryView.mas_bottom);
    }];
}

- (void)configDefaultPropery {
    self.catergoryView.defaultIndex = 0;//默认显示的下标
    /* 关于横线*/
    self.catergoryView.bottomLineEable = YES;//开启底部线条
    self.catergoryView.bottomLineHeight = 3.0f;//横线高度
    self.catergoryView.bottomLineWidth = 15.0f;//横线宽度
    self.catergoryView.bottomLineColor = kExplicitColor;//下方横线颜色
    self.catergoryView.bottomLineSpacingFromTitleBottom = 4;//设置底部线条距离item底部的距离
    self.catergoryView.bottomLineCornerRadius = YES;
    
    /* 关于缩放*/
    self.catergoryView.scaleEnable = NO;//是否开启缩放
    //self.catergoryView.scaleRatio = 1.01f;//缩放比例
    
    /* 关于cell 间距*/
    self.catergoryView.itemSpacing = 35;//item间距
    self.catergoryView.edgeSpacing = 25;//左右边缘间距
    
    /* 关于字体*/
    self.catergoryView.titleColorChangeEable = YES;//是否开启文字颜色变化效果
    self.catergoryView.titleColorChangeGradually = NO;//设置文字左右渐变
    self.catergoryView.titleColor = kThemeColor;//item颜色
    self.catergoryView.titleSelectColor = kDarkTextColor;//item选中颜色
    self.catergoryView.titleFont = [UIFont systemFontOfSize:15];//item字体
    self.catergoryView.titleSelectFont = [UIFont fontOfSize:15 weight:UIFontWeightMedium];//item选中字体
    
    /* 关于动画*/
    self.catergoryView.clickedAnimationDuration = 0.25;//点击item后各个控件动画的时间，默认0.3秒
    self.catergoryView.scrollWithAnimaitonWhenClicked = NO;//禁用点击item滚动scrollView的动画
    self.catergoryView.holdLastIndexAfterUpdate = NO;//刷新后是否保持在原来的index上
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
        if (_delegate && [_delegate respondsToSelector:@selector(flowCatergoryView:cellForItemAtIndexPath:)]) {
            vc =  [_delegate flowCatergoryView:self cellForItemAtIndexPath:indexPath.row];
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
    [self.catergoryView bp_realoadData];
    [self.contentCollectionView reloadData];
}

- (void)bp_realoadDataForTag {
    [self.catergoryView bp_realoadData];
}

- (void)bp_realoadDataForContentView {
    [self.vcCacheDic removeAllObjects];
    [self.contentCollectionView reloadData];
}

#pragma mark - delegate methods

- (void)catergoryView:(BPFlowCatergoryTagView *)catergoryView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCatergoryView:didSelectItemAtIndex:)]) {
        [self.delegate flowCatergoryView:self didSelectItemAtIndex:indexPath.row];
    }
}

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
        if (titles.count > 2) {
            [self.button removeFromSuperview];
            [self.moveLineView removeFromSuperview];
            _catergoryView.titles = _titles;//数据源titles，必须设置;
        } else {
            [self handlaDataWhenExcept];
        }
    }
}

- (void)handlaDataWhenExcept {
    if (_titles.count == 1) {
        if (self.button) {
            [self.button setTitle:_titles.firstObject forState:UIControlStateNormal];
            return;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        self.button = button;
        [self.catergoryView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.catergoryView);
        }];
        [button setTitle:_titles.firstObject forState:UIControlStateNormal];
        button.adjustsImageWhenHighlighted = NO;
        button.adjustsImageWhenDisabled = NO;
        button.highlighted = NO;
        [button setTitleColor: kDarkTextColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontOfSize:15 weight:UIFontWeightMedium];
        
        UIView *moveLineView = [[UIView alloc] init];
        _moveLineView = moveLineView;
        [self.catergoryView addSubview:moveLineView];
        [moveLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.catergoryView);
            make.bottom.equalTo(self.catergoryView).offset(-4);
            make.width.mas_equalTo(15);
            make.height.mas_equalTo(3);
        }];
        moveLineView.backgroundColor = kExplicitColor;
        moveLineView.layer.cornerRadius = 1.5;
    } else if (_titles.count == 2) {
        CGFloat leftWidth = [self.titles.firstObject sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
        CGFloat rightWidth = [self.titles.lastObject sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}].width;
        CGFloat leftEdge = (kScreenWidth/2.0 - leftWidth)/2.0;
        CGFloat rightEdge = (kScreenWidth/2.0 - rightWidth)/2.0;
        
//        self.edgeSpacing = leftEdge;
        
        self.edgeSpacing = 0;
        [self.catergoryView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(leftEdge);
            make.trailing.equalTo(self).offset(-rightEdge);
        }];
        _catergoryView.titles = _titles;//数据源titles，必须设置;
    } else {
        BPLog(@"no happen except only = 0");
    }
}

- (void)clickAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(flowCatergoryView:didSelectItemAtIndex:)]) {
        [self.delegate flowCatergoryView:self didSelectItemAtIndex:0];
    }
}

- (void)setFlowTagViewColor:(UIColor *)flowTagViewColor {
    _flowTagViewColor = flowTagViewColor;
    self.catergoryView.backgroundColor = _flowTagViewColor;
}

- (void)setClickedAnimationDuration:(NSTimeInterval)clickedAnimationDuration {
    _clickedAnimationDuration = clickedAnimationDuration;
    self.catergoryView.clickedAnimationDuration = clickedAnimationDuration;
}

- (void)setScrollWithAnimaitonWhenClicked:(BOOL)scrollWithAnimaitonWhenClicked  {
    _scrollWithAnimaitonWhenClicked = scrollWithAnimaitonWhenClicked;
    self.catergoryView.scrollWithAnimaitonWhenClicked = scrollWithAnimaitonWhenClicked;
}

#warning collectionView的默认跳转
- (void)setDefaultIndex:(NSUInteger)defaultIndex {
    _defaultIndex = defaultIndex;
    _catergoryView.defaultIndex = defaultIndex;
}

- (void)setItemSpacing:(CGFloat)itemSpacing {
    _itemSpacing = itemSpacing;
    _catergoryView.itemSpacing = itemSpacing;
}

- (void)setEdgeSpacing:(CGFloat)edgeSpacing {
    _edgeSpacing = edgeSpacing;
    _catergoryView.edgeSpacing = edgeSpacing;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _catergoryView.titleFont = titleFont;
}

- (void)setTitleSelectFont:(UIFont *)titleSelectFont {
    _titleSelectFont = titleSelectFont;
    _catergoryView.titleSelectFont = titleSelectFont;
}

- (void)setTitleColorChangeEable:(BOOL)titleColorChangeEable {
    _titleColorChangeEable = titleColorChangeEable;
    _catergoryView.titleColorChangeEable = titleColorChangeEable;
}

- (void)setTitleColorChangeGradually:(BOOL)titleColorChangeGradually {
    _titleColorChangeGradually = titleColorChangeGradually;
    _catergoryView.titleColorChangeGradually = titleColorChangeGradually;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _catergoryView.titleColor = titleColor;
}

- (void)setTitleSelectColor:(UIColor *)titleSelectColor {
    _titleSelectColor = titleSelectColor;
    _catergoryView.titleSelectColor = titleSelectColor;
}

- (void)setScaleEnable:(BOOL)scaleEnable {
    _scaleEnable = scaleEnable;
    _catergoryView.scaleEnable = scaleEnable;
}

- (void)setScaleRatio:(CGFloat)scaleRatio {
    _scaleRatio = scaleRatio;
    _catergoryView.scaleRatio = scaleRatio;
}

- (void)setBottomLineEable:(BOOL)bottomLineEable {
    _bottomLineEable = bottomLineEable;
    _catergoryView.bottomLineEable = bottomLineEable;
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    _catergoryView.bottomLineColor = bottomLineColor;
}

- (void)setBottomLineHeight:(CGFloat)bottomLineHeight {
    _bottomLineHeight = bottomLineHeight;
    _catergoryView.bottomLineHeight = bottomLineHeight;
}

- (void)setBottomLineWidth:(CGFloat)bottomLineWidth {
    _bottomLineWidth = bottomLineWidth;
    _catergoryView.bottomLineWidth = bottomLineWidth;
}

- (void)setBottomLineCornerRadius:(BOOL)bottomLineCornerRadius {
    _bottomLineCornerRadius = bottomLineCornerRadius;
    _catergoryView.bottomLineCornerRadius = bottomLineCornerRadius;
}

- (void)setBottomLineSpacingFromTitleBottom:(CGFloat)bottomLineSpacingFromTitleBottom {
    _bottomLineSpacingFromTitleBottom = bottomLineSpacingFromTitleBottom;
    _catergoryView.bottomLineSpacingFromTitleBottom = bottomLineSpacingFromTitleBottom;
}

- (void)setBackEllipseEable:(BOOL)backEllipseEable {
    _backEllipseEable = backEllipseEable;
    _catergoryView.backEllipseEable = backEllipseEable;
}

- (void)setBackEllipseColor:(UIColor *)backEllipseColor {
    _backEllipseColor = backEllipseColor;
    _catergoryView.backEllipseColor = backEllipseColor;
}

- (void)setBackEllipseSize:(CGSize)backEllipseSize {
    _backEllipseSize = backEllipseSize;
    _catergoryView.backEllipseSize = backEllipseSize;
}

- (void)setHoldLastIndexAfterUpdate:(BOOL)holdLastIndexAfterUpdate {
    _holdLastIndexAfterUpdate = holdLastIndexAfterUpdate;
    _catergoryView.holdLastIndexAfterUpdate = holdLastIndexAfterUpdate;
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
