//
//  BPNSSetViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSSetViewController.h"

@interface BPNSSetViewController ()

@end

@implementation BPNSSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)handle {
#pragma mark - NSSet   打印出来是大小括号形式
    NSNumber *num1 = @1; // [NSNumber numberWithInt:1]
    NSNumber *num2 = @3;
    NSNumber *num3 = @9;
    NSNumber *num4 = @2;
    
    //initWithObjects:在初始化时，一次性存入多个对象，对象和对象之间使用逗号隔开，以nil结尾。重复对象不进行存储。
    
    NSSet *aSet = [[NSSet alloc]initWithObjects:num1,num2,num3,num4,nil];
    BPLog(@"%@",aSet);
    
    //获取元素个数
    NSInteger count = [aSet count];
    BPLog(@"%ld",count);
    
    //获取所有集合元素
    NSArray *allObjects = [aSet allObjects];
    BPLog(@"%@",allObjects);
    
    //获取任意集合元素
    NSNumber *anyNum = [aSet anyObject];
    BPLog(@"%@",anyNum);
    
    //快速枚举
    for (NSNumber *num in aSet) {
        BPLog(@"%@",num);
    }
    
    //判断集合是否包含 指定对象
    BOOL iscontain = [aSet containsObject:@1];
    BPLog(@"%d",iscontain);
    
#pragma mark - NSMutableSet   可变set
    
    NSMutableSet *muSet = [[NSMutableSet alloc]initWithObjects:@"zhangsan",@"lisi",@"wangwu", nil];
    BPLog(@"%@",muSet);
    
    //增加一个对象
    [muSet addObject:@"zhaoda"];
    BPLog(@"%@",muSet);
    
    //改  也就是替换
    NSSet *set = [NSSet setWithObjects:@"zhangsan",@"lisi",@"wangwu",@"zhaoliu", nil];
    
    [muSet setSet:set];  //没指定怎么知道替换谁
    BPLog(@"%@",muSet);
    
    // 删除某个对象
    [muSet removeObject:@"zhaoliu"];
    BPLog(@"%@",muSet);
    
    // 全部删除
    [muSet removeAllObjects];
    BPLog(@"%@",muSet);
    
    
#pragma mark -  NSCountedSet
    // 子类是父类的一种扩充
    NSCountedSet *countedSet = [NSCountedSet setWithObjects:@"zhangSan",@"Zhangsan",@"zhangSan",@"lisi", nil];
    BPLog(@"%@",countedSet);
    
    // 查看集合元素重复出现次数
    NSInteger repeaCount = [countedSet countForObject:@"zhangSan"];
    BPLog(@"%ld",repeaCount);
    //
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
