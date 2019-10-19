//
//  FMDatabaseManager.m
//  BaseProject
//
//  Created by Ryan on 2017/2/7.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "FMDatabaseManager.h"

static FMDatabase *sqlite = nil;

@implementation FMDatabaseManager

+ (FMDatabase *)openDataBase {
    
    if (sqlite) {
        return sqlite;
    }
    
     //获取Document文件夹下的数据库文件，没有则创建
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *databasePath = [path stringByAppendingPathComponent:@"DB.sqlite"];
    
    BPLog(@"数据库路径 = %@",databasePath);
    
    //获取数据库并打开
    sqlite = [FMDatabase databaseWithPath:databasePath];
    
    // 通过路径查询到文件 如果文件存在,打开;不存在先进行创建,再打开
    if ([sqlite open]) {
        //创建表单-创建sql语句
        NSString *sql = @"CREATE TABLE IF NOT EXISTS STUDENT(stu_ID INTEGER PRIMARY KEY,name TEXT NOT NULL,sex TEXT NOT NULL DEFAULT 妖怪,age INTEGER DEFAULT 18,store FLOAT)";
        //NSString *sql = @"CREATE TABLE IF NOT EXISTS STUDENT(name TEXT,sex TEXT DEFAULT 妖怪,age INTEGER DEFAULT 18,store FLOAT)";
        
        //执行sql语句,创建表（FMDB中只有update和query操作，除了查询其他都是update操作）
        bool result = [sqlite executeUpdate:sql];
        if (result) {
            BPLog(@"成功创表");
        }else {
            BPLog(@"创表失败");
        }
    }
    return sqlite;
}

+ (FMDatabase *)closeDataBase {
    //每次操作完成，应该 -close 来关闭数据库连接来释放SQLite使用的资源。
    [sqlite close];
    return sqlite;
}

/*更新操作
执行更新的SQL语句，字符串里面的"?"，依次用后面的参数替代，必须是对象，不能是int等基本类型
- (BOOL)executeUpdate:(NSString *)sql,... ;
 执行更新的SQL语句，可以使用字符串的格式化进行构建SQL语句
- (BOOL)executeUpdateWithFormat:(NSString *)format,... ;
 执行更新的SQL语句，字符串中有"?"，依次用arguments的元素替代
- (BOOL)executeUpdate:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;
*/

//插入
+ (void)insertAction:(DataBaseModel *)model {
    sqlite = [self openDataBase];
    if ([sqlite open]) {
        //1. 直接使用完整的SQL更新语句 */

        //1.1
        bool result = [sqlite executeUpdate:@"INSERT INTO STUDENT (name,sex,age,store) VALUES (?,?,?,?);", model.name,model.sex,model.age,model.score];
        //1.2
        [sqlite executeUpdate:@"INSERT INTO STUDENT (name,sex,age,store) VALUES 'liuting','男',20,29);"];
        
        
        // 2.使用不完整的SQL更新语句，里面含有待定字符串"?"，需要后面的参数进行替代
        
        //2.1
        NSString *sql = @"INSERT INTO STUDENT (name,sex,age,store) VALUES (?,?,?,?);";
        [sqlite executeUpdate:sql,@"liuting1",@"男",@30,@10];
        
        // 2.2 使用不完整的SQL更新语句，里面含有待定字符串"?"，需要数组参数里面的参数进行替代
        [sqlite executeUpdate:sql
           withArgumentsInArray:@[@"liuting1",@"男",@30,@10]];
        
        
        // 3.SQL语句字符串可以使用字符串格式化，这种我们应该比较熟悉
        
        [sqlite executeUpdateWithFormat:@"INSERT INTO STUDENT (name,sex,age,store) VALUES(%@,%@,%@,%@);",@"liuting1",@"男",@30,@10];
        
        if (result) {
            BPLog(@"插入成功");
        } else {
            BPLog(@"插入失败");
        }
    }
    [self closeDataBase];
}

//修改
+ (void)modifyAction:(DataBaseModel *)model {
    
    sqlite = [self openDataBase];
    if ([sqlite open]) {
        /*
        NSString *modifySql = @"UPDATE STUDENT SET store = '20' WHERE name = '哈4'";

        bool result = [sqlite executeUpdate:modifySql];
        */
        
        /*
        bool result = [sqlite executeUpdate:@"UPDATE STUDENT SET store = ? WHERE name = ?;", @20, @"哈5"];
        */
        BOOL result = [sqlite executeUpdate:@"UPDATE STUDENT SET name = 'liwx' WHERE age > 12 AND age < 15;"];
        
        
        if (result) {
            BPLog(@"修改成功");
            
        } else {
            BPLog(@"修改失败");
        }
    }
    [self closeDataBase];
    
}

//删除
+ (void)deleteAction:(DataBaseModel *)model {
    
    NSString *deleteSql = @"DELETE FROM STUDENT WHERE name = '哈5'";
    
    if (model.name == nil) {
        deleteSql = @"DELETE FROM STUDENT";
    }
    
    sqlite = [self openDataBase];
    if ([sqlite open]) {
        
        /* 1
        BOOL result = [sqlite executeUpdate:deleteSql];
         */
        
        
        /* 2
        BOOL result = [sqlite executeUpdate:@"DELETE FROM STUDENT WHERE age > 20 AND age < 25;"];
         */
        
        /* 3
        
        BOOL result = [sqlite executeUpdateWithFormat:@"DELETE FROM STUDENT WHERE name = %@",model.name];
         */

        
        //4
        BOOL result = [sqlite executeUpdate:@"DELETE FROM STUDENT WHERE age > ? AND age < ?;",model.age];
 
        if (result) {
            BPLog(@"删除成功");
            
        } else {
            BPLog(@"删除失败");
        }
    }
    [self closeDataBase];
}

//查询
//查询方法也有3种
/*
 
 // 全部查询
 - (FMResultSet *)executeQuery:(NSString *)sql, ...
 // 条件查询
 - (FMResultSet *)executeQueryWithFormat:(NSString *)format, ...
 - (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
 
 */


+ (void)quaryAction_one:(DataBaseModel *)model {
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM STUDENT WHERE name LIKE '%%%@%%' OR store LIKE '%%%@%%'", model.name, model.score];
    
    if (model.name == nil) {
        //查询全部
        querySql = @"SELECT * FROM STUDENT;";
    }
    
    sqlite = [self openDataBase];
    if ([sqlite open]) {
        //条件查询
        //执行查询SQL语句，返回查询结果

        /*
        FMResultSet *result = [sqlite executeQuery:@"SELECT id, name, age FROM STUDENT WHERE age > 25;"];
         */
        
        /*
        FMResultSet *resultSet = [sqlite executeQuery:@"SELECT *FORM STUDENT WHERE name = ?",@"哈8"];
         */
        /*
        FMResultSet *resultSet = [sqlite executeQueryWithFormat:@"SELECT *FORM STUDENT WHERE name = %@",model.name];
         */
        
        //1.执行查询
        FMResultSet *set = [sqlite executeQuery:querySql];
        
        
        //2.遍历结果集:获取查询结果的下一个记录

        while ([set next]) {
            //根据字段名，获取记录的值，存储到model中

            //NSString *name1 = [result stringForColumnIndex:1];
            
            NSString *name = [set stringForColumn:@"name"];
            NSString *sex = [set stringForColumn:@"sex"];
            
            NSNumber *age = [NSNumber numberWithInteger:[[set stringForColumn:@"age"] integerValue]] ;
            NSNumber *store =  [NSNumber numberWithInteger:[[set stringForColumn:@"store"] floatValue]] ;;
            
            DataBaseModel *modal = [DataBaseModel initializeWithName:name Sex:sex Age:age Score:store];
            //把字典添加进数组中

            [arrM addObject:modal];
        }
        
        for (DataBaseModel *aaa in arrM) {
            BPLog(@"%@,%@",aaa.name,model.score);
        }
    }
    [self closeDataBase];
}

+ (NSArray *)quaryAction:(NSString *)querySql {
    NSMutableArray *arrM = [NSMutableArray array];
    
    if (querySql == nil) {
        querySql = @"SELECT * FROM STUDENT;";
    }
    
    sqlite = [self openDataBase];
    if ([sqlite open]) {
        FMResultSet *set = [sqlite executeQuery:querySql];
        
        while ([set next]) {
            
            NSString *name = [set stringForColumn:@"name"];
            NSString *sex = [set stringForColumn:@"sex"];
            
            NSNumber *age = [NSNumber numberWithInteger:[[set stringForColumn:@"age"] integerValue]] ;
            NSNumber *store =  [NSNumber numberWithInteger:[[set stringForColumn:@"store"] floatValue]] ;;
            
            DataBaseModel *modal = [DataBaseModel initializeWithName:name Sex:sex Age:age Score:store];
            [arrM addObject:modal];
        }
    }
    
    [self closeDataBase];
    return [arrM copy];
}

//事务
+ (void)transaction {
    
    sqlite = [self openDataBase];
    if ([sqlite open]) {
        // 开启事务
        [sqlite beginTransaction];
        BOOL isRollBack = NO;
        @try {
            for (int i = 0; i<500; i++) {
                NSString *name = [[NSString alloc] initWithFormat:@"student_%d",i];
                NSString *sex = (i%2==0)?@"f":@"m";
                NSNumber *age = @(i+1);

                NSNumber *store = @(i+1);
//
//                NSString *sql = @"INSERT INTO STUDENT (name,sex,age,store) VALUES (?,?,?,?);";
//                BOOL result = [sqlite executeUpdate:sql,name,sex,age,store];
                
//                bool result = [sqlite executeUpdate:@"INSERT INTO STUDENT (name,sex,age,store) VALUES (?,?,?,?);", name,sex,age,store];
                
                
                NSString *sql = @"INSERT INTO STUDENT (name,sex,age,store) VALUES (?,?,?,?);";
                BOOL result = [sqlite executeUpdate:sql,name,sex,age,store];

                
                if (result) {
                    BPLog(@"插入成功");
                    
                } else {
                    BPLog(@"插入失败");
                    return;
                }
            }
        }
        @catch (NSException *exception) {
            isRollBack = YES;
            // 事务回退
            [sqlite rollback];
        }
        @finally {
            if (!isRollBack) {
                //事务提交
                [sqlite commit];
            }
        }
    }
    [self closeDataBase];
}

- (void)sdsdasda {
    NSString *sql =@"create table bulktest1 (id integer primary key autoincrement, x text);"
    
    "create table bulktest2 (id integer primary key autoincrement, y text);"
    
    "create table bulktest3 (id integer primary key autoincrement, z text);"
    
    "insert into bulktest1 (x) values ('XXX');"
    
    "insert into bulktest2 (y) values ('YYY');"
    
    "insert into bulktest3 (z) values ('ZZZ');";
    
    //1
    
    BOOL success = [sqlite executeStatements:sql];
    
    sql =@"select count(*) as count from bulktest1;"
    
    "select count(*) as count from bulktest2;"
    
    "select count(*) as count from bulktest3;";
    
    //2
    success = [sqlite executeStatements:sql withResultBlock:^int(NSDictionary *dictionary) {
        NSInteger count = [dictionary[@"count"] integerValue];
//        XCTAssertEqual(count,1,@"expected one record for dictionary%@", dictionary);
        return 0;
    }];
}

- (void)addData{
    //    插入数据类型必须为NSObject 的子类
    //
    //    基本类型需要封装为对应的包装类
    //
    //    支持占位符，后添加再数据
    //
    NSDictionary *dic = @{
                          @"code": @0,
                          @"msg": @"success",
                          @"data": @{
                                  @"course": @{
                                          @"id": @24,
                                          @"crowdId": @4,
                                          @"ccode": @"KIa8nNpVmc",
                                          @"cname": @"健健康康",
                                          @"coverImg": @"http://ocd2lp9uj.bkt.clouddn.com/FaceQ1445612150222.jpg",
                                          @"description": @"淋漓尽致",
                                          @"speaker": @2,
                                          @"speakerName": @"刘欣成",
                                          @"speakerHeadIcon": @"http://ocd2lp9uj.bkt.clouddn.com/FaceQ1445612150222.jpg",
                                          @"startTime": @"2016-10-15 11:21:44",
                                          @"endTime": @"2016-10-15 11:26:50",
                                          @"liveStatus": @"2",
                                          @"saveStatus": @"2"
                                          }
                                  }
                          };
    NSString *json = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    
    if ([sqlite open]){
        NSString *insertSql = @"insert into 't_down_course'(fileName,courseInfo) values(?,?)";
        BOOL result = [sqlite executeUpdate:insertSql,@"fileName",json];
        if (result){
            BPLog(@"添加数据成功");
        }else{
            BPLog(@"添加数据失败");
        }
        [sqlite close];
    }else{
        BPLog(@"打开数据库 --- 失败");
    }
    
    
    //插入也支持以字典的方式
    
    //字典1
    NSString *comment = @"good";
    int identifier = 20;

    NSString *name = @"name";

    NSString *date = @"date";

    NSDictionary *arguments = @{
                                @"identifier": @(identifier),
                                @"name": name,
                                @"date": date,
                                @"comment": comment ?: [NSNull null]};
    BOOL success = [sqlite executeUpdate:@"INSERT INTO authors (identifier, name, date, comment) VALUES (:identifier, :name, :date, :comment)" withParameterDictionary:arguments];
    if (!success) {
        BPLog(@"error = %@", [sqlite lastErrorMessage]);
    }
    
    //字典2
    NSDictionary *argsDict = [NSDictionary dictionaryWithObjectsAndKeys:@"My Name", @"name", nil];
    [sqlite executeUpdate:@"INSERT INTO myTable (name) VALUES (:name)" withParameterDictionary:argsDict];
}

@end
