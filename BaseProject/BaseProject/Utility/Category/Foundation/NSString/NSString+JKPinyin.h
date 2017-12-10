//
//  NSString+JKPinyin.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKPinyin)

- (NSString*)_pinyinWithPhoneticSymbol;
- (NSString*)_pinyin;
- (NSArray*)_pinyinArray;
- (NSString*)_pinyinWithoutBlank;
- (NSArray*)_pinyinInitialsArray;
- (NSString*)_pinyinInitialsString;

@end
