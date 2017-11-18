//
//  KSCGUtilities.h
//  PowerWord7
//
//  Created by xiaruzhen on 2017/7/14.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

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
#ifndef KSScreenScale
#define KSScreenScale XRZScreenScale()
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

#define K_width [UIScreen mainScreen].bounds.size.width
#define K_height [UIScreen mainScreen].bounds.size.height
#define k_screenW ([UIScreen mainScreen].bounds.size.width)/(375.0f)
#define k_screenH ([UIScreen mainScreen].bounds.size.height)/(667.0f)

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

NS_ASSUME_NONNULL_END
