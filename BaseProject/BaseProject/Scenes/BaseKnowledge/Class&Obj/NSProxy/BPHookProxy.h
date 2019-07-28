//
//  BPHookProxy.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/6/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPHookProxy : NSProxy

- (instancetype)initWithObj:(id)obj;

- (void)execute:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
