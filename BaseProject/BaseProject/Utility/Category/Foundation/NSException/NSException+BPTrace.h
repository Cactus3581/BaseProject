//
//  NSException+Trace.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSException (BPTrace)
- (NSArray *)_backtrace;
@end
