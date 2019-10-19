//
//  BPCGUtilities.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//方法声明
CGFloat BPScreenWidthRatio();
CGSize BPScreenSize();
CGSize BPScreenUniqueSize();

CGFloat BPScreenWidthRatio();
CGFloat BPScreenWidthUniqueRatio();

CGFloat BPScreenScale();
CGRect  BPScreenBounds();

#pragma mark - 横竖屏-宽高不会切换
static inline CGFloat widthUniqueRatio(CGFloat number) {
    return number * BPScreenWidthUniqueRatio();
}

#pragma mark - 横竖屏-宽高会切换
static inline CGFloat widthRatio(CGFloat number) {
    return number * BPScreenWidthRatio();
}

static inline CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

static inline CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}

#define kWidthRatio(_f_) (_f_) * BPScreenWidthRatio()

static inline CGSize BPSizeMake(CGFloat width, CGFloat height) {
    CGSize size; size.width = kWidthRatio(width); size.height = kWidthRatio(height); return size;
}

static inline CGPoint BPPointMake(CGFloat x, CGFloat y) {
    CGPoint point; point.x = kWidthRatio(x); point.y = kWidthRatio(y); return point;
}

static inline CGRect BPRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    CGRect rect;
    rect.origin.x = kWidthRatio(x); rect.origin.y = kWidthRatio(y);
    rect.size.width = kWidthRatio(width); rect.size.height = kWidthRatio(height);
    return rect;
}

//获取一像素
#ifndef kOnePixel
#define kOnePixel 1.0f / BPScreenScale()
#endif

// main screen's scale 屏幕的像素倍数
#ifndef kScreenScale
#define kScreenScale BPScreenScale()
#endif

// main screen's bounds
#ifndef kScreenBounds
#define kScreenBounds BPScreenBounds()
#endif

// main screen's size (portrait||landscape)
#ifndef kScreenSize
#define kScreenSize BPScreenSize()
#endif

// main screen's size (portrait)
#ifndef kScreenUniqueSize
#define kScreenUniqueSize BPScreenUniqueSize()
#endif

// main screen's width ((portrait||landscape))
#ifndef kScreenWidth
#define kScreenWidth BPScreenSize().width
#endif

// main screen's width (portrait)
#ifndef kScreenUniqueWidth
#define kScreenUniqueWidth BPScreenUniqueSize().width
#endif

// main screen's height ((portrait||landscape))
#ifndef kScreenHeight
#define kScreenHeight BPScreenSize().height
#endif

// main screen's height (portrait)
#ifndef kScreenUniqueHeight
#define kScreenUniqueHeight BPScreenUniqueSize().height
#endif

#ifndef SCREEN_MIN
#define SCREEN_MIN MIN(kScreenHeight,kScreenWidth)
#endif

#ifndef SCREEN_MAX
#define SCREEN_MAX MAX(kScreenHeight,kScreenWidth)
#endif

// 判断是否是iPhone X
#ifndef iPhoneX
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

// iOS8
#ifndef kiOS8
#define kiOS8 @available(iOS 8.0, *)
#endif

// iOS9
#ifndef kiOS9
#define kiOS9 @available(iOS 9.0, *)
#endif

// iOS10
#ifndef kiOS10
#define kiOS10 @available(iOS 10.0, *)
#endif

// iOS11
#ifndef kiOS11
#define kiOS11 @available(iOS 11.0, *)
#endif

// 导航栏高度
#ifndef kCustomNaviHeight
#define kCustomNaviHeight 44.0f
#endif

// iOS11之前的状态栏高度
#ifndef kPrimaryStatusBarHeight
#define kPrimaryStatusBarHeight 20.0f
#endif

/**
 获取safeAreaInsets
 
 @param view vc.view
 @return safeAreaInsets
 */
static inline UIEdgeInsets BPSafeAreaInset(UIView *view) {
    if (kiOS11) {
        return view.safeAreaInsets;
    }
    return UIEdgeInsetsZero;
}

/**
 * 用以获取自定义导航栏高度
 * 在有状态栏&&自定义导航栏的环境下使用
 
 @param view vc.view
 @return 导航栏高度
 */
static inline CGFloat BPSafeAreaCustomNaviHeight(UIView *view) {
    UIEdgeInsets inset = BPSafeAreaInset(view);
    CGFloat height = kCustomNaviHeight;
    height += inset.top  > 0 ? inset.top : kPrimaryStatusBarHeight;
    return height;
}

/**
 用以获取状态栏的高度
 
 @param view vc.view
 @return 状态栏的高度
 */
static inline CGFloat BPSafeAreaStatusBarHeight(UIView *view) {
    UIEdgeInsets inset = BPSafeAreaInset(view);
    CGFloat inset_top = inset.top;
    return inset_top  > 0 ? inset_top : kPrimaryStatusBarHeight;
}

/**
 * 可以理解为自定义导航栏增加的高度，也可以理解为状态栏增加的高度
 * 在有状态栏&&自定义导航栏的环境下使用
 
 @param view vc.view
 @return 获取导航栏应增加的高度
 */
static inline CGFloat BPSafeAreaStatusBarMetaHeight(UIView *view) {
    CGFloat statusBarHeight = BPSafeAreaStatusBarHeight(view);
    return statusBarHeight - kPrimaryStatusBarHeight;
}

/**
 用以返回底部view居vc.view的高度
 
 @param view vc.view
 @return bottom
 */
static inline CGFloat BPSafeAreaHomeBarBottom(UIView *view) {
    UIEdgeInsets inset = BPSafeAreaInset(view);
    return inset.bottom;
}

#pragma mark - 以下方法按需使用：因为每个人对popButton的布局参照物不一样，使用的约束的变量可能是centerY、top、bottom，不能统一方法。
/*
 针对导航栏的自适应：
 1. 当使用bottom属性的时候，代码不需要更改；
 2. 当使用top属性的时候，代码需要更改；
 3. 当使用centerY属性的时候，代码需要更改；以下为centerY布局的时候用到（在64环境下代码/xib里应该是centerY+10）
 
 */
/**
 用以获取栏内元素(一般是popButton)的centerY值
 
 @param view vc.view
 @return 元素的centerY值
 */
static inline CGFloat BPSafeAreaViewCenterYInNavi(UIView *view) { //centerY + 10 | centerY + 22
    CGFloat centerY =  BPSafeAreaStatusBarHeight(view) / 2.0;
    return centerY;
}

#pragma mark - 下面为写死高度的宏。优先使用上面的动态获取safeArea的值，如果特定环境下上面方法不能使用，可以使用下面的宏。

// 状态栏增加的高度
#ifndef kSafeAreaStatusBarMetaHeight
#define kSafeAreaStatusBarMetaHeight (iPhoneX ? 24.f : 0.f)
#endif

// 适配iPhone X 状态栏高度
#ifndef kSafeAreaStatusBarHeight
#define kSafeAreaStatusBarHeight ((kSafeAreaStatusBarAddHeight) + (kPrimaryStatusBarHeight))
#endif

//适配iPhone X 导航栏高度
#ifndef kSafeAreaNaviHeight
#define kSafeAreaNaviHeight ((kSafeAreaStatusBarHeight) + (kCustomNaviHeight))
#endif

//适配iPhone X 距离底部的距离
#ifndef kHomeBarBottom
#define kHomeBarBottom (iPhoneX ? 34.f : 0.f)
#endif

// 之前的Tabbar高度
#ifndef kPrimaryTabbarHeight
#define kPrimaryTabbarHeight 49.f
#endif

//适配iPhone X Tabbar高度
#ifndef kSafeAreaTabbarHeight
#define kSafeAreaTabbarHeight ((kPrimaryTabbarHeight) + (kHomeBarBottom))
#endif

NS_ASSUME_NONNULL_END
