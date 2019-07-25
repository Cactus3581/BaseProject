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

+ (BPSUVProduct *)produceSuv {
    return [[BPBMWSUVProduct alloc] init];
}

+ (BPCarProduct *)produceCar {
    return [[BPBMWCarProduct alloc] init];
}

@end
