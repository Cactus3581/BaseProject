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
- (NSArray *)_matchWithRegex:(NSString *)regex;
- (NSString *)_matchWithRegex:(NSString *)regex atIndex:(NSUInteger)index;
- (NSString *)_firstMatchedGroupWithRegex:(NSString *)regex;
- (NSTextCheckingResult *)_firstMatchedResultWithRegex:(NSString *)regex;
@end
