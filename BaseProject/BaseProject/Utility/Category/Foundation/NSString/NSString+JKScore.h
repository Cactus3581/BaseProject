//
//  NSString+JKScore.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, NSStringJKScoreOption) {
    NSStringJKScoreOptionNone = 1 << 0,
    NSStringJKScoreOptionFavorSmallerWords = 1 << 1,
    NSStringJKScoreOptionReducedLongStringPenalty = 1 << 2
};

//模糊匹配字符串 查找某两个字符串的相似程度
@interface NSString (JKScore)

- (CGFloat)jk_scoreAgainst:(NSString *)otherString;
- (CGFloat)jk_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness;
- (CGFloat)jk_scoreAgainst:(NSString *)otherString fuzziness:(NSNumber *)fuzziness options:(NSStringJKScoreOption)options;

@end
