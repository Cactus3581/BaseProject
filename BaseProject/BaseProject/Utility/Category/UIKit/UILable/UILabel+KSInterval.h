//
//  UILabel+KSInterval.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (KSInterval)

/**
 *  改变行间距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

/**
 *  改变字间距
 */
- (void)setText:(NSString*)text kernSpacing:(CGFloat)kernSpacing;

/**
 *  改变行间距和字间距
 */
- (void)setText:(NSString*)text ineSpacing:(CGFloat)lineSpacing kernSpacing:(CGFloat)kernSpacing;

@end
