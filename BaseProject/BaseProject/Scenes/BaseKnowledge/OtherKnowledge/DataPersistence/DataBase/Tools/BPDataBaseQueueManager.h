//
//  BPDataBaseQueueManager.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@class FMDB;

@interface BPDataBaseQueueManager : NSObject

#pragma mark - 初始化

+ (BPDataBaseQueueManager *)shareQueueManager;

/*
 *  创建表
 */
- (void)createTablesWithName:(NSString *)tableName;

#pragma mark - 无事务
/*
 无事务：单条sql，update
 */

- (void)executeUpdateSQL:(NSString *)sqlStr  withBlock:(void(^)(BOOL bRet,NSString *msg))block;

/*
 无事务：单条sql，Query
 */
- (void)executeQuerySQL:(NSString *)sqlStr  withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block;

/*
 无事务；sql数组；update
 */
- (void)executeUpdateSQLList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, NSString *msg))block;

/*
 无事务；sql数组；Query
 */
- (void)executeQuerySQLList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block;

#pragma mark - 有事务

/*
 事务；单条sql；update
 */
- (void)executeUpdateInTransactionWithSql:(NSString *)sql withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block;

/*
 事务；单条sql；Query
 */
- (void)executeQueryInTransactionWithSql:(NSString *)sql withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block;

/*
 事务；sql数组；update
 */
- (void)executeUpdateInTransactionWithSqlList:(NSArray *)sqlList withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block;

/*
 事务；sql数组；Query
 */
- (void)executeQueryInTransactionWithSqlList:(NSArray *)sqlList withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block;

#pragma mark - 合并的sql语句：executeStatements

/*
 无事务；update;executeStatements
 */
- (void)executeStatementsUpdateBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet, NSString *msg))block;

/*
 无事务；query;executeStatements
 */
- (void)executeStatementsQueryBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block;

/*
 有事务；update;executeStatements
 */
- (void)executeStatementsUpdateInTransactionBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet,NSString *msg,BOOL *bRollback))block;

/*
 有事务；query;executeStatements
 */
- (void)executeStatementsQueryInTransactionBySql:(NSString *)sql withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg,BOOL *bRollback))block;

/*
 增加字段
 */
- (void)alertTableWithName:(NSString *)tableName Column:(NSString *)columnName Parameter:(NSString *)parameter;

/*
 字段创建索引
 */
- (void)addIndexWithName:(NSString *)tablename Column:(NSString *)column_name Index:(NSString *)index;

@end
