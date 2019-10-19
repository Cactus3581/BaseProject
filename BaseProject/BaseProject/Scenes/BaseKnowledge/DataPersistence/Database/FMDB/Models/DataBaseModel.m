//
//  DataBaseModel.m
//  BaseProject
//
//  Created by Ryan on 2017/2/7.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "DataBaseModel.h"

@implementation DataBaseModel

+ (instancetype)initializeWithName:(NSString *)name Sex:(NSString *)sex Age:(NSNumber *)age Score:(NSNumber *)score {
    DataBaseModel *model = [[self alloc]init];
    model.name = name;
    model.sex = sex;
    model.age = age;
    model.score = score;
    return model;
}

@end
