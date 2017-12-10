//
//  UITextField+Select.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JKSelect)
/**
 *  @brief  当前选中的字符串范围
 *
 *  @return NSRange
 */
- (NSRange)bp_selectedRange;
/**
 *  @brief  选中所有文字
 */
- (void)bp_selectAllText;
/**
 *  @brief  选中指定范围的文字
 *
 *  @param range NSRange范围
 */
- (void)bp_setSelectedRange:(NSRange)range;
@end
