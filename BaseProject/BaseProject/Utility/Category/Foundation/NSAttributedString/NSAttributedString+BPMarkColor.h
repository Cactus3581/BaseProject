//
//  NSAttributedString+BPMarkColor.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (BPMarkColor)

/**
 * 给整个字符串中出现的FindString字符串背景上色,如果没有发现不会上色 并且不会改变原字符串其他属性
 * @param findString 需要上色的字符串
 * @param backgroundColor 需要上的颜色
 * @return 返回上过色的字符串
 */
- (NSMutableAttributedString *)attributedStringColorFindString:(NSString *)findString withBackgroundColor:(UIColor *)backgroundColor;

/**
 * 给整个字符串中出现的FindString字符串数组中的所有字符串并给背景上色,如果没有发现不会上色 并且不会改变原字符串其他属性
 * @param findStringArray 需要上色的字符串数组
 * @param backgroundColor 需要上的颜色
 * @return 返回上过色的字符串
 */
- (NSMutableAttributedString *)attributedStringColorFindStringArray:(NSArray *)findStringArray withBackgroundColor:(UIColor *)backgroundColor;

@end
