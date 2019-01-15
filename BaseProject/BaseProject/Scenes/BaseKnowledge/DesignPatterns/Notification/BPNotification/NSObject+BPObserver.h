//
//  NSObject+BPObserver.h
//  PSSNotification
//
//  Created by 泡泡 on 2018/11/13.
//  Copyright © 2018 泡泡. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPEventBlkPool;

@interface NSObject (BPObserver)

@property (nonatomic, strong) BPEventBlkPool *eventBlkPool; // block事件池

@end



