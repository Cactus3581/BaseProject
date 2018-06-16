//
//  FMDBTools.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/12.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "FMDBTools.h"
#import "FMDB.h"

static FMDBTools *sharedManager=nil;

@implementation FMDBTools

+ (FMDBTools *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[FMDBTools alloc]init];
    });
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbPath = [path stringByAppendingPathComponent:DB_NAME];
        _dbQueue  = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self configueDBVersion];
    }
    return self;
}

/*
 *  初始化表结构
 */
- (void)configueDBVersion {
    if (![self getDBVerison]) {
        //系统之前没有数据库 新建立表。
        [self createTablesWithName:DB_CREATE_SCHOOLV3];
    }else{
        //表结构升级迭代
        [self updateDBVersion];
    }
}

/*
 *  创建新表
 */
- (void)createTablesWithName:(NSString *)tableName{
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            [db executeUpdate:tableName];
            //            [db executeUpdate:DB_CREATE_SCHOOLV3];
            
        }
        @catch (NSException *exception) {
            *rollback = YES;
        }
    }];
    [self saveVersion:SchoolDBVersionV3];
}

/*
 *  表结构升级迭代
 */
- (void)updateDBVersion {
    SchoolDBVersion ver = [self getDBVerison];
    switch (ver) {
        case SchoolDBVersionV1: {
            //            NSString *sql =[NSString stringWithFormat:@"insert into %@(classId,className,teacherName,stutentNumber,boyNumber,girlNumber)  select classId,className,teacherName,stutentNumber,boyNumber,girlNumber from temp%@",TABLE_NAME_SCHOOL,TABLE_NAME_SCHOOL];
            //            [self migrationWithVersion:SchoolDBVersionV2 CreateSql:DB_CREATE_SCHOOLV2 MigrationSql:sql];
        }
        case SchoolDBVersionV2: {
            NSString *sql =[NSString stringWithFormat:@"insert into %@(classId,className,teacherName,stutentNumber,girlNumber)  select classId,className,teacherName,stutentNumber,girlNumber from temp%@",TABLE_NAME_SCHOOL,TABLE_NAME_SCHOOL];
            [self migrationWithVersion:SchoolDBVersionV3 CreateSql:DB_CREATE_SCHOOLV3 MigrationSql:sql];
        }
        case SchoolDBVersionV3: {
            //已经是最新的表了，不需要升级
        }
            break;
        default:
            break;
    }
    
}

/*
 * 数据迁移
 */
- (void)migrationWithVersion:(NSInteger)version CreateSql:(NSString *)createSql MigrationSql:(NSString *)migrationSql {
    
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            //将原始表名T1 修改为 tempT1
            NSString *renameString = [NSString stringWithFormat:@"alter table %@ rename to temp%@",TABLE_NAME_SCHOOL,TABLE_NAME_SCHOOL];
            [db executeUpdate:renameString];
            
            //创建新表T1（V2版本的新表创建）
            [db executeUpdate:createSql];
            
            //迁移数据
            [db executeUpdate:migrationSql];
            
            //删除tempT1临时表
            NSString *dropTableStr = [NSString stringWithFormat:@"drop table temp%@",TABLE_NAME_SCHOOL];
            [db executeUpdate:dropTableStr];
        }
        @catch (NSException *exception) {
            *rollback = YES;
        }
    }];
    
    [self saveVersion:version];
}

/*
 无事务：单条sql，增删改查
 */
- (void)executeSQL:(NSString *)sqlStr actionType:(ST_DB_ActionType)actionType withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block {
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (actionType == ST_DB_SELECT) {
            //查询语句 需要返回记录集
            FMResultSet * rs = [db executeQuery:sqlStr];
            if ([db hadError]) {
                block(NO,rs,[db lastErrorMessage]);
                BPLog(@"executeSQL_quary error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
            }else{
                block(YES,rs,nil);
            }
        }else{
            //更新操作 只关心操作是否执行成功，不关心记录集  返回布尔值  无执行结果
            BOOL ret = [db executeUpdate:sqlStr];
            if (!ret) {
                block(NO,nil,[db lastErrorMessage]);
                BPLog(@"executeSQL_update error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
            }else{
                block(ret,nil,nil);
            }
        }
    }];
}

/*
 无事务；sql数组；update
 */
- (void)executeUpdateSQLList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, NSString *msg))block{
    __block BOOL bRet = NO;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        for (NSString * sql in sqlStrList) {
            bRet = [db executeUpdate:sql];
            if (!bRet) {
                block(bRet,[db lastErrorMessage]);
                BPLog(@"executeUpdateSQLList Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                break;
            }
        }
    }];
    block(bRet,nil);
}

/*
 事务；单条sql；update(有没有必要？)
 */
- (void)executeUpdateTransactionSql:(NSString *)sql withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block {
    __block BOOL bRet = NO;
    [_dbQueue  inTransaction:^(FMDatabase *db, BOOL *rollback){
        bRet = [db executeUpdate:sql];
        if (!bRet) {
            block(bRet, [db lastErrorMessage], rollback);
            BPLog(@"executeUpdateTransactionSql Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
            *rollback = YES;
        }
        block(bRet, nil, rollback);
    }];
}

/*
 事务；sql数组；update
 */
- (void)executeUpdateTransactionSqlList:(NSArray *)sqlStrArr withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block {
    __block BOOL bRet = NO;
    [_dbQueue  inTransaction:^(FMDatabase *db, BOOL *rollback){
        for (NSString *sqlStr in sqlStrArr) {
            bRet = [db executeUpdate:sqlStr];
            if (!bRet) {
                block(bRet, [db lastErrorMessage], rollback);
                BPLog(@"executeUpdateTransactionSqlList Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                *rollback = YES;
                break;
            }
        }
        block(bRet, nil, rollback);
    }];
}

/*
 增加字段
 */
- (void)alertTableWithName:(NSString *)tablename Column:(NSString *)column_name Parameter:(NSString *)parameter {
    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@",tablename,column_name,parameter];
    [_dbQueue  inTransaction:^(FMDatabase *db, BOOL *rollback){
        //查询语句 需要返回记录集
        BOOL ret = [db executeUpdate:sql];
        
        if (!ret) {
            BPLog(@"executeQueryTransactionSql error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
            *rollback = YES;
            return ;// 退出了这个block
        }else{
            
        };
    }];
}

/*
 字段创建索引
 */
- (void)addIndexWithName:(NSString *)tablename Column:(NSString *)column_name Index:(NSString *)index {
    NSString *sql = [NSString stringWithFormat:@"create index %@ on %@ (%@) ",index,tablename,column_name];
    [_dbQueue  inTransaction:^(FMDatabase *db, BOOL *rollback){
        //查询语句 需要返回记录集
        BOOL ret = [db executeUpdate:sql];
        if (!ret) {
            BPLog(@"executeQueryTransactionSql error %d:  %@",[db lastErrorCode],[db lastErrorMessage]);
            *rollback = YES;
            return ;// 退出了这个block
        }else{
            
        };
    }];
}

/*
 存取版本号
 */
- (void)saveVersion:(NSInteger) version
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:version] forKey:SchoolDBVersionNum];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
 获取版本号
 */
- (NSInteger )getDBVerison {
    SchoolDBVersion ver = [[[NSUserDefaults standardUserDefaults] objectForKey:SchoolDBVersionNum] integerValue];
    return ver;
}

@end
