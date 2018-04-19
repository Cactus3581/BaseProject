//
//  NSString+BPMarkColor.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BPMarkColor)

/**
 * 获取字符串中多个相同字符的位置index
 * @param findText 以什么字符串查找
 * @return 返回找到位置下标数组
 */
- (NSMutableArray *)getAllRangeStringWithFindText:(NSString *)findText;

/**
 * 判断给定位置范围前一位和后一位是否都不是字母 （强调 都不是字母） 如果给定位置前后没有字符了也算都不是字母
 * @param wholeString 给定字符串
 * @param range 给定范围
 * @return YES 都不是字母 NO 前或者后有字母
 */
- (BOOL)checkPreAndNextCharaterIsAlphaWithWholeString:(NSString *)wholeString range:(NSRange)range;

@end
