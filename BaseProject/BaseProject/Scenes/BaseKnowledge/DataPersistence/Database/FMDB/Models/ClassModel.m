//
//  ClassModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/15.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "ClassModel.h"

@implementation ClassModel

+ (instancetype)initializeWithName:(NSString *)name Sex:(NSString *)sex Age:(NSNumber *)age Score:(NSNumber *)score {
    ClassModel *model = [[self alloc]init];
    model.name = name;
    model.sex = sex;
    model.age = age;
    model.score = score;
    return model;
}

@end
