//
//  DataPersistenceVC.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/16.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "DataPersistenceVC.h"

#import "ArchiverModel.h"
#import "ArchiverSubModel.h"

#import "DataManager.h"

@interface DataPersistenceVC ()

@end

@implementation DataPersistenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
//    [self setNSString];
//    [self setNSArray];
//    [self setDic_plist];
//    [self setModel_archiver];
//    [self setModel_more_arch];
}


#pragma mark - 归档多个自定义对象
- (void)setModel_more_arch
{
//    通过NSData 和 NSKeyedArchive 实现一个文件归档多个对象
    ArchiverModel *model = [[ArchiverModel alloc]initWithName:@"aaaa" Age:22];
    ArchiverModel *model1 = [[ArchiverModel alloc]initWithName:@"bbbb" Age:100];

    NSString *path = [[DataManager shareDataManager] getPath:@"model_archiver_more.plist"];
    
    //1.创建可变data:容器
    NSMutableData *muData = [NSMutableData data];
    //2.创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:muData];
    
    //3.归档
    [archiver encodeObject:model forKey:@"model_encode"];
    [archiver encodeObject:model1 forKey:@"model1_encode"];

    //4.归档完成
    [archiver finishEncoding];
    
    [muData writeToFile:path atomically:YES];

    [self getModel_more_arch];
    
    
}

- (void)getModel_more_arch
{
    NSString *path = [[DataManager shareDataManager]  getPath:@"model_archiver_more.plist"];
    NSMutableData *muData = [NSMutableData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:muData];
    ArchiverModel *model= [unarchiver decodeObjectForKey:@"model_encode"];
    ArchiverModel *model1= [unarchiver decodeObjectForKey:@"model1_encode"];

    [unarchiver finishDecoding];
    BPLog(@"%@,%ld",model.name,model.age);
    BPLog(@"%@,%ld",model1.name,model1.age);

}


#pragma mark - 归档单个自定义对象
- (void)setModel_archiver
{
    
    //方法1.
    ArchiverModel *model = [[ArchiverModel alloc]initWithName:@"aaa" Age:12];
    NSString *path = [[DataManager shareDataManager]  getPath:@"model_archiver_one.plist"];
    //使用archiveRootObject:toFile:方法可以将一个对象直接写入到一个文件中
    BOOL archiver = [NSKeyedArchiver archiveRootObject:model toFile:path];
    
    
    //方法2.
    NSString *path1 = [[DataManager shareDataManager]  getPath:@"model_archiver_one_2.plist"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [data writeToFile:path1 atomically:YES];
    
    //读取
    if (archiver) {
        [self getModel_archiver];
    }
}

- (void)getModel_archiver
{
    //方法1读取.
    NSString *path = [[DataManager shareDataManager]  getPath:@"model_archiver_one.plist"];
    ArchiverModel *model =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    BPLog(@"%@,%ld",model.name,model.age);
    
    //方法2读取.
    NSString *path1 = [[DataManager shareDataManager]  getPath:@"model_archiver_one_2.plist"];
    NSData *data = [NSData dataWithContentsOfFile:path1];
    ArchiverModel *model1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    BPLog(@"%@,%ld",model1.name,model1.age);
}



#pragma mark - NSString_plist
- (void)setNSString_plist
{
    NSString *str = @"NSString_path";
    NSString *path = [[DataManager shareDataManager]  getPath:@"str.plist"];
    
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    [self getNSString_plist];

    
}

- (void)getNSString_plist
{
    NSString *path = [[DataManager shareDataManager]  getPath:@"str.plist"];

    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    BPLog(@"%@",str);
}


#pragma mark - NSArray_plist
- (void)setNSArray_plist
{
    NSArray *array = @[@"plist_a",@"plist_b",@"plist_c"];
    NSString *path = [[DataManager shareDataManager]  getPath:@"array_plist.plist"];
    [array writeToFile:path atomically:YES];
    [self getNSArray_plist];
}


- (void)getNSArray_plist
{
    NSString *path = [[DataManager shareDataManager]  getPath:@"array_plist.plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    BPLog(@"%@",array);
}

#pragma mark - NSString_plist
- (void)setDic_plist
{
    NSDictionary *dic = @{@"a":@"A",
                          @"b":@"B",
                          @"c":@"C",
                          };
//    NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:dic];
    

    

    NSString *path = [[DataManager shareDataManager]  getPath:@"dic.plist"];
    
    [dic writeToFile:path atomically:YES];
    
    [self getDic_plist];
    
    
}


- (void)getDic_plist
{
    NSString *path = [[DataManager shareDataManager]  getPath:@"dic.plist"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    BPLog(@"%@",dic);
    [dic setObject:@"d" forKey:@"a"];
    BPLog(@"%@",dic);
    
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    BPLog(@"%@",dic1);


    
    
    
}

#pragma mark - 归档一个Array
- (void)setNSArray
{
    NSArray *array = @[@"archiver_a",@"archiver_b",@"archiver_C"];
    NSString *path = [[DataManager shareDataManager] getPath:@"array_archiver.plist"];
    BOOL archiver = [NSKeyedArchiver archiveRootObject:array toFile:path];
    if (archiver) {
        [self getNSArray_archiver];
    }
}
- (void)getNSArray_archiver
{
    NSString *path = [[DataManager shareDataManager]  getPath:@"array_archiver.plist"];
    NSArray *array =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    BPLog(@"%@",array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
