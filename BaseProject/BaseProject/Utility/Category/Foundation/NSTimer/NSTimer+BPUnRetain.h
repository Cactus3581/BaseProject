//
//  NSTimer+BPUnRetain.h
//  BaseProject
//
//  Created by Ryan on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BPUnRetain)
+ (NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block;


@end
