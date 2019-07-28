//
//  BPMultiDelegateCenter.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/28.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPMultiDelegateCenter.h"
#import "BPMulticastDelegate.h"

@interface BPMultiDelegateCenter()

@property ( nonatomic, strong) BPMulticastDelegate *delegateProxy;

@end


static BPMultiDelegateCenter *single = nil;

@implementation BPMultiDelegateCenter

+ (BPMultiDelegateCenter *)shareCenter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[BPMultiDelegateCenter alloc] init];
    });
    return single;
}

// 多写的代码
- (void)setDelegate:(id)delegate {
    if (!_delegateProxy) {
        _delegateProxy = [BPMulticastDelegate alloc];
    }
    _delegateProxy.delegate = delegate;
}

- (void)removeDelegate:(id<BPDesignPatternsProtocol>)delegate {
    [_delegateProxy removeDelegate:delegate];
}

- (void)removeAllDelegate {
    [_delegateProxy removeAllDelegate];
}

- (void)callBack {
    // 改写的代码：强制转换为代理类型
    [(id<BPDesignPatternsProtocol>)_delegateProxy requiredMethod];
}

- (void)callBack1 {
    [(id<BPDesignPatternsProtocol>)_delegateProxy optionalMethod];
}

- (void)test {
    [self callBack];
    [self callBack1];
}

@end
