//
//  BPAudioModel.m
//  BaseProject
//
//  Created by Ryan on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAudioModel.h"
#import "MJExtension.h"

@implementation BPAudioModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"identify": @"id"};
}

@end
