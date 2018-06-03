//
//  KSDictionaryPhrase.h
//  PowerWord7
//
//  Created by chenjie on 6/27/14.
//  Copyright (c) 2014 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//生词本权威词典分类第一层模型
@interface KSDictionaryPhrase : NSObject
@property (nonatomic, strong) NSArray *phrases; // array of KSDictionarySubItemPhrase
@end

//生词本权威词典分类第二层模型
@interface KSDictionarySubItemPhrase : NSObject
@property (nonatomic, strong) NSString *cizu_name; // 词条
@property (nonatomic, strong) NSArray *jx; //句型 array of KSDictionarySubItemPhraseJx
@end

@interface KSDictionarySubItemPhraseJx : NSObject
@property (nonatomic, strong) NSString *jx_en_mean; // 英文解释
@property (nonatomic, strong) NSString *jx_cn_mean; // 中文解释
@property (nonatomic, strong) NSArray *lj; //例句 array of KSDictionarySubItemPhraseJxLj
@end

@interface KSDictionarySubItemPhraseJxLj : NSObject
@property (nonatomic, strong) NSString *lj_ly; //例句英文
@property (nonatomic, strong) NSString *lj_ls; //例句中文
@end
