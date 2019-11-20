//
//  NSObject+BPDealloc.m
//  BaseProject
//
//  Created by Ryan on 2019/7/2.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "NSObject+BPDealloc.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (BPDealloc)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = NSSelectorFromString(@"dealloc");
        SEL swizzledSelector = @selector(deallocSwizzle);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)deallocSwizzle {
    [self deallocSwizzle];
}

@end
