//
//  BPDeviceOrientation.h
//  WPSExcellentClass
//
//  Created by xiaruzhen on 2018/10/21.
//  Copyright © 2018 Kingsoft. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface BPDeviceOrientation : NSObject

+ (instancetype)shareInstance;

/**
 *  是否竖屏
 */
- (BOOL)isPortrait;

/**
 *  是否横屏
 */
- (BOOL)isHorizontal;

/**
 *  观测屏幕变化
 */
- (void)addDeviceOrientationNotificationBlockHandle:(void (^)(UIInterfaceOrientation orientation))blockHandle;

/**
 *  移除掉通知
 */
- (void)removeDeviceOrientationNotification;

/**
 *  旋转操作
 */
- (void)screenExChangeView:(UIView *)view forOrientation:(UIInterfaceOrientation)orientation animation:(BOOL)animation;

@end
