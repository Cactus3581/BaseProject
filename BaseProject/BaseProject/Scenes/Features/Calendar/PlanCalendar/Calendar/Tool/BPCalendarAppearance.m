//
//  BPCalendarAppearance.m
//  BaseProject
//
//  Created by Ryan on 2017/11/30.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPCalendarAppearance.h"

@interface BPCalendarAppearance()
@end

static BPCalendarAppearance *appearance = nil;

@implementation BPCalendarAppearance
#pragma mark - 初始化
+ (instancetype)appearance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appearance = [[self alloc]init];
    });
    return appearance;
}


#pragma mark - 封堵alloc及copy
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(appearance == nil) {
            appearance = [super allocWithZone:zone];
        }
    });
    return appearance;
}

//保证copy时相同
- (instancetype)copyWithZone:(NSZone *)zone {
    return appearance;
}

@end
