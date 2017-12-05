//
//  BPCGUtilities.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//方法声明
CGSize XRZScreenSize();
CGSize XRZScreenUniqueSize();

CGFloat XRZScreenWidthRatio();
CGFloat XRZScreenWidthUniqueRatio();

CGFloat XRZScreenScale();
CGRect  XRZScreenBounds();

#pragma mark - 横竖屏-宽高不会切换
static inline CGFloat widthUniqueRatio(CGFloat number) {
    return number * XRZScreenWidthUniqueRatio();
}

#pragma mark - 横竖屏-宽高会切换
static inline CGFloat widthRatio(CGFloat number) {
    return number * XRZScreenWidthRatio();
}

static inline CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
}

static inline CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180 / M_PI;
}

//获取一像素
#ifndef kOnePixel
#define kOnePixel 1.0f / XRZScreenScale()
#endif

// main screen's scale 屏幕的像素倍数
#ifndef kScreenScale
#define kScreenScale XRZScreenScale()
#endif

// main screen's bounds
#ifndef kScreenBounds
#define kScreenBounds XRZScreenBounds()
#endif

// main screen's size (portrait||landscape)
#ifndef kScreenSize
#define kScreenSize XRZScreenSize()
#endif

// main screen's size (portrait)
#ifndef kScreenUniqueSize
#define kScreenUniqueSize XRZScreenUniqueSize()
#endif

// main screen's width ((portrait||landscape))
#ifndef kScreenWidth
#define kScreenWidth XRZScreenSize().width
#endif

// main screen's width (portrait)
#ifndef kScreenUniqueWidth
#define kScreenUniqueWidth XRZScreenUniqueSize().width
#endif

// main screen's height ((portrait||landscape))
#ifndef kScreenHeight
#define kScreenHeight XRZScreenSize().height
#endif

// main screen's height (portrait)
#ifndef kScreenUniqueHeight
#define kScreenUniqueHeight XRZScreenUniqueSize().height
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

// 状态栏增加的高度
#ifndef kStatusBarAddHeight
#define kStatusBarAddHeight (iPhoneX ? 24.f : 0.f)
#endif

// 适配iPhone X 状态栏高度
#ifndef kStatusBarHeight
#define kStatusBarHeight (iPhoneX ? 44.f : 20.f)
#endif

//适配iPhone X 导航栏高度
#ifndef kNavHeight
#define kNavHeight (iPhoneX ? 88.f : 64.f)
#endif

//适配iPhone X Tabbar高度
#ifndef kTabbarHeight
#define kTabbarHeight (iPhoneX ? (49.f + 34.f) : 49.f)
#endif

//适配iPhone X Tabbar距离底部的距离
#ifndef kHomeIndicatorHeight
#define kHomeIndicatorHeight (iPhoneX ? 34.f : 0.f)
#endif

//适配iPhone X Tabbar距离底部的距离
#ifndef kTabbarSafeBottomMargin
#define kTabbarSafeBottomMargin (iPhoneX ? 34.f : 0.f)
#endif

NS_ASSUME_NONNULL_END

