//
//  DHCustomSlideView.h
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/15.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHSlideTabbarProtocol.h"
#import "DHCacheProtocol.h"
#import "DHSlideView.h"

@protocol DHCustomSlideViewDelegate;

@interface DHCustomSlideView : UIView

@property (weak, nonatomic) id<DHCustomSlideViewDelegate>delegate;
@property (weak, nonatomic) UIViewController *baseViewController;
@property (assign, nonatomic) NSInteger selectedIndex;
/**
 * tabbar
 */
@property (nonatomic, strong) UIView<DHSlideTabbarProtocol> *tabbarView;
@property (nonatomic, assign) float tabbarBottomSpacing;
/**
 * cache Properties
 */
@property (nonatomic, strong) id<DHCacheProtocol> cache;
/**
 * 初始分方法
 */
- (void)setup;
- (void)readloadCustomView;

- (void)setSlideViewBackgroundColor:(UIColor *)color;

@property (nonatomic, assign) NSInteger maxCacheNumber;

@end

@protocol DHCustomSlideViewDelegate <NSObject>

- (NSInteger)numberOfTabsInDHCustomSlideView:(DHCustomSlideView *)customSlideView;
- (UIViewController *)DHCustomSlideView:(DHCustomSlideView *)customSlideView controllerAtIndex:(NSInteger)index;

@optional

- (void)DHCustomSlideView:(DHCustomSlideView *)customSlideView didSelectedAtIndex:(NSInteger)index;

@end
