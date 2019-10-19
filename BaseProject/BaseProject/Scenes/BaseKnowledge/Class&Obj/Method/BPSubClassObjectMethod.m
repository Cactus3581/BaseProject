//
//  BPSubClassObjectMethod.m
//  BaseProject
//
//  Created by Ryan on 2018/1/24.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSubClassObjectMethod.h"

@implementation BPSubClassObjectMethod

+ (void)classMethod {
    [super classMethod];
    BPLog(@"sub_classMethod");
}

- (void)objcMethod {
    [super objcMethod];
    BPLog(@"sub_objcMethod");
}

@end
