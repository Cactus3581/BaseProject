//
//  FMDatabaseQueueManager.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/7.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "FMDatabaseQueueManager.h"
#import "FMDatabaseAdditions.h"
static FMDatabaseQueue *sqlite = nil;

@implementation FMDatabaseQueueManager

/*
使用FMDatabaseQueue类在多线程中执行多个查询或更新是线程安全的.
FMDatabase这个类是线程不安全的，如果在多个线程中同时使用一个FMDatabase实例，会造成数据混乱等问题
为了保证线程安全，FMDB提供方便快捷的FMDatabaseQueue类
 */


+ (void)initialize
{
    if (sqlite) {
        return ;
    }
    //获取Document文件夹下的数据库文件，没有则创建

    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *databasePath = [path stringByAppendingPathComponent:@"DB_queue.sqlite"];
    
    BPLog(@"数据库路径 = %@",databasePath);
    
    // 创建一个FMDatabaseQueue对象
    // 只要创建数据库队列对象, FMDB内部就会自动给我们加载数据库对象
    
    sqlite = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    
    // 会通过block传递队列中创建好的数据库
    [sqlite inDatabase:^(FMDatabase *db) {
        
        BOOL success = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS STUDENT(stu_ID INTEGER PRIMARY KEY,name TEXT NOT NULL,sex TEXT DEFAULT 妖怪,age INTEGER DEFAULT 18,store FLOAT)"];
        
        if (success) {
            BPLog(@"创建表成功");
        } else {
            BPLog(@"创建表失败");
        }
    }];
}

+ (void)insertAction:(DataBaseModel *)model
{
    [sqlite inDatabase:^(FMDatabase *db) {
        bool result = [db executeUpdate:@"INSERT INTO STUDENT (name,sex,age,store) VALUES (?,?,?,?);", model.name,model.sex,model.age,model.score];
        if (result) {
            BPLog(@"插入成功");
        } else {
            BPLog(@"插入失败");
        }
    }];
}

+ (void)modifyAction:(DataBaseModel *)model
{
    // 修改数据
    [sqlite inDatabase:^(FMDatabase *db) {
        
//        BOOL result = [db executeUpdate:@"UPDATE STUDENT SET name = 'liwx' WHERE age > 12 AND age < 15;"];
        BOOL result = [db executeUpdate:@"UPDATE STUDENT SET name = ? WHERE age > 12 AND age < 15;",@"哈哈哈"];

        
        // 判断是否SQL是否执行成功
        // 判断是否SQL是否执行成功
        if (result) {
            BPLog(@"修改成功");
        } else {
            BPLog(@"修改失败");
        }
    }];
}

+ (void)deleteAction:(DataBaseModel *)model
{
    // 删除数据
    [sqlite inDatabase:^(FMDatabase *db) {
        
//        BOOL result = [db executeUpdate:@"DELETE FROM STUDENT WHERE age > 20 AND age < 25;"];
        BOOL result = [db executeUpdate:@"DELETE FROM STUDENT WHERE name = ?;",@"哈1"];

        
        // 判断是否SQL是否执行成功
        if (result) {
            BPLog(@"删除成功");
        } else {
            BPLog(@"删除失败");
        }
    }];
}


+ (void)quaryAction_one:(DataBaseModel *)model
{
//    这些方法都有一个 {type}ForColumnIndex: 变体，是基于列的位置来查询数据。
//    
//    通常情况下，一个 FMResultSet 没有必要手动 -close，因为结果集合 (result set) 被释放或者源数据库关闭会自动关闭。
//    

    [sqlite inDatabase:^(FMDatabase *db) {
        
//        FMResultSet *result = [db executeQuery:@"SELECT store, name, age FROM STUDENT WHERE age > 25;"];
        FMResultSet *result = [db executeQuery:@"SELECT store, name, age FROM STUDENT WHERE age > ?;",@25];
        while ([result next]) {
            float store = [result intForColumnIndex:0];
            NSString *name = [result stringForColumnIndex:1];
            int age = [result intForColumn:@"age"];
            BPLog(@"ID: %.2f, name: %@, age: %zd", store, name, age);
        }
    }];
}

+ (void)addColumn
{
//    //判断giveType字段是否存在
//    if (![sqlite columnExists:@"giveType" inTableWithName:@"ChildDevice_Table"]) {
//        
//        [sqlite inDatabase:^(FMDatabase *db) {
//            
//            BOOL result = [db executeUpdate:@"ALTER TABLE ? ADD ? INTEGER",@"ChildDevice_Table", @"giveType"];
//            // 判断是否SQL是否执行成功
//            if (result) {
//                BPLog(@"增加列成功");
//            } else {
//                BPLog(@"增加列失败");
//            }
//        }];
//    }
}

//多线程事务
+ (void)transactionByQueue {
    //开启事务
    [sqlite inTransaction:^(FMDatabase *db, BOOL *rollback) {
        for (int i = 0; i<500; i++) {
            NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i];
            NSString *sex = (i%2==0)?@"f":@"m";
            NSNumber *age = @(i+1);
            
            NSNumber *store = @(i+1);
            //
            NSString *sql = @"INSERT INTO STUDENT (name,sex,age,store) VALUES (?,?,?,?);";
            BOOL result = [db executeUpdate:sql,name,sex,age,store];
            if ( !result ) {
                //当最后*rollback的值为YES的时候，事务回退，就回滚数据。如果最后*rollback为NO，事务提交
                *rollback = YES;
                return;
            }
        }
    }];
}


@end
