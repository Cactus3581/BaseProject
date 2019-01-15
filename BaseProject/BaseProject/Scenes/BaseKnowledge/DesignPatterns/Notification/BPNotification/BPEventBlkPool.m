//
//  BPEventBlkPool.m
//  PSSNotification
//
//  Created by 泡泡 on 2018/11/13.
//  Copyright © 2018 泡泡. All rights reserved.
//

#import "BPEventBlkPool.h"
#import "BPEventBlk.h"
#import "BPNotificationCenter.h"

@implementation BPEventBlkPool

- (NSMutableArray<BPEventBlk *> *)pool {
    if (_pool == nil) {
        _pool = [[NSMutableArray alloc] init];
    }
    return _pool;
}

- (void)dealloc {
    NSLog(@"BPEventBlkPool 被销毁了，移除观察者下所有的通知");
    [[BPNotificationCenter defaultCenter] removeObserver:self];
}

@end
