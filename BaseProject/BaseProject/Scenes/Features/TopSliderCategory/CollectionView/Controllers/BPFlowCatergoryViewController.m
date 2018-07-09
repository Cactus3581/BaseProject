//
//  BPFlowCatergoryViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPFlowCatergoryViewController.h"
#import "BPFlowCatergoryView.h"


@interface BPFlowCatergoryViewController ()<BPFlowCatergoryViewDelegate>
@property (nonatomic, weak) BPFlowCatergoryView *flowCatergoryView;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation BPFlowCatergoryViewController

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
            _flowCatergoryView.itemSpacing = 30;
            
        }else{
            _titles = @[@"听力", @"查词", @"课程",@"生词本"];
        }
        [self.view bp_hideToastActivity];
        sender.enabled = YES;
        //重新设置数据源
        _flowCatergoryView.titles = _titles;
        //调用如下方法，刷新控件数据
        [_flowCatergoryView bp_realoadDataForTag];
        //刷新自己的collectionview数据
        [_flowCatergoryView bp_realoadDataForContentView];
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
    self.flowCatergoryView.titleColorChangeGradually = YES;
    //开启底部线条
    self.flowCatergoryView.bottomLineEable = YES;
    self.flowCatergoryView.titleFont = [UIFont boldSystemFontOfSize:15];
    //设置底部线条距离item底部的距离
    self.flowCatergoryView.bottomLineSpacingFromTitleBottom = 6;
    //禁用点击item滚动scrollView的动画
    self.flowCatergoryView.scrollWithAnimaitonWhenClicked = NO;
    self.flowCatergoryView.flowTagViewColor = kGrayColor;
    self.flowCatergoryView.titleColorChangeGradually = YES;
    self.flowCatergoryView.backEllipseEable = YES;
    self.flowCatergoryView.defaultIndex =15;
}

- (void)type2 {
    self.flowCatergoryView.titleSelectColor = kPurpleColor;
    self.flowCatergoryView.itemSpacing = 15;
    /**开启背后椭圆*/
    self.flowCatergoryView.backEllipseEable = YES;
    self.flowCatergoryView.scrollWithAnimaitonWhenClicked = NO;
    /**设置默认defaultIndex*/
    self.flowCatergoryView.defaultIndex = 6;
    self.flowCatergoryView.flowTagViewColor = kGrayColor;
}

- (void)type3 {
    self.flowCatergoryView.itemSpacing = 30;
    self.flowCatergoryView.flowTagViewColor = kGrayColor;
    //刷新后保持原来的index
    self.flowCatergoryView.holdLastIndexAfterUpdate = YES;
    //开启缩放
    self.flowCatergoryView.scaleEnable = YES;
    //设置缩放等级
    self.flowCatergoryView.scaleRatio = 1.2;
    //开启点击item滑动scrollView的动画
    self.flowCatergoryView.scrollWithAnimaitonWhenClicked = YES;
    self.flowCatergoryView.defaultIndex = 1;
}

- (void)type4 {
    self.flowCatergoryView.defaultIndex = 0;//默认优先显示的下标
    
    /* 关于横线*/
    self.flowCatergoryView.bottomLineEable = YES;//开启底部线条
    self.flowCatergoryView.bottomLineHeight = 3.0f;//横线高度，默认2.0f
    self.flowCatergoryView.bottomLineWidth = 15.0f;//横线宽度
    self.flowCatergoryView.bottomLineColor = kExplicitColor;//下方横线颜色
    self.flowCatergoryView.bottomLineSpacingFromTitleBottom = 4;//设置底部线条距离item底部的距离
    self.flowCatergoryView.bottomLineCornerRadius = YES;
    
    /* 关于背景图:椭圆*/
    self.flowCatergoryView.backEllipseEable = NO;//是否开启背后的椭圆，默认NO
    //self.flowCatergoryView.backEllipseColor = BPColor(1);/**椭圆颜色，默认黄色*/
    //self.flowCatergoryView.backEllipseSize = CGSizeMake(10, 10);/**椭圆大小，默认CGSizeZero，表示椭圆大小随文字内容而定*/
    
    /* 关于缩放*/
    self.flowCatergoryView.scaleEnable = YES;//是否开启缩放， 默认NO
    //    self.flowCatergoryView.scaleRatio = 1.05f;//缩放比例， 默认1.1
    self.flowCatergoryView.scaleRatio = 1.f;//缩放比例， 默认1.1
    
    /* 关于cell 间距*/
    self.flowCatergoryView.itemSpacing = 35;//item间距，默认10
    self.flowCatergoryView.edgeSpacing = 25;//左右边缘间距，默认20
    
    /* 关于字体*/
    self.flowCatergoryView.titleColorChangeEable = YES;//是否开启文字颜色变化效果
    self.flowCatergoryView.titleColorChangeGradually = NO;//设置文字左右渐变
    self.flowCatergoryView.titleColor = kThemeColor;
    self.flowCatergoryView.titleSelectColor = kDarkTextColor;
    self.flowCatergoryView.titleFont = [UIFont systemFontOfSize:15];//item字体
    self.flowCatergoryView.titleSelectFont = [UIFont fontOfSize:15 weight:UIFontWeightMedium];//item字体
    
    /* 关于动画*/
    self.flowCatergoryView.clickedAnimationDuration = 0.25;//点击item后各个控件（底部线条和椭圆）动画的时间，默认0.3秒，可设置为0*/
    self.flowCatergoryView.scrollWithAnimaitonWhenClicked = NO;//禁用点击item滚动scrollView的动画
    self.flowCatergoryView.holdLastIndexAfterUpdate = NO;/**刷新后是否保持在原来的index上，默认NO，表示刷新后回到第0个item*/
}

- (void)configSubViews {
    BPFlowCatergoryView * flowCatergoryView = [[BPFlowCatergoryView alloc] init];
    self.flowCatergoryView = flowCatergoryView;
    [self.view addSubview:flowCatergoryView];
    
    /* 关于数据*/
    flowCatergoryView.titles = self.titles;//数据源titles，必须设置
    
    /* 关于交互:滑动、点击 */
    flowCatergoryView.delegate = self;//监听item按钮点击
    [flowCatergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIViewController *)flowCatergoryView:(BPFlowCatergoryView *)flowCatergoryView cellForItemAtIndexPath:(NSInteger)row {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = kRandomColor;
    return vc;
}

- (void)flowCatergoryView:(BPFlowCatergoryView *)flowCatergoryView didSelectItemAtIndex:(NSInteger)row {
    BPLog(@"点击了%zd个row", row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
