//
//  BPBaseViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPBaseViewController : UIViewController
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
@end
