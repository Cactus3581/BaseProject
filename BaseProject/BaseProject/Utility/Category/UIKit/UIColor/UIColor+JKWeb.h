//
//  UIColor+Web.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JKWeb)
/**
 *  @brief  获取canvas用的颜色字符串
 *
 *  @return canvas颜色
 */
- (NSString *)bp_canvasColorString;
/**
 *  @brief  获取网页颜色字串
 *
 *  @return 网页颜色
 */
- (NSString *)bp_webColorString;
@end
