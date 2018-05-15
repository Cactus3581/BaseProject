//
//  KSHeritageDictionaryListContainerViewController.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSHeritageDictionaryListContainerViewController.h"
#import "KSHeritageDictionaryModel.h"
#import "BPFlowCatergoryView.h"
#import "UICollectionViewFlowLayout+BPFullItem.h"
#import "BPFlowCatergoryViewCell.h"
#import "KSHeritageDictionaryListContainerCollectionViewCell.h"
#import "KSHeritageDictionaryMacro.h"

@interface KSHeritageDictionaryListContainerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, BPFlowCatergoryViewDelegate>
@property (nonatomic, weak) UICollectionView *mainView;
@property (nonatomic, weak) BPFlowCatergoryView *catergoryView;
@end

@implementation KSHeritageDictionaryListContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handlaData];
    [self configSubViews];
}

- (void)handlaData {
    NSArray *array1 = @[@"四级",@"六级",@"小学",@"初中",@"高中",@"大学"];
    NSArray *array2 = @[@"初中牛津版",@"新教初中牛津版",@"仁爱的版",@"初中河北版",@"初中牛津版",@"翼教版",@"初中牛津版",@"新教初中牛津版",@"仁爱的版",@"初中河北版",@"初中牛津版",@"翼教版"];
    NSArray *array3 = @[@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词"];
    
    NSMutableArray *muArray1 = @[].mutableCopy;
    [array1 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx1, BOOL * _Nonnull stop) {
        KSWordBookAuthorityDictionaryFirstCategoryModel *model = [[KSWordBookAuthorityDictionaryFirstCategoryModel alloc] init];
        model.name = title;
        NSMutableArray *tagArray = @[].mutableCopy;
        [array2 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx2, BOOL * _Nonnull stop) {
            KSWordBookAuthorityDictionarySecondCategoryModel *tagModel = [[KSWordBookAuthorityDictionarySecondCategoryModel alloc] init];
            KSWordBookAuthorityDictionaryThirdCategoryUpperModel *upperModel = [[KSWordBookAuthorityDictionaryThirdCategoryUpperModel alloc] init];
            tagModel.thirdCategoryModel = upperModel;
            tagModel.name = title;
            NSMutableArray *cellArray = @[].mutableCopy;
            [array3 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx3, BOOL * _Nonnull stop) {
                KSWordBookAuthorityDictionaryThirdCategoryModel *cellModel = [[KSWordBookAuthorityDictionaryThirdCategoryModel alloc] init];
                NSString *number = [NSString stringWithFormat:@"%ld%ld%ld",idx1,idx2,idx3];
                cellModel.name = [NSString stringWithFormat:@"%@:%@",number,title];
                cellModel.classId = @([number integerValue]);
                [cellArray addObject:cellModel];
            }];
            upperModel.data = cellArray;
            [tagArray addObject:tagModel];
        }];
        model.sub = tagArray;
        [muArray1 addObject:model];
    }];
    
    self.cateogry = muArray1.copy;
    
    [self.cateogry enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionaryFirstCategoryModel *firstCategoryModel, NSUInteger idx1, BOOL * _Nonnull stop) {
        [firstCategoryModel.sub enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel, NSUInteger idx2, BOOL * _Nonnull stop) {
            secondCategoryModel.defaultShowIndex = 0;
            if (idx2 == secondCategoryModel.defaultShowIndex) {
                secondCategoryModel.isSelected = YES;
            }else {
                secondCategoryModel.isSelected = NO;
            }
        }];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cateogry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSHeritageDictionaryListContainerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSHeritageDictionaryListContainerCollectionViewCell" forIndexPath:indexPath];
    KSWordBookAuthorityDictionaryFirstCategoryModel *model = self.cateogry[indexPath.row];
    [cell setModel:model indexPath:indexPath];
    return cell;
}

- (void)configSubViews {
    //主collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(0, 0);
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
    [mainView registerNib:[UINib nibWithNibName:NSStringFromClass([KSHeritageDictionaryListContainerCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"KSHeritageDictionaryListContainerCollectionViewCell"];
    [self.view addSubview:mainView];
    
    //catergoryView
    BPFlowCatergoryView * catergoryView = [[BPFlowCatergoryView alloc] init];
    catergoryView.backgroundColor = kWhiteColor;
    self.catergoryView = catergoryView;
    [self.view addSubview:catergoryView];

    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i < self.cateogry.count; i++) {
        KSWordBookAuthorityDictionaryFirstCategoryModel *model = self.cateogry[i];
        if (i==0) {
            model.tagHeight = 142;
        }else if (i==1) {
            model.tagHeight = 52;
        }else if (i==2) {
            model.tagHeight = 97;
        }
        [itemArray addObject:model.name];
    }
    
    /* 关于数据*/
    catergoryView.titles = itemArray;//数据源titles，必须设置
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
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@40);
    }];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(catergoryView.mas_bottom);
    }];
    [catergoryView bp_realoadData];
    [mainView reloadData];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.mainView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
