//
//  BPFlowMainCatergoryView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPFlowMainCatergoryView.h"
#import "BPFlowCatergoryView.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"

static NSString *identifier  = @"cell";

@interface BPFlowMainCatergoryView ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryViewDelegate>
@property (nonatomic, weak) UICollectionView *contentCollectionView;
@property (nonatomic, weak) BPFlowCatergoryView *catergoryView;
@property (nonatomic, strong) NSMutableDictionary *vcCacheDic;
@end

@implementation BPFlowMainCatergoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self configSubViews];
}

- (void)reloadData {
    [self.catergoryView bp_realoadData];
    [self.contentCollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kWhiteColor;
    UIViewController *vc = self.vcCacheDic[[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (vc) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        //vc.view.frame = cell.contentView.bounds;
        [cell.contentView addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }else {
        if (_delegate && [_delegate respondsToSelector:@selector(flowMainCatergoryView:cellForItemAtIndexPath:)]) {
            UIViewController *childVC =  [_delegate flowMainCatergoryView:self cellForItemAtIndexPath:indexPath.row];
            [self.vcCacheDic setObject:childVC forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            //childVC.view.frame = cell.contentView.bounds;
            [cell.contentView addSubview:childVC.view];
            [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
        }
    }
    return cell;
}


- (NSMutableDictionary *)vcCacheDic {
    if (!_vcCacheDic) {
        _vcCacheDic = [NSMutableDictionary dictionary];
    }
    return _vcCacheDic;
}

- (void)configSubViews {
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
    
    //catergoryView
    BPFlowCatergoryView * catergoryView = [[BPFlowCatergoryView alloc] init];
    catergoryView.backgroundColor = kWhiteColor;
    self.catergoryView = catergoryView;
    [self addSubview:catergoryView];
    
    
    /* 关于数据*/
    catergoryView.titles = self.titles;//数据源titles，必须设置
    catergoryView.defaultIndex = 0;//默认优先显示的下标
    
    /* 关于交互:滑动、点击 */
    catergoryView.scrollView = contentCollectionView;//必须设置关联的scrollview
    catergoryView.delegate = self;//监听item按钮点击
    
    /* 关于横线*/
    catergoryView.bottomLineEable = YES;//开启底部线条
    catergoryView.bottomLineHeight = 2.0f;//横线高度，默认2.0f
    catergoryView.bottomLineWidth = 15.0f;//横线宽度
    catergoryView.bottomLineColor = kGreenColor;//下方横线颜色
    catergoryView.bottomLineSpacingFromTitleBottom = 6;//设置底部线条距离item底部的距离
    
    
    /* 关于背景图:椭圆*/
    catergoryView.backEllipseEable = NO;//是否开启背后的椭圆，默认NO
    //catergoryView.backEllipseColor = kGreenColor;/**椭圆颜色，默认黄色*/
    //catergoryView.backEllipseSize = CGSizeMake(10, 10);/**椭圆大小，默认CGSizeZero，表示椭圆大小随文字内容而定*/
    
    /* 关于缩放*/
    catergoryView.scaleEnable = YES;//是否开启缩放， 默认NO
    catergoryView.scaleRatio = 1.05f;//缩放比例， 默认1.1
    
    /* 关于cell 间距*/
    catergoryView.itemSpacing = 35;//item间距，默认10
    catergoryView.edgeSpacing = 25;//左右边缘间距，默认20
    
    /* 关于字体*/
    catergoryView.titleColorChangeEable = YES;//是否开启文字颜色变化效果
    catergoryView.titleColorChangeGradually = NO;//设置文字左右渐变
    catergoryView.titleColor = kLightGrayColor;
    catergoryView.titleSelectColor = kDarkTextColor;
    catergoryView.titleFont = [UIFont systemFontOfSize:15];//item字体
    
    /* 关于动画*/
    catergoryView.clickedAnimationDuration = 0.3;//点击item后各个控件（底部线条和椭圆）动画的时间，默认0.3秒，可设置为0*/
    catergoryView.scrollWithAnimaitonWhenClicked = NO;//禁用点击item滚动scrollView的动画
    catergoryView.holdLastIndexAfterUpdate = NO;/**刷新后是否保持在原来的index上，默认NO，表示刷新后回到第0个item*/
    
    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(catergoryView.mas_bottom);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
