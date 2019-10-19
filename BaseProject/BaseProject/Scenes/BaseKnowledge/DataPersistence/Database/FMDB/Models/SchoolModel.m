//
//  SchoolModel.m
//  BaseProject
//
//  Created by Ryan on 2017/5/15.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "SchoolModel.h"

@implementation SchoolModel

+ (instancetype)initializeWithName:(NSString *)className TeacherName:(NSString *)teacherName StutentNumber:(NSNumber *)stutentNumber BoyNumber:(NSNumber *)boyNumber GirlNumber:(NSNumber *)girlNumber {
    SchoolModel *model = [[self alloc]init];
    model.className = className;
    model.teacherName = teacherName;
    model.stutentNumber = stutentNumber;
    model.boyNumber = boyNumber;
    model.girlNumber = girlNumber;
    return model;
}

@end
