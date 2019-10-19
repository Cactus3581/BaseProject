//
//  BPNotification.h
//  BaseProject
//
//  Created by Ryan on 2019/8/8.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPNotification : NSObject

@property (weak) id observer;
@property (strong) id observer_strong;
@property (strong) NSString *observerId;
@property (assign) SEL selector;
@property (weak) id object;
@property (copy) NSString *name;
@property (strong) NSOperationQueue *queue;
//@property (copy) void(^block)(YBNotification *noti);

@end

NS_ASSUME_NONNULL_END
