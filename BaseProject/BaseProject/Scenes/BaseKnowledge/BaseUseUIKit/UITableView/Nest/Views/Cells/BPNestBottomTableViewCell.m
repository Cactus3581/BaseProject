//
//  BPNestBottomTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNestBottomTableViewCell.h"
#import "BPFlowCatergoryView.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"
#import "BPNestBottomCollectionViewCell.h"

static NSString *identifier  = @"BPNestBottomCollectionViewCell";


@interface BPNestBottomTableViewCell ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryViewDelegate>
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, weak) BPFlowCatergoryView *catergoryView;
@property (nonatomic, strong) NSArray *cateogry;
@end

@implementation BPNestBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self handlaData];
        [self configSubViews];
    }
    return self;
}


- (void)handlaData {
    self.cateogry = @[@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cateogry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPNestBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kRedColor;
    //BPTopCategoryFirstCategoryModel *model = self.cateogry[indexPath.row];
    //[cell setModel:model indexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath  {

}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)configSubViews {
    //主collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //layout.estimatedItemSize = CGSizeMake(self.view.width, self.view.height);
    //layout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.fullItem = YES;
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainView = mainView;
    mainView.backgroundColor = kWhiteColor;
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.pagingEnabled = YES;
    mainView.scrollsToTop = NO;
    mainView.showsHorizontalScrollIndicator = NO;
    [mainView registerClass:[BPNestBottomCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self.contentView addSubview:mainView];
    
    //catergoryView
    BPFlowCatergoryView * catergoryView = [[BPFlowCatergoryView alloc] init];
    catergoryView.backgroundColor = kWhiteColor;
    self.catergoryView = catergoryView;
    [self.contentView addSubview:catergoryView];
    
    
    /* 关于数据*/
    catergoryView.titles = self.cateogry;//数据源titles，必须设置
    catergoryView.defaultIndex = 0;//默认优先显示的下标
    
    /* 关于交互:滑动、点击 */
    catergoryView.scrollView = mainView;//必须设置关联的scrollview
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
        make.leading.trailing.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.equalTo(@40);
    }];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.top.equalTo(catergoryView.mas_bottom);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
