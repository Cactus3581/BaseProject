//
//  BPFordFactory.m
//  BaseProject
//
//  Created by Ryan on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPFordFactory.h"
#import "BPFordSUVProduct.h"
#import "BPFordCarProduct.h"

@implementation BPFordFactory

+ (BPCarProduct *)produceCar {
    return [[BPFordCarProduct alloc] init];
}

+ (BPSUVProduct *)produceSuv {
    return [[BPFordSUVProduct alloc] init];
}

@end
