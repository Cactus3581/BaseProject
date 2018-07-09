//
//  BPDataBaseQueueManager.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDataBaseQueueManager.h"

static NSString *kDB_NAME = @"cactus.db";
static BPDataBaseQueueManager *dataBase = nil;

typedef NS_ENUM(NSInteger, BPDBActionType) {
    BPDB_UPDATE,//更新操作
    BPDB_QUERY //查询操作
};


@interface BPDataBaseQueueManager()

@property(nonatomic,strong) FMDatabaseQueue *dbQueue;

@end


@implementation BPDataBaseQueueManager

+ (BPDataBaseQueueManager *)shareQueueManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [[BPDataBaseQueueManager alloc]init];
    });
    return dataBase;
}

- (instancetype)init {
    if (self = [super init]) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *dbPath = [path stringByAppendingPathComponent:kDB_NAME];
        _dbQueue  = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    }
    return self;
}

/*
 *  创建表
 */
- (void)createTablesWithName:(NSString *)tableName {
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        @try {
            [db executeUpdate:tableName];
        }
        @catch (NSException *exception) {
            *rollback = YES;
        }
    }];
}

/*
 无事务：单条sql，update
 */

- (void)executeUpdateSQL:(NSString *)sqlStr  withBlock:(void(^)(BOOL bRet,NSString *msg))block {
    [self executeSqlList:@[sqlStr] actionType:BPDB_UPDATE withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
        block(bRet,msg);
    }];
}

/*
 无事务：单条sql，Query
 */
- (void)executeQuerySQL:(NSString *)sqlStr  withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block {
    [self executeSqlList:@[sqlStr] actionType:BPDB_QUERY withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
        block(bRet,rs,msg);
    }];
}

/*
 无事务；sql数组；update
 */
- (void)executeUpdateSQLList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, NSString *msg))block {
    
    [self executeSqlList:sqlStrList actionType:BPDB_UPDATE withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
        block(bRet,msg);
    }];
    
}

/*
 无事务；sql数组；Query
 */
- (void)executeQuerySQLList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block {
    
    [self executeSqlList:sqlStrList actionType:BPDB_QUERY withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
        block(bRet,rs,msg);
    }];
    
}

/*
 无事务；全能方法
 */
- (void)executeSqlList:(NSArray *)sqlStrList actionType:(BPDBActionType)actionType withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block {
    
    __block BOOL bRet = NO;
    
    if (actionType == BPDB_QUERY) {
        
        //查询语句 需要返回记录集
        [_dbQueue inDatabase:^(FMDatabase *db) {
            for (NSString * sql in sqlStrList) {
                FMResultSet * rs = [db executeQuery:sql];
                if ([db hadError]) {
                    block(bRet,rs,[db lastErrorMessage]);
                    BPLog(@"execute_query_SqlList error %d: %@",[db lastErrorCode],[db lastErrorMessage]);
                    return;
                }else{
                    /*
                    while ([result next]) {
                        
                    }
                     */
                    block(bRet,rs,nil);
                }
            }
        }];
        
    }else {
        
        [_dbQueue inDatabase:^(FMDatabase *db) {
            //更新操作 只关心操作是否执行成功，不关心记录集  返回布尔值  无执行结果
            for (NSString * sql in sqlStrList) {
                bRet = [db executeUpdate:sql];
                if (!bRet) {
                    block(bRet,nil,[db lastErrorMessage]);
                    BPLog(@"execute_update_SqlList error %d: %@",[db lastErrorCode],[db lastErrorMessage]);
                    return;
                }else {
                    block(bRet,nil,nil);
                }
            }
        }];
    }
}

/*
 事务；单条sql；update
 */
- (void)executeUpdateInTransactionWithSql:(NSString *)sql withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block {
    [self executeInTransactionBySqlList:@[sql] actionType:BPDB_UPDATE withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg, BOOL *bRollback) {
        block(bRet,msg,bRollback);
    }];
}

/*
 事务；单条sql；Query
 */
- (void)executeQueryInTransactionWithSql:(NSString *)sql withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block {
    [self executeInTransactionBySqlList:@[sql] actionType:BPDB_UPDATE withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg, BOOL *bRollback) {
        block(bRet,rs,msg,bRollback);
    }];
}

/*
 事务；sql数组；update
 */
- (void)executeUpdateInTransactionWithSqlList:(NSArray *)sqlList withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block {
    [self executeInTransactionBySqlList:sqlList actionType:BPDB_UPDATE withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg, BOOL *bRollback) {
        block(bRet,msg,bRollback);
    }];
}

/*
 事务；sql数组；Query
 */
- (void)executeQueryInTransactionWithSqlList:(NSArray *)sqlList withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block {
    [self executeInTransactionBySqlList:sqlList actionType:BPDB_QUERY withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg, BOOL *bRollback) {
        block(bRet,rs,msg,bRollback);
    }];
}

/*
 事务；sql数组；万能方法
 */
- (void)executeInTransactionBySqlList:(NSArray *)sqlStrList actionType:(BPDBActionType)actionType withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block {
    
    __block BOOL bRet = NO;
    
    if (actionType == BPDB_QUERY) {
        
        [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback){
            for (NSString *sqlStr in sqlStrList) {
                FMResultSet *rs = [db executeQuery:sqlStr];
                if ([db hadError]) {
                    //当最后*rollback的值为YES的时候，事务回退，如果最后*rollback为NO，事务提交;
                    *rollback = YES;
                    block(bRet,rs,[db lastErrorMessage],rollback);
                    BPLog(@"execute_inTransaction_query_SqlList error %d: %@",[db lastErrorCode],[db lastErrorMessage]);
                    return;
                }else {
                    block(bRet,rs,nil,rollback);
                }
            }
        }];
        
    }else {
        [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback){
            for (NSString *sqlStr in sqlStrList) {
                bRet = [db executeUpdate:sqlStr];
                if (!bRet) {
                    //当最后*rollback的值为YES的时候，事务回退，如果最后*rollback为NO，事务提交;
                    *rollback = YES;
                    block(bRet,nil,[db lastErrorMessage],rollback);
                    BPLog(@"execute_inTransaction_update_SqlList error %d: %@",[db lastErrorCode],[db lastErrorMessage]);
                    return;
                }else {
                    block(bRet,nil,nil,rollback);
                }
            }
        }];
    }
}

#pragma mark - executeStatements

/*
 无事务；update;executeStatements
 */
- (void)executeStatementsUpdateBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet, NSString *msg))block {
    [self executeStatementsBySql:sql actionType:BPDB_UPDATE withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
        block(bRet,msg);
    }];
}

/*
 无事务；query;executeStatements
 */
- (void)executeStatementsQueryBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block {
    [self executeStatementsBySql:sql actionType:BPDB_QUERY withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
        block(bRet,rs,msg);
    }];
}

/*
 有事务；update;executeStatements
 */
- (void)executeStatementsUpdateInTransactionBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet,NSString *msg,BOOL *bRollback))block {
    
    [self executeStatementsInTransactionBySql:sql actionType:BPDB_UPDATE withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg, BOOL *bRollback) {
        block(bRet,msg,bRollback);
    }];
}

/*
 有事务；query;executeStatements
 */
- (void)executeStatementsQueryInTransactionBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block {
    [self executeStatementsInTransactionBySql:sql actionType:BPDB_QUERY withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg, BOOL *bRollback) {
        block(bRet,rs,msg,bRollback);
    }];
}

/*
 无事务；在一个字符串中执行多语句。
 */
- (void)executeStatementsBySql:(NSString *)sql actionType:(BPDBActionType)actionType withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block {
    
    __block BOOL bRet = NO;
    
    if (actionType == BPDB_QUERY) {
        
        //查询语句 需要返回记录集
        [_dbQueue inDatabase:^(FMDatabase *db) {
            
            bRet = [db executeStatements:sql withResultBlock:^int(NSDictionary * resultsDictionary) {
                
                BPLog(@"executeStatements_query error %d: %@",[db lastErrorCode],[db lastErrorMessage]);

                return 0;
                
            }];
        }];
        
    } else {
        
        [_dbQueue inDatabase:^(FMDatabase *db) {
            bRet = [db executeStatements:sql];
            if (!bRet) {
                block(bRet,nil,[db lastErrorMessage]);
                BPLog(@"executeStatements_update error %d: %@",[db lastErrorCode],[db lastErrorMessage]);
                return;
            }else {
                block(bRet,nil,nil);
            }
            
        }];
    }
}

/*
 事务；在一个字符串中执行多语句。
 */
- (void)executeStatementsInTransactionBySql:(NSString *)sql actionType:(BPDBActionType)actionType withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block {
    
    __block BOOL bRet = NO;
    
    if (actionType == BPDB_QUERY) {
        
        [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            bRet = [db executeStatements:sql withResultBlock:^int(NSDictionary * resultsDictionary) {
                
                return 0;
                
            }];
        }];
        
    }else {
        [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            
            bRet = [db executeStatements:sql];
            
            if (!bRet) {
                //当最后*rollback的值为YES的时候，事务回退，如果最后*rollback为NO，事务提交;
                *rollback = YES;
                block(bRet,nil,[db lastErrorMessage],rollback);
                BPLog(@"executeUpdateInTransactionBySqlList Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                return;
            }else {
                block(bRet,nil,nil,rollback);
            }
            
        }];
    }
}

/*
 增加字段
 */
- (void)alertTableWithName:(NSString *)tableName Column:(NSString *)columnName Parameter:(NSString *)parameter {
    NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@",tableName,columnName,parameter];
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

@end
