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
- (void)setTheme;

- (void)configRightBarButtomItem;

- (void)configLeftBarButtomItem;

- (void)configBarDefaulyStyle;

- (void)naviBarHidden:(BOOL)hidden animated:(BOOL)animated;

- (void)addFPSLabel;

- (void)removeFPSLabel;

/**全屏pop手势关闭*/
- (void)popDisabled;

#pragma mark - 动态跳转
@property(nonatomic,strong) NSDictionary *dynamicJumpDict;
@property (nonatomic,copy)  NSString *dynamicJumpString;//动态跳转数据
@property(nonatomic,readonly,assign) BOOL needDynamicJump;
- (void)handleDynamicJumpData;
@end
