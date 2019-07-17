//
//  BPFactory.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPCarProduct.h"
#import "BPSUVProduct.h"

typedef NS_ENUM(NSInteger,BPProductType) {
    BPProductCarType,
    BPProductSuvType,
};

NS_ASSUME_NONNULL_BEGIN

@interface BPFactory : NSObject

// 简单工厂
+ (BPProduct *)productWithType:(BPProductType)type;

// 工厂
+ (BPProduct *)product;

// 抽象工厂
+ (BPFactory *)factory;
- (BPSUVProduct *)suvProduct;
- (BPCarProduct *)carProduct;

@end

NS_ASSUME_NONNULL_END

