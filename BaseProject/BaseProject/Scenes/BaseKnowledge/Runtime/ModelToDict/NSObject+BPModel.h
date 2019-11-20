//
//  NSObject+BPModel.h
//  BaseProject
//
//  Created by Ryan on 2018/12/27.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BPModel)

+ (instancetype)bp_modelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
