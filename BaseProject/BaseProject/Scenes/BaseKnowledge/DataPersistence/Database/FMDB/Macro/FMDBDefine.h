//
//  FMDBDefine.h
//  BaseProject
//
//  Created by Ryan on 2017/5/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#ifndef FMDBDefine_h
#define FMDBDefine_h

#define DB_NAME         @"FMDBData.db"

#pragma mark -  学校数据库

//表名
#define TABLE_NAME_SCHOOL         @"schoolTable"

static NSString *const SchoolDBVersionNum  = @"SchoolDBVersionNum";

typedef NS_ENUM(NSInteger, SchoolDBVersion) {
    SchoolDBVersionV1 = 1,
    SchoolDBVersionV2,    //历史版本
    SchoolDBVersionV3,    //当前版本DB
};

#define DB_CREATE_SCHOOLV1 @"CREATE TABLE IF NOT EXISTS schoolTable (classId INTEGER primary key AUTOINCREMENT,className text,teacherName text,stutentNumber int,boyNumber int,girlNumber int)"

#define DB_CREATE_SCHOOLV2 @"CREATE TABLE IF NOT EXISTS schoolTable (classId INTEGER primary key AUTOINCREMENT,className text,teacherName text,stutentNumber int,boyNumber int,girlNumber int,prize BOOL)"

#define DB_CREATE_SCHOOLV3 @"CREATE TABLE IF NOT EXISTS schoolTable (classId INTEGER primary key AUTOINCREMENT,className text,teacherName text,stutentNumber int,girlNumber int,prize BOOL)"


#pragma mark -  世界数据库

//表名
#define TABLE_NAME_COUNTRY         @"countryTable"
#define TABLE_NAME_PROVINCE        @"provinceTable"

static NSString *const CountryDBVersionNum  = @"CountryDBVersionNum";

static NSString *const ProvinceDBVersionNum  = @"ProvinceDBVersionNum";

typedef NS_ENUM(NSInteger, CountryDBVersion) {
    CountryDBVersionV1 = 1,
//    CountryDBVersionV2,    //历史版本
//    CountryDBVersionV3,    //当前版本
};
typedef NS_ENUM(NSInteger, ProvinceDBVersion) {
    ProvinceDBVersionV1 = 1,
//    ProvinceDBVersionV2,    //历史版本
//    ProvinceDBVersionV3,    //当前版本
};

#define DB_CREATE_COUNTRY_V1 @"CREATE TABLE IF NOT EXISTS countryTable (countryId INTEGER primary key AUTOINCREMENT,name text,peopleCount double)"

#define DB_CREATE_PROVINCE_V1 @"CREATE TABLE IF NOT EXISTS provinceTable (provinceId INTEGER primary key AUTOINCREMENT,name text,peopleCount double)"


#endif /* FMDBDefine_h */
