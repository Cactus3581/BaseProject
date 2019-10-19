//
//  BPDatabaseViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/2/6.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPDatabaseViewController.h"
#import "FMDatabaseManager.h"
#import "FMDatabaseQueueManager.h"
#import "DataBaseModel.h"
#import "BPDataBaseManager.h"
#import "SchoolModel.h"
#import "ClassModel.h"

@interface BPDatabaseViewController () <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,assign) NSInteger i;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation BPDatabaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.i = 1;
    [self creatBT];
    // 模糊查询
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    self.tableView.frame =CGRectMake(0, CGRectGetMaxY(searchBar.frame)+40, kScreenWidth, kScreenHeight-(CGRectGetMaxY(searchBar.frame)+40));
    self.tableView.backgroundColor = kRedColor;
    
    [BPDataBaseManager shareManager];
    
    
    
    //    [self.view addSubview:self.slideView];
    //    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.width.equalTo(self.view.mas_width);
    //        make.top.equalTo(self.view).offset(100);
    //        make.centerX.equalTo(self.view.mas_centerX);
    //        make.height.mas_equalTo(92/2.0);
    //    }];
    //
    //    self.slideView.goodsArray =@[@"熊出没",@"死神来了19",@"钢铁侠0",@"海上钢琴师",@"最后一只恐龙",@"苍井空",@"假如爱有天意",@"好好先生",@"特种部队",@"生化危机",@"生化危机"];
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj0", [NSNumber numberWithInt:0], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj5", [NSNumber numberWithInt:5], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj2", [NSNumber numberWithInt:2], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj3", [NSNumber numberWithInt:3], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj1", [NSNumber numberWithInt:1], nil],
                             [NSDictionary dictionaryWithObjectsAndKeys:@"Obj4", [NSNumber numberWithInt:4], nil], nil];
    
    //    NSArray *resultArray = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSNumber *number1 = [[obj1 allKeys] objectAtIndex:0];
        NSNumber *number2 = [[obj2 allKeys] objectAtIndex:0];
        
        NSComparisonResult result = [number1 compare:number2];
        
        return result == NSOrderedDescending; // 升序
        //        return result == NSOrderedAscending;  // 降序
    }];
    
    BPLog(@"%@",resultArray);
}

- (void)MaskInViewBt_1 {
//    self.i  = self.i+1;
    NSNumber *score = [NSNumber numberWithInteger:self.i];
    SchoolModel *model = [SchoolModel initializeWithName:@"一年级" TeacherName:@"张丽" StutentNumber:@34 BoyNumber:@20 GirlNumber:@14];
    
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (classId,className,teacherName,stutentNumber,boyNumber,girlNumber) VALUES (%ld,'%@','%@','%@','%@','%@')",TABLE_NAME_SCHOOL,(long)self.i,model.className,model.teacherName,model.stutentNumber,model.boyNumber,model.girlNumber];
    
    
    NSString * sql1 = [NSString stringWithFormat:@"INSERT INTO %@ (classId,className,teacherName,stutentNumber,boyNumber,girlNumber) VALUES (%ld,'%@','%@','%@','%@','%@')",TABLE_NAME_SCHOOL,(long)self.i,@"2年级",model.teacherName,model.stutentNumber,model.boyNumber,model.girlNumber];
    
    NSString * sql2 = [NSString stringWithFormat:@"INSERT INTO %@ (classId,className,teacherName,stutentNumber,boyNumber,girlNumber) VALUES (%ld,'%@','%@','%@','%@','%@')",TABLE_NAME_SCHOOL,(long)self.i+400,@"2年级",model.teacherName,model.stutentNumber,model.boyNumber,model.girlNumber];

#pragma mark - update-无事务-单条sql
    /*
     [[BPDataBaseManager shareManager] executeSQL:sql actionType:ST_DB_INSERT withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
     
     }];
     */
    
#pragma mark - update-无事务-数组sql
    /*
     [[BPDataBaseManager shareManager] executeUpdateSQLList:@[sql1,sql2] withBlock:^(BOOL bRet, NSString *msg) {
     
     }];
     */
    
#pragma mark - update-事务-单条sql
    /*
     [[BPDataBaseManager shareManager] executeUpdateTransactionSql:sql2 withBlock:^(BOOL bRet, NSString *msg, BOOL *bRollback) {
     
     }];
     */
    
#pragma mark - update-事务-数组sql
    
    for (int i = 0; i<5000; i++) {
        NSString * sqlopr = [NSString stringWithFormat:@"INSERT INTO %@ (classId,className,teacherName,stutentNumber,boyNumber,girlNumber) VALUES (%d,'%@','%@','%d','%d','%d')",TABLE_NAME_SCHOOL,i,[NSString stringWithFormat:@"%d年级",i+1],model.teacherName,i+100,i,5000-i];
        [[BPDataBaseManager shareManager] executeUpdateTransactionSql:sqlopr withBlock:^(BOOL bRet, NSString *msg, BOOL *bRollback) {
            
        }];
    }
    

     
//    [[BPDataBaseManager shareManager] executeUpdateTransactionSqlList:@[sql1,sql2] withBlock:^(BOOL bRet, NSString *msg, BOOL *bRollback) {
//        
//    }];
    
#pragma mark - quary-无事务-单条sql
    /*
     [[BPDataBaseManager shareManager] executeSQL:quarysql1 actionType:ST_DB_SELECT withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
     while ([rs next]) {
     NSString *name = [rs stringForColumn:@"className"];
     int classId = [rs intForColumn:@"classId"];
     BPLog(@"ID: %d, name: %@",classId,name);
     }
     }];
     */

#pragma mark - quary-事务-单条sql
    //    NSString * quarysql1 = [NSString stringWithFormat:@"select count (*) from %@ where classId >= 100",TABLE_NAME_SCHOOL];
    NSString * quarysql1 = [NSString stringWithFormat:@"select * from %@ order by className desc",TABLE_NAME_SCHOOL];
    /*
     quary:事务

     */
    
//    [[BPDataBaseManager shareManager] executeQueryTransactionSql:quarysql1 withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg, BOOL *bRollback) {
//        while ([rs next]) {
//            NSString *className = [rs stringForColumn:@"className"];
//            NSString *teacherName = [rs stringForColumn:@"teacherName"];
//
//            int classId = [rs intForColumn:@"classId"];
//            BPLog(@"ID: %d, name: %@",classId,className,teacherName);
//        }
//    }];
    
//    [[BPDataBaseManager shareManager] alertTableWithName:TABLE_NAME_SCHOOL Column:@"rank" Parameter:@"text"];

    
    /*
     [FMDatabaseManager insertAction:model];
     [FMDatabaseQueueManager insertAction:model];
     */
}

- (void)MaskInViewBt_2 {
//    [[BPDataBaseManager shareManager] addIndexWithName:TABLE_NAME_SCHOOL Column:@"className" Index:@"Pindex"];
    
    NSString * quarysql1 = [NSString stringWithFormat:@"select * from %@ order by className desc",TABLE_NAME_SCHOOL];

    
     [[BPDataBaseManager shareManager] executeSQL:quarysql1 actionType:ST_DB_SELECT withBlock:^(BOOL bRet, FMResultSet *rs, NSString *msg) {
         while ([rs next]) {
             NSString *className = [rs stringForColumn:@"className"];
             NSString *teacherName = [rs stringForColumn:@"teacherName"];
             
             int classId = [rs intForColumn:@"classId"];
             BPLog(@"ID: %d, name: %@, teacherName: %@",classId,className,teacherName);
         }
     
     }];
    
    /*
     [FMDatabaseManager modifyAction:model];
     [FMDatabaseQueueManager modifyAction:model];
     */
}

- (void)MaskInViewBt_3 {
    
    [[BPDataBaseManager shareManager] alertTableWithName:TABLE_NAME_SCHOOL Column:@"rank" Parameter:@"text"];


    /*
     [FMDatabaseManager deleteAction:model];
     [FMDatabaseQueueManager deleteAction:model];
     */
}

- (void)MaskInViewBt_4 {
    DataBaseModel *model = [DataBaseModel initializeWithName:@"哈3" Sex:@"男" Age:@18 Score:@2];
    BPLog(@"%ld",[[BPDataBaseManager shareManager] getDBVerison]);

    
    /*
     [FMDatabaseManager quaryAction_one:model];
     [FMDatabaseQueueManager quaryAction_one:model];
     */
}

- (void)MaskInViewBt_5
{
    /*
     [FMDatabaseManager transaction];
     [FMDatabaseQueueManager transactionByQueue];
     */
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma mark - 模糊查询功能演示
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//
//
//    NSString *querySql = [NSString stringWithFormat:@"SELECT * FROM STUDENT WHERE name LIKE '%%%@%%' OR store LIKE '%%%@%%'", searchText, searchText];
//    NSArray *modals = [DatabaseManager quaryAction:querySql];
//
//    [self.array addObjectsFromArray:modals];
//
//    BPLog(@"searchText = %@",searchText);
//
//    [DatabaseManager quaryAction:querySql];
//
//    [self.tableView reloadData];
//}

// 获取这些目录路径的方法：
- (void)creatPath
{
    // 1，获取家目录路径的函数：
    NSString *homeDir = NSHomeDirectory();
    BPLog(@"%@",homeDir);
    // 2，获取Documents目录路径的方法：
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [documentsPaths objectAtIndex:0];
    BPLog(@"%@",docDir);
    
    // 3，获取Caches目录路径的方法：
    NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [cachesPaths objectAtIndex:0];
    BPLog(@"%@",cachesDir);
    
    // 4，获取tmp目录路径的方法：
    NSString *tmpDir = NSTemporaryDirectory();
    BPLog(@"%@",tmpDir);
    
    // 5，获取应用程序程序包中资源文件路径的方法：
    //例如获取程序包中一个图片资源（apple.png）路径的方法：
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"apple" ofType:@"png"];
    UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    //代码中的mainBundle类方法用于返回一个代表应用程序包的对象。
    BPLog(@"%@",imagePath);
}

- (void)creatBT
{
    CGFloat widthBt = kScreenWidth/5;
    NSArray *array = @[@"插入",@"修改",@"删除",@"查询",@"待加入"];
    for (int i = 0; i<5; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(widthBt*i,64+30+10, widthBt, 30);
        
        if (i==0) {
            [bt addTarget:self action:@selector(MaskInViewBt_1) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (i==1)
        {
            [bt addTarget:self action:@selector(MaskInViewBt_2) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (i==2)
        {
            [bt addTarget:self action:@selector(MaskInViewBt_3) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (i==3)
        {
            [bt addTarget:self action:@selector(MaskInViewBt_4) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (i==4)
        {
            [bt addTarget:self action:@selector(MaskInViewBt_5) forControlEvents:UIControlEventTouchUpInside];
            
        }
        [bt setTitle:array[i] forState:UIControlStateNormal];
        [bt setTitleColor:kBlackColor forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.view addSubview:bt];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
