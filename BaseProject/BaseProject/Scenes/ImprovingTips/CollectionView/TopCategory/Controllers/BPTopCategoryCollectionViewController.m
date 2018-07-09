//
//  BPTopCategoryCollectionViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryCollectionViewController.h"
#import "BPTopCategoryModel.h"
#import "BPFlowCatergoryView.h"
#import "BPTopCategoryMacro.h"
#import "BPCategoryDetailViewController.h"

@interface BPTopCategoryCollectionViewController ()<BPFlowCatergoryViewDelegate>
@property (nonatomic, weak) BPFlowCatergoryView *catergoryView;
@property (nonatomic, strong) NSArray *cateogry;
@end

@implementation BPTopCategoryCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFPSLabel];
    [self handlaData];
    [self initializeSubViews];
}

- (void)configLayoutStyle {
    //1. 所有view（包括scroll）坐标原点在导航栏下面,不影响导航栏的颜色及背景，即跟它没关系，只影响坐标原点；也不会设置scroll的偏移量
    self.edgesForExtendedLayout = UIRectEdgeNone;//也可以是UIRectEdgeTop
}

- (void)handlaData {
    NSArray *array1 = @[@"四级",@"六级",@"小学",@"初中",@"高中",@"大学"];
    NSArray *array2 = @[@"初中牛津版",@"新教初中牛津版",@"仁爱的版",@"初中河北版",@"初中牛津版",@"翼教版",@"初中牛津版",@"新教初中牛津版",@"仁爱的版",@"初中河北版",@"初中牛津版",@"翼教版"];
    NSArray *array3 = @[@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词",@"专四真题高频词"];
    
    NSMutableArray *muArray1 = @[].mutableCopy;
    [array1 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx1, BOOL * _Nonnull stop) {
        BPTopCategoryFirstCategoryModel *model = [[BPTopCategoryFirstCategoryModel alloc] init];
        model.name = title;
        NSMutableArray *tagArray = @[].mutableCopy;
        [array2 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx2, BOOL * _Nonnull stop) {
            BPTopCategorySecondCategoryModel *tagModel = [[BPTopCategorySecondCategoryModel alloc] init];
            BPTopCategoryThirdCategoryUpperModel *upperModel = [[BPTopCategoryThirdCategoryUpperModel alloc] init];
            tagModel.thirdCategoryModel = upperModel;
            tagModel.name = title;
            NSMutableArray *cellArray = @[].mutableCopy;
            [array3 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx3, BOOL * _Nonnull stop) {
                BPTopCategoryThirdCategoryModel *cellModel = [[BPTopCategoryThirdCategoryModel alloc] init];
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
    
    [self.cateogry enumerateObjectsUsingBlock:^(BPTopCategoryFirstCategoryModel *firstCategoryModel, NSUInteger idx1, BOOL * _Nonnull stop) {
        [firstCategoryModel.sub enumerateObjectsUsingBlock:^(BPTopCategorySecondCategoryModel *secondCategoryModel, NSUInteger idx2, BOOL * _Nonnull stop) {
            secondCategoryModel.defaultShowIndex = 0;
            if (idx2 == secondCategoryModel.defaultShowIndex) {
                secondCategoryModel.isSelected = YES;
            }else {
                secondCategoryModel.isSelected = NO;
            }
        }];
    }];
}


- (void)initializeSubViews {
    //catergoryView
    BPFlowCatergoryView * catergoryView = [[BPFlowCatergoryView alloc] init];
    catergoryView.backgroundColor = kWhiteColor;
    self.catergoryView = catergoryView;
    [self.view addSubview:catergoryView];
    
    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i < self.cateogry.count; i++) {
        BPTopCategoryFirstCategoryModel *model = self.cateogry[i];
        [itemArray addObject:model.name];
    }
    
    /* 关于数据*/
    catergoryView.titles = itemArray;//数据源titles，必须设置
    catergoryView.defaultIndex = 0;//默认优先显示的下标
    
    /* 关于交互:滑动、点击 */
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
    
    [self.catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIViewController *)flowCatergoryView:(BPFlowCatergoryView *)flowCatergoryView cellForItemAtIndexPath:(NSInteger)row {
    BPCategoryDetailViewController *vc = [[BPCategoryDetailViewController alloc] init];
    BPTopCategoryFirstCategoryModel *model = self.cateogry[row];
    vc.model = model;
    return vc;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
