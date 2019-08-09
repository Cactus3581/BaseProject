//
//  BPListModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPListModel.h"
#import "NSObject+YYModel.h"

@implementation BPListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"subVc_array" : [BPListModel class],
            };
}

@end
