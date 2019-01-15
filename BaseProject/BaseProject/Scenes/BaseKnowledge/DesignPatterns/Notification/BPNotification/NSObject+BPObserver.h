//
//  NSObject+BPObserver.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPEventBlkPool;

@interface NSObject (BPObserver)

@property (nonatomic, strong) BPEventBlkPool *eventBlkPool; // block事件池

@end



