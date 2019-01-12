//
//  BPKVOModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/8.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPKVOModel.h"

@implementation BPKVOModel

// 手动设定KVO
- (void)changeIphone:(NSString *)iphone {
    [self willChangeValueForKey:@"iphone"];
    _iphone = iphone;
    [self didChangeValueForKey:@"iphone"];
}

//控制是否自动发送通知，如果返回NO，KVO无法自动运作，需手动触发。
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    // 如果监测到键值为iphone,则指定为非自动监听对象
    if ([key isEqualToString:@"iphone"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

@end
