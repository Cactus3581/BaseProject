//
//  BPCarFactory.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPCarFactory.h"
#import "BPCarProduct.h"

@implementation BPCarFactory

// 工厂
+ (BPProduct *)produce {
    return [[BPCarProduct alloc] init];
}

@end
