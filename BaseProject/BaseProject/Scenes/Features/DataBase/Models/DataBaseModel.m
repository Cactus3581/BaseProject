//
//  DataBaseModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/7.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "DataBaseModel.h"

@implementation DataBaseModel

+ (instancetype)initializeWithName:(NSString *)name Sex:(NSString *)sex Age:(NSNumber *)age Score:(NSNumber *)score
{
    DataBaseModel *model = [[self alloc]init];
    model.name = name;
    model.sex = sex;
    model.age = age;
    model.score = score;

    return model;
}


@end
