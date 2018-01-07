//
//  SchoolModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/15.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "DataBaseModel.h"
#import "ClassModel.h"

@interface SchoolModel : DataBaseModel
@property (nonatomic,copy) NSString * className;
@property (nonatomic,strong) NSString * teacherName;
@property (nonatomic,copy) NSNumber * stutentNumber;
@property (nonatomic,copy) NSNumber * boyNumber;
@property (nonatomic,copy) NSNumber * girlNumber;

+ (instancetype)initializeWithName:(NSString *)className TeacherName:(NSString *)teacherName StutentNumber:(NSNumber *)stutentNumber BoyNumber:(NSNumber *)boyNumber GirlNumber:(NSNumber *)girlNumber;
@end
