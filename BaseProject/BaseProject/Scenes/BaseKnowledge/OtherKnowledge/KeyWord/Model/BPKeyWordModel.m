//
//  BPKeyWordModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/10/17.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPKeyWordModel.h"

// 报错
//NSString *str = @"obj_str";

// 不会报错
static NSString *static_str1 = @"obj_static_str1";

// 报错
//const NSString *const_Str1 = @"obj_const_Str1";
//NSString *const const_Str2 = @"obj_const_Str2";

// 不会报错
static  NSString *const static_const_str1 = @"obj_static_const_str1";//当指针时报错
static const NSString *static_const_str2 = @"obj_static_const_str2";//一般不这样用

@implementation BPKeyWordModel

- (instancetype)initModel1 {
    self = [super init];
    return self;
}

- (id)initModel2 {
    self = [super init];
    return self;
}

- (void)test {
    
}

@end
