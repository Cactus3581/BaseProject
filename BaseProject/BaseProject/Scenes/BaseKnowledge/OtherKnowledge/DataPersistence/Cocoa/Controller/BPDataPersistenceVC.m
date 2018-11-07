//
//  BPDataPersistenceVC.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/16.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPDataPersistenceVC.h"
#import "BPArchiverModel.h"
#import "BPArchiverSubModel.h"
#import "BPDataManager.h"

/*
 沙盒：其实对于每一个应用程序，都有唯一的一个本地文件与之对应，名字由系统随机生成。这个文件就是沙盒。
 沙盒机制：  沙盒机制其实就是，对每一个应用程序的资源起到一个保护作用，当前程序不允许访问其他程序的资源。其他程序也不允许访问当前程序的资源。
 
 对于每一个应用程序的沙盒文件中 都包含以下文件：
 1.documents：用来存储持久化数据文件，如果我们想对一个文件进行长久存储，就放在该文件夹下。
 2.Libary：
 （1）Caches：缓存文件，存放已经下载完成的视频，音频，图片等等，一般我们会在该文件下创建。 Images，Audioes，Videoes等文件分别存放图片，视频，音频。
 （2）Prefrences：用于存储用户的偏好设置，比如:用于判别程序是否是第一次启动的plist文件,就放在该文件夹下.
 (3)tmp：存放未下载完成的视频 音频等 , 一般我们会将下载完成的视频,音频再手动移动到Caches中.
 
 XXX.app : 应用程序的包,应用程序的资源都来源于包,而包也是我们上传到AppStore以及用户从AppStore下载的文件.对应包内的文件 ,一般我们不能进行修改,不能删除.
 另外,对于以上文件.都是由系统创建,不允许随意删除,修改.我们只能删除和修改自己创建的文件..
 
 */

@interface BPDataPersistenceVC ()

@end

@implementation BPDataPersistenceVC

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
    BPArchiverModel *model = [[BPArchiverModel alloc] initWithName:@"aaaa" Age:22];
    BPArchiverModel *model1 = [[BPArchiverModel alloc] initWithName:@"bbbb" Age:100];
    NSString *path = [[BPDataManager shareBPDataManager] getPath:@"model_archiver_more.plist"];
    //1.创建可变data:容器
    NSMutableData *muData = [NSMutableData data];
    //2.创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:muData];
    //3.归档
    [archiver encodeObject:model forKey:@"model_encode"];
    [archiver encodeObject:model1 forKey:@"model1_encode"];
    //4.归档完成
    [archiver finishEncoding];
    [muData writeToFile:path atomically:YES];
    [self getModel_more_arch];
}

- (void)getModel_more_arch {
    NSString *path = [[BPDataManager shareBPDataManager] getPath:@"model_archiver_more.plist"];
    NSMutableData *muData = [NSMutableData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:muData];
    BPArchiverModel *model= [unarchiver decodeObjectForKey:@"model_encode"];
    BPArchiverModel *model1= [unarchiver decodeObjectForKey:@"model1_encode"];
    [unarchiver finishDecoding];
    BPLog(@"%@,%ld",model.name,model.age);
    BPLog(@"%@,%ld",model1.name,model1.age);
}

#pragma mark - 归档单个自定义对象
- (void)setModel_archiver {
    //方法1.
    BPArchiverModel *model = [[BPArchiverModel alloc]initWithName:@"aaa" Age:12];
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"model_archiver_one.plist"];
    //使用archiveRootObject:toFile:方法可以将一个对象直接写入到一个文件中
    BOOL archiver = [NSKeyedArchiver archiveRootObject:model toFile:path];
    
    //方法2.
    NSString *path1 = [[BPDataManager shareBPDataManager]  getPath:@"model_archiver_one_2.plist"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [data writeToFile:path1 atomically:YES];
    
    //读取
    if (archiver) {
        [self getModel_archiver];
    }
}

- (void)getModel_archiver {
    //方法1读取.
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"model_archiver_one.plist"];
    BPArchiverModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    BPLog(@"%@,%ld",model.name,model.age);
    
    //方法2读取.
    NSString *path1 = [[BPDataManager shareBPDataManager]  getPath:@"model_archiver_one_2.plist"];
    NSData *data = [NSData dataWithContentsOfFile:path1];
    BPArchiverModel *model1 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    BPLog(@"%@,%ld",model1.name,model1.age);
}

#pragma mark - NSString_plist
- (void)setNSString_plist {
    NSString *str = @"NSString_path";
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"str.plist"];
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [self getNSString_plist];
}

- (void)getNSString_plist {
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"str.plist"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    BPLog(@"%@",str);
}

#pragma mark - NSArray_plist
- (void)setNSArray_plist {
    NSArray *array = @[@"plist_a",@"plist_b",@"plist_c"];
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"array_plist.plist"];
    [array writeToFile:path atomically:YES];
    [self getNSArray_plist];
}

- (void)getNSArray_plist {
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"array_plist.plist"];
    //解析文件就好
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    BPLog(@"%@",array);
}

#pragma mark - NSString_plist
- (void)setDic_plist {
    NSDictionary *dic = @{@"a":@"A",
                          @"b":@"B",
                          @"c":@"C",
                          };
//    NSMutableDictionary *mudic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"dic.plist"];
    [dic writeToFile:path atomically:YES];
    [self getDic_plist];
}

- (void)getDic_plist {
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"dic.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    BPLog(@"%@",dic);
    [dic setObject:@"d" forKey:@"a"];
    BPLog(@"%@",dic);
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    BPLog(@"%@",dic1);
}

#pragma mark - 归档一个Array
- (void)setNSArray {
    NSArray *array = @[@"archiver_a",@"archiver_b",@"archiver_C"];
    NSString *path = [[BPDataManager shareBPDataManager] getPath:@"array_archiver.plist"];
    BOOL archiver = [NSKeyedArchiver archiveRootObject:array toFile:path];
    if (archiver) {
        [self getNSArray_archiver];
    }
}

- (void)getNSArray_archiver {
    NSString *path = [[BPDataManager shareBPDataManager]  getPath:@"array_archiver.plist"];
    NSArray *array =[NSKeyedUnarchiver unarchiveObjectWithFile:path];
    BPLog(@"%@",array);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
