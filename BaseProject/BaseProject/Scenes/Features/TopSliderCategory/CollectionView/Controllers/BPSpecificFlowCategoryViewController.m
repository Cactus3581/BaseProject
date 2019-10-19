//
//  BPSpecificFlowCategoryViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/8/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSpecificFlowCategoryViewController.h"
#import "BPSpecificFlowCategoryView.h"

@interface BPSpecificFlowCategoryViewController ()<BPSpecificFlowCategoryViewDelegate>
@property (weak, nonatomic) IBOutlet BPSpecificFlowCategoryView *flowCategoryView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation BPSpecificFlowCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"课程",@"生词本生词本生词本生词本生词本"];
    self.rightBarButtonTitle = @"刷新";
    [self configLayoutStyle];
    [self configSubViews];
}

#pragma mark - config theme style
- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

/**模拟网络刷新*/
- (void)rightBarButtonItemClickAction:(UIButton *)sender {
    sender.enabled = NO;
    [self.view bp_makeToastActivity];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_titles.count == 4) {
            _titles = @[@"听力",@"英语环球广播",@"中英双语", @"随便听听", @"考试真题", @"常速VOA",@"今日必听", @"热门推荐"];
            _flowCategoryView.itemSpacing = 30;
            
        }else{
            _titles = @[@"听力", @"查词", @"课程",@"生词本"];
        }
        [self.view bp_hideToastActivity];
        sender.enabled = YES;
        //重新设置数据源
        _flowCategoryView.titles = _titles;
        //调用如下方法，刷新控件数据
        [_flowCategoryView bp_realoadDataForTag];
        //刷新自己的collectionview数据
        [_flowCategoryView bp_realoadDataForContentView];
    });
}

- (void)configSubViews {
    /* 关于数据*/
    self.flowCategoryView.titles = self.titles;//数据源titles，必须设置
    /* 关于交互:滑动、点击 */
    self.flowCategoryView.delegate = self;//监听item按钮点击
}

- (UIViewController *)flowCategoryView:(BPSpecificFlowCategoryView *)flowCategoryView cellForItemAtIndexPath:(NSInteger)row {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = kRandomColor;
    return vc;
}

- (void)flowCategoryView:(BPSpecificFlowCategoryView *)flowCategoryView didSelectItemAtIndex:(NSInteger)row {
    BPLog(@"点击了%zd个row", row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
