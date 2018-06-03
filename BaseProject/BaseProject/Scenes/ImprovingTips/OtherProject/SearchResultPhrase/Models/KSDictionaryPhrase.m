//
//  KSDictionaryPhrase.m
//  PowerWord7
//
//  Created by chenjie on 6/27/14.
//  Copyright (c) 2014 Kingsoft. All rights reserved.
//

#import "KSDictionaryPhrase.h"

@implementation KSDictionaryPhrase

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"phrases":[KSDictionarySubItemPhrase class]};
}

@end


@implementation KSDictionarySubItemPhrase

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"jx":[KSDictionarySubItemPhraseJx class]};
}

@end


@implementation KSDictionarySubItemPhraseJx

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"lj":[KSDictionarySubItemPhraseJxLj class]};
}

@end


@implementation KSDictionarySubItemPhraseJxLj

@end

