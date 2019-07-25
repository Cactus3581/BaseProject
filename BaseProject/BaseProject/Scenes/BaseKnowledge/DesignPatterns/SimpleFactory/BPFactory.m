//
//  BPFactory.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPFactory.h"
#import "BPFordFactory.h"
#import "BPBMWFactory.h"

@implementation BPFactory

// 简单工厂
+ (BPProduct *)produceWithType:(BPProductType)type {
    
    BPProduct *product = nil;
    
    switch (type) {
        case BPProductCarType:{
            product = [BPCarProduct new];
        }
            break;
            
        case BPProductSuvType:{
            product = [BPSUVProduct new];
        }
            break;
    }
    return product;
}

@end
