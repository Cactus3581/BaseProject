//
//  NSString+JKMatcher.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
//
//https://github.com/damienromito/NSString-Matcher
#import <Foundation/Foundation.h>
@interface NSString(JKMatcher)
- (NSArray *)jk_matchWithRegex:(NSString *)regex;
- (NSString *)jk_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;
- (NSString *)jk_firstMatchedGroupWithRegex:(NSString *)regex;
- (NSTextCheckingResult *)jk_firstMatchedResultWithRegex:(NSString *)regex;
@end
