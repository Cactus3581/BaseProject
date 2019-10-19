//
//  BPEventBlkPool.h
//  BaseProject
//
//  Created by Ryan on 2019/1/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

//在某通知下的某观察者对象的事件集合
@class BPEventBlk;

@interface BPEventBlkPool : NSObject

@property (nonatomic, strong) NSMutableArray<BPEventBlk *> *pool;

@end
