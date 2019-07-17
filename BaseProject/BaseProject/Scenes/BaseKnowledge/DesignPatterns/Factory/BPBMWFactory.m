//
//  BPBMWFactory.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPBMWFactory.h"
#import "BPBMWSUVProduct.h"
#import "BPBMWCarProduct.h"

#import "BPSUVProduct.h"

@implementation BPBMWFactory

// 工厂
+ (BPProduct *)product {
    return [[BPSUVProduct alloc] init];
}

// 抽象工厂
- (BPSUVProduct *)suvProduct {
    return [[BPBMWSUVProduct alloc] init];
}

- (BPCarProduct *)carProduct {
    return [[BPBMWCarProduct alloc] init];
}

@end
