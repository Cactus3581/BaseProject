//
//  BPFlowCategoryViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/7/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPFlowCategoryViewController.h"
#import "BPFlowCategoryView.h"


@interface BPFlowCategoryViewController ()<BPFlowCategoryViewDelegate>
@property (nonatomic, weak) BPFlowCategoryView *flowCategoryView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation BPFlowCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"听力", @"查词", @"课程",@"生词本"];
    self.rightBarButtonTitle = @"刷新";
    [self configLayoutStyle];
    [self configSubViews];
    [self handleDynamicJumpData];
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

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self type1];//测试锚点
            }
                break;
                
            case 1:{
                [self type2];
            }
                break;
                
            case 2:{
                [self type3];
            }
                break;
                
            case 3:{
                [self type4];
            }
                break;
        }
    }
}

- (void)type1 {
    //设置文字左右渐变
    self.flowCategoryView.titleColorChangeGradually = YES;
    //开启底部线条
    self.flowCategoryView.bottomLineEable = YES;
    self.flowCategoryView.titleFont = [UIFont boldSystemFontOfSize:15];
    //设置底部线条距离item底部的距离
    self.flowCategoryView.bottomLineSpacingFromTitleBottom = 6;
    //禁用点击item滚动scrollView的动画
    self.flowCategoryView.scrollWithAnimaitonWhenClicked = NO;
    self.flowCategoryView.flowTagViewColor = kGrayColor;
    self.flowCategoryView.titleColorChangeGradually = YES;
    self.flowCategoryView.backEllipseEable = YES;
    self.flowCategoryView.defaultIndex =15;
}

- (void)type2 {
    self.flowCategoryView.titleSelectColor = kPurpleColor;
    self.flowCategoryView.itemSpacing = 15;
    /**开启背后椭圆*/
    self.flowCategoryView.backEllipseEable = YES;
    self.flowCategoryView.scrollWithAnimaitonWhenClicked = NO;
    /**设置默认defaultIndex*/
    self.flowCategoryView.defaultIndex = 6;
    self.flowCategoryView.flowTagViewColor = kGrayColor;
}

- (void)type3 {
    self.flowCategoryView.itemSpacing = 30;
    self.flowCategoryView.flowTagViewColor = kGrayColor;
    //刷新后保持原来的index
    self.flowCategoryView.holdLastIndexAfterUpdate = YES;
    //开启缩放
    self.flowCategoryView.scaleEnable = YES;
    //设置缩放等级
    self.flowCategoryView.scaleRatio = 1.2;
    //开启点击item滑动scrollView的动画
    self.flowCategoryView.scrollWithAnimaitonWhenClicked = YES;
    self.flowCategoryView.defaultIndex = 1;
}

- (void)type4 {
    self.flowCategoryView.defaultIndex = 0;//默认优先显示的下标
    
    /* 关于横线*/
    self.flowCategoryView.bottomLineEable = YES;//开启底部线条
    self.flowCategoryView.bottomLineHeight = 3.0f;//横线高度，默认2.0f
    self.flowCategoryView.bottomLineWidth = 15.0f;//横线宽度
    self.flowCategoryView.bottomLineColor = kExplicitColor;//下方横线颜色
    self.flowCategoryView.bottomLineSpacingFromTitleBottom = 4;//设置底部线条距离item底部的距离
    self.flowCategoryView.bottomLineCornerRadius = YES;
    
    /* 关于背景图:椭圆*/
    self.flowCategoryView.backEllipseEable = NO;//是否开启背后的椭圆，默认NO
    //self.flowCategoryView.backEllipseColor = BPColor(1);/**椭圆颜色，默认黄色*/
    //self.flowCategoryView.backEllipseSize = CGSizeMake(10, 10);/**椭圆大小，默认CGSizeZero，表示椭圆大小随文字内容而定*/
    
    /* 关于缩放*/
    self.flowCategoryView.scaleEnable = YES;//是否开启缩放， 默认NO
    //    self.flowCategoryView.scaleRatio = 1.05f;//缩放比例， 默认1.1
    self.flowCategoryView.scaleRatio = 1.f;//缩放比例， 默认1.1
    
    /* 关于cell 间距*/
    self.flowCategoryView.itemSpacing = 35;//item间距，默认10
    self.flowCategoryView.edgeSpacing = 25;//左右边缘间距，默认20
    
    /* 关于字体*/
    self.flowCategoryView.titleColorChangeEable = YES;//是否开启文字颜色变化效果
    self.flowCategoryView.titleColorChangeGradually = NO;//设置文字左右渐变
    self.flowCategoryView.titleColor = kThemeColor;
    self.flowCategoryView.titleSelectColor = kDarkTextColor;
    self.flowCategoryView.titleFont = [UIFont systemFontOfSize:15];//item字体
    self.flowCategoryView.titleSelectFont = [UIFont fontOfSize:15 weight:UIFontWeightMedium];//item字体
    
    /* 关于动画*/
    self.flowCategoryView.clickedAnimationDuration = 0.25;//点击item后各个控件（底部线条和椭圆）动画的时间，默认0.3秒，可设置为0*/
    self.flowCategoryView.scrollWithAnimaitonWhenClicked = NO;//禁用点击item滚动scrollView的动画
    self.flowCategoryView.holdLastIndexAfterUpdate = NO;/**刷新后是否保持在原来的index上，默认NO，表示刷新后回到第0个item*/
}

- (void)configSubViews {
    BPFlowCategoryView * flowCategoryView = [[BPFlowCategoryView alloc] init];
    self.flowCategoryView = flowCategoryView;
    [self.view addSubview:flowCategoryView];
    
    /* 关于数据*/
    flowCategoryView.titles = self.titles;//数据源titles，必须设置
    
    /* 关于交互:滑动、点击 */
    flowCategoryView.delegate = self;//监听item按钮点击
    [flowCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIViewController *)flowCategoryView:(BPFlowCategoryView *)flowCategoryView cellForItemAtIndexPath:(NSInteger)row {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = kRandomColor;
    return vc;
}

- (void)flowCategoryView:(BPFlowCategoryView *)flowCategoryView didSelectItemAtIndex:(NSInteger)row {
    BPLog(@"点击了%zd个row", row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
