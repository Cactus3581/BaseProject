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

// 简单工厂：只有一个工厂；根据参数来生成产品；新增产品，必须更改主类代码
+ (BPProduct *)produceWithType:(BPProductType)type;

// 工厂：多个工厂，新增产品，可以新建工厂类；但是一个工厂只有一个产品；
+ (BPProduct *)produce;

// 抽象工厂：相比工厂，一个工厂可以有多个产品；
+ (BPSUVProduct *)produceSuv;
+ (BPCarProduct *)produceCar;

@end

NS_ASSUME_NONNULL_END

