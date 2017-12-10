//
//  NSString+JKPinyin.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JKPinyin)

- (NSString*)jk_pinyinWithPhoneticSymbol;
- (NSString*)jk_pinyin;
- (NSArray*)jk_pinyinArray;
- (NSString*)jk_pinyinWithoutBlank;
- (NSArray*)jk_pinyinInitialsArray;
- (NSString*)jk_pinyinInitialsString;

@end
