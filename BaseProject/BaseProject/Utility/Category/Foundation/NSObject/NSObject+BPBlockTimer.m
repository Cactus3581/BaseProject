//
//  NSObject+MKBlockTimer.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSObject+BPBlockTimer.h"


@implementation NSObject (BPBlockTimer)

- (void)_logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString *) prefixString {
	
	double a = CFAbsoluteTimeGetCurrent();
	block();
	double b = CFAbsoluteTimeGetCurrent();
	
	unsigned int m = ((b-a) * 1000.0f); // convert from seconds to milliseconds
	
	BPLog(@"%@: %d ms", prefixString ? prefixString : @"Time taken", m);
}
@end
