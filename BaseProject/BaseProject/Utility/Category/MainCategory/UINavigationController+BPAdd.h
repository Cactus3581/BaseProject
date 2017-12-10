//
//  UINavigationController+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (BPAdd)<UIGestureRecognizerDelegate>

/**pushed时候隐藏tabBar，设置导航控制器该属性后对其push的所有控制器都有效*/
@property (nonatomic, assign) BOOL hidesBottomBarWhenEveryPushed;
/**是否隐藏底部线条*/
@property (nonatomic, assign) BOOL hideBottomLine;
/**自定义返回按钮的图片，自定义后由于系统边缘pop手势会失效，建议调用bp_enableFullScreenGestureWithEdgeSpacing:开启自定义pop手势*/
@property (nonatomic, strong) UIImage *customBackImage;

/**
 * 弃用系统pop手势，开启自己的手势，edgeSpacing表示手势距离左边距多少才会触发，传0为全屏pop手势
 */
- (void)bp_enableFullScreenGestureWithEdgeSpacing:(CGFloat)edgeSpacing;

@end

NS_ASSUME_NONNULL_END
