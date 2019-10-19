//
//  BPTopCategoryCollectionViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/5/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryCollectionViewController.h"
#import "BPTopCategoryModel.h"
#import "BPFlowCategoryView.h"
#import "BPTopCategoryMacro.h"
#import "BPCategoryDetailViewController.h"

@interface BPTopCategoryCollectionViewController ()<BPFlowCategoryViewDelegate>
@property (nonatomic, weak) BPFlowCategoryView *categoryView;
@property (nonatomic, strong) NSArray *cateogry;
@end

@implementation BPTopCategoryCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFPSLabel];
    [self handleData];
    [self initializeSubViews];
}

- (void)configLayoutStyle {
    //1. 所有view（包括scroll）坐标原点在导航栏下面,不影响导航栏的颜色及背景，即跟它没关系，只影响坐标原点；也不会设置scroll的偏移量
    self.edgesForExtendedLayout = UIRectEdgeNone;//也可以是UIRectEdgeTop
}

- (void)handleData {
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
    //categoryView
    BPFlowCategoryView * categoryView = [[BPFlowCategoryView alloc] init];
    categoryView.backgroundColor = kWhiteColor;
    self.categoryView = categoryView;
    [self.view addSubview:categoryView];
    
    NSMutableArray *itemArray = [NSMutableArray array];
    for (int i = 0; i < self.cateogry.count; i++) {
        BPTopCategoryFirstCategoryModel *model = self.cateogry[i];
        [itemArray addObject:model.name];
    }
    /* 关于数据*/
    categoryView.titles = itemArray;//数据源titles，必须设置
    
    /* 关于交互:滑动、点击 */
    categoryView.delegate = self;//监听item按钮点击
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIViewController *)flowCategoryView:(BPFlowCategoryView *)flowCategoryView cellForItemAtIndexPath:(NSInteger)row {
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
