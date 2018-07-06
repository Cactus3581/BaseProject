//
//  BPDataBaseVersionManager.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDataBaseVersionManager.h"
#import "BPDataBaseQueueManager.h"
#import "FMDatabaseQueue.h"
#import "FMDBDefine.h"

static NSString *kDB_NAME = @"BPDataBase.db";

static NSString *kDB_TABLENAME = @"BPDataBase.db";

static BPDataBaseVersionManager *dataBaseUpdateManager = nil;


@interface BPDataBaseVersionManager()

@property (nonatomic,strong) BPDataBaseQueueManager *dataBase;

@end


@implementation BPDataBaseVersionManager

+ (BPDataBaseVersionManager *)shareDataBaseVersionManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBaseUpdateManager = [[BPDataBaseVersionManager alloc]init];
    });
    return dataBaseUpdateManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _dataBase = [BPDataBaseQueueManager shareQueueManager];
    }
    return self;
}

/*
 *  表结构升级迭代
 */
- (void)updateDBVersion {
//    SchoolDBVersion ver = [self getDBVerison];
//    switch (ver) {
//        case SchoolDBVersionV1: {
//            //            NSString *sql =[NSString stringWithFormat:@"insert into %@(classId,className,teacherName,stutentNumber,boyNumber,girlNumber)  select classId,className,teacherName,stutentNumber,boyNumber,girlNumber from temp%@",TABLE_NAME_SCHOOL,TABLE_NAME_SCHOOL];
//            //            [self migrationWithVersion:SchoolDBVersionV2 CreateSql:DB_CREATE_SCHOOLV2 MigrationSql:sql];
//        }
//        case SchoolDBVersionV2: {
//            NSString *sql =[NSString stringWithFormat:@"insert into %@(classId,className,teacherName,stutentNumber,girlNumber)  select classId,className,teacherName,stutentNumber,girlNumber from temp%@",TABLE_NAME_SCHOOL,TABLE_NAME_SCHOOL];
//            [self migrationWithVersion:SchoolDBVersionV3 CreateSql:DB_CREATE_SCHOOLV3 MigrationSql:sql];
//        }
//        case SchoolDBVersionV3: {
//            //已经是最新的表了，不需要升级
//        }
//            break;
//        default:
//            break;
//    }
}

/*
 * 数据迁移
 */
- (void)migrationWithVersion:(NSInteger)version CreateSql:(NSString *)createSql MigrationSql:(NSString *)migrationSql {
    
//    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
//        @try {
//            //将原始表名T1 修改为 tempT1
//            NSString *renameString = [NSString stringWithFormat:@"alter table %@ rename to temp%@",TABLE_NAME_SCHOOL,TABLE_NAME_SCHOOL];
//            [db executeUpdate:renameString];
//
//            //创建新表T1（V2版本的新表创建）
//            [db executeUpdate:createSql];
//
//            //迁移数据
//            [db executeUpdate:migrationSql];
//
//            //删除tempT1临时表
//            NSString *dropTableStr = [NSString stringWithFormat:@"drop table temp%@",TABLE_NAME_SCHOOL];
//            [db executeUpdate:dropTableStr];
//        }
//        @catch (NSException *exception) {
//            *rollback = YES;
//        }
//    }];
    
    [self saveVersion:version];
}

/*
 存取版本号
 */
- (void)saveVersion:(NSInteger) version {

}

/**
 *  返回表的版本号,表版本号信息存在于一张名为versionTable的表中。当表字段有更改时版本号加1.
 *  @param tableName 表名称
 *
 *  @return 版本号
 *  0：该表没有版本控制信息。1：默认版本号。其他
 */
- (NSInteger)getTableVersion:(NSString *)tableName {
    NSInteger number = 0;
    
    NSString *sql = [NSString stringWithFormat:@"tableName = '%@'",tableName];
//    [self.dataBase executeSelectSQL:@"" withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
//
//    }];
  
    return 0;
}
@end
