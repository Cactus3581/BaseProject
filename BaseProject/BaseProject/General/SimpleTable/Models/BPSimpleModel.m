//
//  BPSimpleModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPSimpleModel.h"
#import "NSObject+YYModel.h"

@implementation BPSimpleModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subVc_array" : [BPSimpleModel class],
            };
}

@end
