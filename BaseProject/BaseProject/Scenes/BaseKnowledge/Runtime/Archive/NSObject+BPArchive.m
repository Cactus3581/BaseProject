//
//  NSObject+BPArchive.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/10/27.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "NSObject+BPArchive.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (BPArchive)

//- (void)encodeWithCoder:(NSCoder *)aCoder{
//    unsigned int outCount = 0;
//    Ivar *vars = class_copyIvarList([self class], &outCount);
//    for (int i = 0; i < outCount; i ++) {
//        Ivar var = vars[i];
//        const char *name = ivar_getName(var);
//        NSString *key = [NSString stringWithUTF8String:name];
//
//        id value = [self valueForKey:key];
//        [aCoder encodeObject:value forKey:key];
//    }
//}
//
//- (nullable __kindof)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [super init]) {
//        unsigned int outCount = 0;
//        Ivar *vars = class_copyIvarList([self class], &outCount);
//        for (int i = 0; i < outCount; i ++) {
//            Ivar var = vars[i];
//            const char *name = ivar_getName(var);
//            NSString *key = [NSString stringWithUTF8String:name];
//            id value = [aDecoder decodeObjectForKey:key];
//            [self setValue:value forKey:key];
//        }
//    }
//    return self;
//}

@end
