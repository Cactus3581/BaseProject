//
//  NSAttributedString+BPMarkColor.m
//  BaseProject
//
//  Created by Ryan on 2018/4/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "NSAttributedString+BPMarkColor.h"
#import "NSString+BPMarkColor.h"

@implementation NSAttributedString (BPMarkColor)

/**
 * 给整个字符串中出现的FindString字符串背景上色,如果没有发现不会上色 并且不会改变原字符串其他属性
 * @param findString 需要上色的字符串
 * @param backgroundColor 需要上的颜色
 * @return 返回上过色的字符串
 */
- (NSMutableAttributedString *)attributedStringColorFindString:(NSString *)findString withBackgroundColor:(UIColor *)backgroundColor {
    return [self attributedStringColorFindStringArray:@[findString] withBackgroundColor:backgroundColor];
}

/**
 * 给整个字符串中出现的FindString字符串数组中的所有字符串并给背景上色,如果没有发现不会上色 并且不会改变原字符串其他属性
 * @param findStringArray 需要上色的字符串数组
 * @param backgroundColor 需要上的颜色
 * @return 返回上过色的字符串
 */
- (NSMutableAttributedString *)attributedStringColorFindStringArray:(NSArray *)findStringArray withBackgroundColor:(UIColor *)backgroundColor {
    NSMutableAttributedString *wholeAttributedString = [self mutableCopy];
    if(wholeAttributedString.length <= 0 || wholeAttributedString.string.length <= 0 || findStringArray.count <=0 || backgroundColor == nil) {
        return wholeAttributedString;
    }
    for (NSString *findString in findStringArray) {
        if(findString.length <= 0 || ![findString isKindOfClass:[NSString class]]) {
            continue;
        }
        NSMutableArray *testArray = [self.string getAllRangeStringWithFindText:findString];
        if(testArray.count > 0) {
            for (NSNumber *index in testArray) {
                NSRange range = NSMakeRange(index.integerValue, findString.length);
                [wholeAttributedString addAttribute:NSForegroundColorAttributeName value:backgroundColor range:range];
            }
        }
    }
    return wholeAttributedString;
}

@end
