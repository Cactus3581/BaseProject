//
//  BPBaseViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPDynamicJumpHelper.h"

@interface BPBaseViewController : UIViewController <BPDynamicJumpHelperProtocol>

#pragma mark - 导航栏item
/**
 自定义导航栏:left
 */
@property(nonatomic,strong) UIImage *leftBarButtonImage;
@property(nonatomic,copy) NSString *leftBarButtonTitle;

/**
 自定义导航栏:right
 */
@property(nonatomic,strong) UIImage *rightBarButtonImage;
@property(nonatomic,copy) NSString *rightBarButtonTitle;
@property(nonatomic,assign) BOOL hideRightBarButton;

/**
 *  子类 重写 方法
 *
 *  @param sender sender
 */
- (void)rightBarButtonItemClickAction:(id)sender;

/**
 *  子类 可重写该方法 以做自定义操作
 *
 *  @param sender sender
 */
- (void)leftBarButtonItemClickAction:(id)sender;

- (void)configBarButtomItem;

- (void)configRightBarButtomItem;

- (void)configLeftBarButtomItem;

- (void)naviBarHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)configNavigationBarStyle;
- (void)recoverNavigationBarStyle;

#pragma mark - 检测卡顿工具
- (void)addFPSLabel;

- (void)removeFPSLabel;

#pragma mark - 创建views
- (void)initializeViews;

#pragma mark -数据处理
- (void)request;
- (void)handleData;

#pragma mark - 手势
/**全屏pop手势关闭 ,默认NO，默认关闭*/
- (void)popDisabled:(BOOL)disabled;

#pragma mark - 动态跳转
@property(nonatomic,strong) NSDictionary *dynamicJumpDict;
@property (nonatomic,copy)  NSString *dynamicJumpString;//动态跳转数据
@property(nonatomic,readonly,assign) BOOL needDynamicJump;
- (void)handleDynamicJumpData;

#pragma mark - stastuaBar
- (void)configStatusBarStyle;
- (void)recoverStatusStyle;
/** 单独设置statusBar颜色*/
- (void)setStatusBarBackgroundColor:(UIColor *)color;
/** 动态调整statusBar隐藏 文字颜色 动画等属性*/
- (void)updateStatusBarAppearance;

#pragma mark - 强制旋转屏幕
- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end
