//
//  BPBaseNavigationController.h
//  BaseProject
//
//  Created by Ryan on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPBaseNavigationController : UINavigationController

/*
 *  添加nav的分割线 凡是用到nav的都会有这张线  所以有的界面需要手动隐藏
 */
@property (nonatomic, strong) UIImageView *navBarHairlineImageView;//nav下的黑线

/**
 *  强制 不要手势侧滑
 */
@property (nonatomic, assign) BOOL forbiddenInteractivePopGestureRecognizer;

/**
 防止多次Push导致的bug
 */
@property (nonatomic, assign) BOOL shouldIgnorePushingViewControllers;

@end
