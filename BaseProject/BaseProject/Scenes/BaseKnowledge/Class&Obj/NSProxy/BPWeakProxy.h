//
//  BPWeakProxy.h
//  BaseProject
//
//  Created by Ryan on 2019/6/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPWeakProxy : NSProxy

- (instancetype)initWithTarget:(id)target;
- (NSString *)execute2:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
