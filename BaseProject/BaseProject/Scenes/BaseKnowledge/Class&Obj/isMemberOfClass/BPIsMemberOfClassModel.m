//
//  BPIsMemberOfClassModel.m
//  BaseProject
//
//  Created by Ryan on 2019/2/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPIsMemberOfClassModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation BPIsMemberOfClassModel

//- (Class)class {
//    
//}
//
//+ (Class)class {
//    
//}

+ (BOOL)isMemberOfClass:(Class)aClass {
    return object_getClass((id)self) == aClass;
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [self class] == aClass;
}

/*
+ (BOOL)isKindOfClass:(Class)aClass {
    for (Class tcls = object_getClass((id)self); tcls; tcls = tcls->superclass) {
        if(tcls == aClass) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isKindOfClass:(Class)aClass {
    for (Class tcls = [self class]; tcls; tcls = tcls->superclass) {
        if(tcls == aClass) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isSubclassOfClass:(Class)aClass {
    for (Class tcls = self; tcls; tcls = tcls->superclass) {
        if (tcls == aClass) {
            return YES;
        }
    }
    return NO;
}
 */

@end
