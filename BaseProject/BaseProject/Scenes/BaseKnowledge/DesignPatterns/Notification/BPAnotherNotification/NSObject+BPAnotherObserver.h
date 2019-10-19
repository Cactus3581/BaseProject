//
//  NSObject+BPAnotherObserver.h
//  BaseProject
//
//  Created by Ryan on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPEventBlkPool;

NS_ASSUME_NONNULL_BEGIN


@interface NSObject (BPAnotherObserver)

@property (nonatomic, strong) BPEventBlkPool *eventBlkPool; // block事件池

@end

NS_ASSUME_NONNULL_END
