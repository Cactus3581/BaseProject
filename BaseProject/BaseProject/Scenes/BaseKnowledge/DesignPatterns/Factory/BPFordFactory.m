//
//  BPFordFactory.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPFordFactory.h"
#import "BPFordSUVProduct.h"
#import "BPFordCarProduct.h"

@implementation BPFordFactory

// 工厂
+ (BPProduct *)product {
    return [[BPCarProduct alloc] init];
}

// 抽象工厂
- (BPCarProduct *)carProduct {
    return [[BPFordCarProduct alloc] init];
}

- (BPSUVProduct *)suvProduct {
    return [[BPFordSUVProduct alloc] init];
}

@end
