//
//  NSTimer+BPUnRetain.h
//  PowerWord7
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BPUnRetain)
+ (NSTimer *)bp_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block;


@end
