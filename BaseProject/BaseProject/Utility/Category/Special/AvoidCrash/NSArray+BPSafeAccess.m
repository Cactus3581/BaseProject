//
//  NSArray+BPSafeAccess.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "NSArray+BPSafeAccess.h"

@implementation NSArray (BPSafeAccess)
- (id)objectAtIndexCheck:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    id value;
    if ([self objectAtIndex:index]) {
       value = [self objectAtIndex:index];
      
    }
    
    if (value == [NSNull null] ) {
        return nil;
    }

       return value;
}
@end
