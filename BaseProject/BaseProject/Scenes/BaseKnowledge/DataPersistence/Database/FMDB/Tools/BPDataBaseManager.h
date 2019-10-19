//
//  BPDataBaseManager.h
//  BaseProject
//
//  Created by Ryan on 2017/5/12.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDBDefine.h"

@class FMResultSet;
typedef enum ST_DB_ActionType
{
    ST_DB_SELECT = 0,//查询操作
    ST_DB_INSERT,	 //插入操作
    ST_DB_UPDATE,	 //更新操作
    ST_DB_DELETE,	 //删除操作
    ST_DB_ADDUPDATE	 //更新或者插入操作
} ST_DB_ActionType;

@interface BPDataBaseManager : NSObject
@property(nonatomic,strong) FMDatabaseQueue *dbQueue;

+ (BPDataBaseManager *)shareManager;

/*
 无事务：单条sql，增删改查
 */
- (void)executeSQL:(NSString *)sqlStr actionType:(ST_DB_ActionType)actionType withBlock:(void(^)(BOOL bRet, FMResultSet *rs, NSString *msg))block;

/*
 无事务；sql数组；update
 */
- (void)executeUpdateSQLList:(NSArray *)sqlStrList withBlock:(void(^)(BOOL bRet, NSString *msg))block;

/*
 事务；单条sql；update
 */
- (void)executeUpdateTransactionSql:(NSString *)sql withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block;

/*
 事务；sql数组；update
 */
- (void)executeUpdateTransactionSqlList:(NSArray *)sqlStrArr withBlock:(void(^)(BOOL bRet, NSString *msg, BOOL *bRollback))block;


/*
 操作列(增加列)
 */
- (void)alertTableWithName:(NSString *)tablename Column:(NSString *)column_name Parameter:(NSString *)parameter;

/*
 操作索引
 */
- (void)addIndexWithName:(NSString *)tablename Column:(NSString *)column_name Index:(NSString *)index;
/*
 获取数据库版本
 */
- (NSInteger )getDBVerison;

/*
 存储表版本号
 */

- (void)saveVersionWithTableName:(NSString *)tableName tableVersion:(NSInteger) version;

/*
 获取版本号
 */
- (NSInteger )getDBVerisonWithTableName:(NSString *)tableName;
@end
