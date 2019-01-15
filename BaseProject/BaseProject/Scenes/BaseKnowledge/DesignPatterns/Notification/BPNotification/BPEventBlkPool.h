//
//  BPEventBlkPool.h
//  PSSNotification
//
//  Created by 泡泡 on 2018/11/13.
//  Copyright © 2018 泡泡. All rights reserved.
//

#import <Foundation/Foundation.h>

//在某通知下的某观察者对象的事件集合
@class BPEventBlk;

@interface BPEventBlkPool : NSObject

@property (nonatomic, strong) NSMutableArray<BPEventBlk *> *pool;

@end
