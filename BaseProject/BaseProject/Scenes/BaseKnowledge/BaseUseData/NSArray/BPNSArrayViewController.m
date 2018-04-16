//
//  BPNSArrayViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSArrayViewController.h"
#import "BPPerson.h"

@interface BPNSArrayViewController ()

@end

@implementation BPNSArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)handle {
#pragma mark - NSArray
    NSString *Nokia = @"Nokia";
    NSString *apple = @"Apple";
    NSString *mi = @"MI";
    /*
     nsarray 他是一个类
     里面主要是对象就行
     
     三大集合 数组 集合
     */
    //initWithObjects: 在初始化时 一次性存储多个对象  对象和对象之间用“,”隔开
    //以nil结尾  nil之后的对象不再存储
    
    NSArray  *array = [[NSArray alloc]initWithObjects:Nokia ,apple,mi, nil];// 不可变数组，不允许修改，只能取
    BPLog(@"%@",array);
    NSArray *a = [NSArray arrayWithObjects:@"23232",@"dsd",@23,@"si 家", nil];
    BPLog(@"%@===========",a);
    //数组元素个数
    NSInteger count = [array count];
    BPLog(@"count = %ld",count);
    
    //访问数组元素
    NSString *ne= [array objectAtIndex:0];  // 只能取的方法
    BPLog(@"%@,%@",ne,array[0]);
    BPLog(@"%@",array[1]);
    
    //通过对象找到索引值
    //indexOfObject:只是找到第一个满足条件的对象下标 后面的如果有一样的就找不到了
    NSInteger index = [array indexOfObject:Nokia];
    BPLog(@"%ld",index);
    
    //遍历数组
    for (int i = 0; i<array.count; i++) {
        BPLog(@"%@",[array objectAtIndex:i]);
    }
    
    //排序
    NSArray *sortArray = [array sortedArrayUsingSelector:@selector(compare:)];
    BPLog(@"%@",sortArray);
    
#pragma mark - NSMutableArray 可变数组
    
    NSString *xiaoyi  = [NSString stringWithFormat:@"xiaoyi"];
    NSString *xiaoyer = [NSString stringWithFormat:@"xiaoer"];
    NSString *xiaosan = [NSString stringWithFormat:@"xiaosan"];
    NSString *xiaosi  = [NSString stringWithFormat:@"xiaosi"];
    NSString *xiaowu  = [NSString stringWithFormat:@"xiaowu"];
    NSString *xiaoliu = [NSString stringWithFormat:@"xiaoliu"];
    NSString *xiaoqi  = [NSString stringWithFormat:@"xiaqi"];
    
    NSMutableArray *muArr = [[NSMutableArray alloc]initWithObjects :xiaoyi,xiaoyer,xiaosan,xiaosi,xiaowu,nil];
    
    //打印数组
    BPLog(@"%@",muArr);
    
    //循环便利打印
    for (int i =0 ; i<5; i++) {
        BPLog(@"%@",[muArr objectAtIndex:i]);
    }
    
    
    //增加
    [muArr addObject:xiaoliu];
    [muArr addObject:xiaoqi];
    BPLog(@"%@",muArr);
    
    //插入
    [muArr insertObject:xiaoqi atIndex:0];
    BPLog(@"%@",muArr);
    
    //通过下标交换位置
    [muArr exchangeObjectAtIndex:0 withObjectAtIndex:6];
    BPLog(@"%@",muArr);
    
    
    
    //删除  /  移除
    
    //会将所有符合条件的对象全部移除
    [muArr removeObject:xiaoqi];
    BPLog(@"%@",muArr);
    
    //removeObjectAtIndex:7只会将对应下标的对象移除
    [muArr removeObjectAtIndex:0];
    BPLog(@"%@",muArr);
    
    //removeAllObjects 移除所有的对象。
    [muArr removeAllObjects];
    BPLog(@"%@",muArr);

    

#pragma mark - 数组排序
    
    //冒泡排序
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1",@"8",@"3",@"4", nil];
    //        for (int i = 0; i<arr.count-1; i++) {
    //            for (int j = 0; j<arr.count-1-i; j++) {
    //                if ([arr[j] compare:arr[j+1]] >0) {
    //                    [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
    //                }
    //            }
    //        }
    //
    //
    
    //等同于上面！
    //可改变的数组   数组方法
    [arr sortUsingSelector :@selector(compare:)];
    BPLog(@"%@",arr);
    
    //不可改变数组   数组排序方法
    NSArray *arr1 = @[@"1",@"8",@"3",@"4"];
    NSArray *sortedArr = [arr1 sortedArrayUsingSelector:@selector(compare:)]; //compare是字符串方法。
    BPLog(@"%@",sortedArr);
    
    //对于年龄排序
    BPPerson *stu1 = [BPPerson personWithName:@"zhaoda" weight:13];
    BPPerson *stu2 = [BPPerson personWithName:@"suner" weight:14];
    BPPerson *stu3 = [BPPerson personWithName:@"zhangsan" weight:17];
    BPPerson *stu4 = [BPPerson personWithName:@"lisi" weight:11];
    BPPerson *stu5 = [BPPerson personWithName:@"wangwu" weight:15];
    NSArray *arr2 = @[stu1,stu2,stu3,stu4,stu5];
    NSMutableArray *stus = [[NSMutableArray alloc]init];
    for (int i = 0; i<5; i++) {
        BPPerson * stu = [BPPerson personWithName:[NSString stringWithFormat:@"zhangsan%d号",i] weight:arc4random()%110];
        //放入数组
        [stus addObject:stu];
    }
    BPLog(@"%@",stus);
    [stus sortUsingSelector:@selector(compareByAge:)];
    BPLog(@"%@",stus);
    
    //按照姓名升序
    [stus sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //转化
        BPPerson *stu1 = (BPPerson *)obj1;
        BPPerson *stu2 = (BPPerson *)obj2;
        return [stu1.name compare:stu2.name];
    }];
    BPLog(@"%@",stus);

    //按照姓名降序
    [stus sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        //转化
        BPPerson *stu1 = (BPPerson *)obj1;
        BPPerson *stu2 = (BPPerson *)obj2;
        return -[stu1.name compare:stu2.name];
    }];
    BPLog(@"%@",stus);

    NSComparisonResult(^paixu)(id obj1, id obj2) = ^NSComparisonResult(id obj1, id obj2)
    {
        BPPerson *stu1 = (BPPerson *)obj1;
        BPPerson *stu2 = (BPPerson *)obj2;
        if (stu1.name <stu2.name) {
            return NSOrderedAscending;
        }else if (stu1.name>stu2.name)
        {
            return NSOrderedDescending;
            
        }
        return NSOrderedSame;
    };
    [stus sortUsingComparator:paixu];
    //对于快速枚举 枚举数组 获取到每一个数组元素 ,枚举字典 获取到每一个key值，枚举集合 获取到每一个集合元素。
    //三大集合都可以使用快速枚举来遍历打印。但是也有弊端.在枚举过程中，不允许对集合中的元素进行增加或者减少
    for (NSString *str in arr) {
        BPLog(@"%@",str);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
