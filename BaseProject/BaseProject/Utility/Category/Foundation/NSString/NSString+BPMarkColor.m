//
//  NSString+BPMarkColor.m
//  BaseProject
//
//  Created by Ryan on 2018/4/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "NSString+BPMarkColor.h"

@implementation NSString (BPMarkColor)

/**
 * 获取字符串中多个相同字符的位置index
 * @param findText 以什么字符串查找
 * @return 返回找到位置下标数组
 */
- (NSMutableArray *)getAllRangeStringWithFindText:(NSString *)findText {
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:0];
    if (self.length <= 0 || findText.length <= 0) {
        return nil;
    }
    NSString *wholeString = [self copy];
    NSRange range = [wholeString rangeOfString:findText options:NSCaseInsensitiveSearch]; //获取第一次出现的range
    if (range.location != NSNotFound && range.length != 0) {
        if([self checkPreAndNextCharaterIsAlphaWithWholeString:wholeString range:range]) {
            [arrayRanges addObject:[NSNumber numberWithInteger:range.location]];//将第一次的加入到数组中
        }
        NSRange range1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;;i++) {
            if (i == 0) {
                //去掉第一次找到的字符串
                location = range.location + range.length;
                length = wholeString.length - range.location - range.length;
                range1 = NSMakeRange(location, length);
            } else {
                location = range1.location + range1.length;
                length = wholeString.length - range1.location - range1.length;
                range1 = NSMakeRange(location, length);
            }
            
            //在一个range范围内查找另一个字符串的range
            range1 = [wholeString rangeOfString:findText options:NSCaseInsensitiveSearch range:range1];
            if (range1.location == NSNotFound && range1.length == 0) {
                break;
            } else {
                if([self checkPreAndNextCharaterIsAlphaWithWholeString:wholeString range:range1]) {
                    [arrayRanges addObject:[NSNumber numberWithInteger:range1.location]];//将第一次的加入到数组中
                }
            }
        }
        return arrayRanges;
    }
    
    return nil;
}

- (BOOL)checkPreAndNextCharaterIsAlphaWithWholeString:(NSString *)wholeString range:(NSRange)range {
    NSString *alphaTest = @"[a-zA-Z]";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphaTest];
    //判断找出的串前后是否还有其他字母
    //1.判断字符串找到位置前面一位是否为字母
    BOOL preStringIsAlpha = NO;
    BOOL nextStringIsAlpha = NO;
    NSString *preString = [wholeString substringToIndex:range.location];
    if(preString.length >=1 ) {
        NSString *preCharacterString = [wholeString substringWithRange:NSMakeRange(preString.length-1, 1)];
        preStringIsAlpha = [emailTest evaluateWithObject:preCharacterString];
    }
    //2.判断字符串找到位置后面一位是否为字母
    if(wholeString.length - (range.location+ range.length)>= 1) {
        NSString *nextCharacterString = [wholeString substringWithRange:NSMakeRange(range.location+range.length, 1)];
        nextStringIsAlpha = [emailTest evaluateWithObject:nextCharacterString];
    }
    //前后同时不为字母 则判断找到
    return preStringIsAlpha == NO && nextStringIsAlpha == NO;
}

@end
