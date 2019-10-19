//
//  NSObject+MKBlockTimer.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BPBlockTimer)
- (void)_logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString *) prefixString;
@end
