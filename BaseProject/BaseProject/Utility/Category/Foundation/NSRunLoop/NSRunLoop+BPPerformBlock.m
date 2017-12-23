//
//  NSRunLoop+PerformBlock.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "NSRunLoop+BPPerformBlock.h"

NSString *const NSRunloopTimeoutException = @"NSRunloopTimeoutException";

@implementation NSRunLoop (BPPerformBlock)

- (void)_performBlockAndWait:(void (^)(BOOL *))block
{
    [self _performBlockAndWait:block timeoutInterval:10.0];
}

- (void)_performBlockAndWait:(void (^)(BOOL *))block timeoutInterval:(NSTimeInterval)timeoutInterval
{
    if (!block || timeoutInterval < 0.0) {
        [NSException raise:NSInvalidArgumentException format:@"%lf is invalid for timeout interval", timeoutInterval];
    }
    
    NSDate *startedDate = [NSDate date];
    BOOL finish = NO;
    
    block(&finish);
    
    while (!finish && [[NSDate date] timeIntervalSinceDate:startedDate] < timeoutInterval) {
        @autoreleasepool {
            [self runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
        }
    }
    
    if (!finish) {
        [NSException raise:NSRunloopTimeoutException format:@"execution of block timed out in performBlockAndWait:."];
    }
}

@end
