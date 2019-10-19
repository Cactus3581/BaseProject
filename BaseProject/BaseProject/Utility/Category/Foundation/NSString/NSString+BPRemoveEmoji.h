//
//  NSString+BPRemoveEmoji.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSString (BPRemoveEmoji)
///移除所有emoji，以“”替换
- (NSString *)_removingEmoji;
///移除所有emoji，以“”替换
- (NSString *)_stringByRemovingEmoji;
///移除所有emoji，以string替换
- (NSString *)_stringByReplaceingEmojiWithString:(NSString *)string;

///字符串是否包含emoji
- (BOOL)_containsEmoji;
///字符串中包含的所有emoji unicode格式
- (NSArray<NSString *>*)_allEmoji;
///字符串中包含的所有emoji
- (NSString *)_allEmojiString;
///字符串中包含的所有emoji rang
- (NSArray<NSString *>*)_allEmojiRanges;

///所有emoji表情
+ (NSString *)_allSystemEmoji;
@end

@interface NSCharacterSet (BPEmojiCharacterSet)
+ (NSCharacterSet *)_emojiCharacterSet;
@end
