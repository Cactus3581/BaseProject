//
//  NSString+JKRemoveEmoji.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (JKRemoveEmoji)
///移除所有emoji，以“”替换
- (NSString *)jk_removingEmoji;
///移除所有emoji，以“”替换
- (NSString *)jk_stringByRemovingEmoji;
///移除所有emoji，以string替换
- (NSString *)jk_stringByReplaceingEmojiWithString:(NSString*)string;

///字符串是否包含emoji
- (BOOL)jk_containsEmoji;
///字符串中包含的所有emoji unicode格式
- (NSArray<NSString *>*)jk_allEmoji;
///字符串中包含的所有emoji
- (NSString *)jk_allEmojiString;
///字符串中包含的所有emoji rang
- (NSArray<NSString *>*)jk_allEmojiRanges;

///所有emoji表情
+ (NSString*)jk_allSystemEmoji;
@end

@interface NSCharacterSet (JKEmojiCharacterSet)
+ (NSCharacterSet *)jk_emojiCharacterSet;
@end
