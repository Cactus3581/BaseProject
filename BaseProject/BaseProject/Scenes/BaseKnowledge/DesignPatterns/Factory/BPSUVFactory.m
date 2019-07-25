//
//  BPSUVFactory.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPSUVFactory.h"
#import "BPSUVProduct.h"

@implementation BPSUVFactory

// 工厂
+ (BPProduct *)produce {
    return [[BPSUVProduct alloc] init];
}


@end
