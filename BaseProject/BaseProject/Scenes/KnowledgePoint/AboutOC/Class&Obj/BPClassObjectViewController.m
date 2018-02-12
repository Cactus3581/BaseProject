//
//  BPClassObjectViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPClassObjectViewController.h"
#import "BPPerson.h"
#import "BPMan.h"

/*
 类：具有相同特征和行为实物的抽象，是对象的类型。
 对象：具体的事物，是类的实例。
 
 Extension 延展，为有源代码的类 添加私有的实例变量和私有的方法
 @interface＋ 类名（当前类名）＋（）＋@end 进行私有实例变量 和私有方法的声明
 
  category 类目，分类。为没有源代码的类添加方法，一旦添加成功，就相当于原来类具有方法。
  category 包括两个部分
  1.@interface + 类名 （为哪一个类添加分类）＋（分类名）＋@end。进行方法的声明
  2.@implementation +类名（为哪一个类添加分类）＋（分类名）＋@end，进行方法的实现。
 */
@interface BPClassObjectViewController ()

@end

@implementation BPClassObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendMessage];
}

- (void)sendMessage {
    //创建对象
    BPPerson *p1 = [[BPPerson alloc] init];
    NSLog(@"对象地址:%p",p1);
    //调用  打招呼。
    //中括号[receiver message];消息发送机制（消息语法）
    [p1 sayHi];
    
    //操作访问实例变量
    p1->_weight = 333333333;
    [p1 sayHi];
    
    

    BPMan *man = [[BPMan alloc] init];
    [man sayHi];
    
    //三种方法
    [p1 setName:@"李四"];
    p1.weight = 12;
    [p1 setValue:@66 forKey:@"weight"];
    [p1 setValue:@66 forKey:@"_weight"];

}

#pragma mark - 字面量 语法糖 笑笑语法  弊端：不可变
- (void)dsds {
    //NSString;
    NSString *str = @"糖";
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",str1 ];
    //NSArray
    NSArray *arr = @[@"1",@"2",@"3"];
    //等价于
    [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSMutableArray *muArr = [NSMutableArray arrayWithObjects:arr, nil];
    [arr objectAtIndex:1];
    //等价于
    arr[1];
    //   NSDictionary
    NSDictionary *dic = @{@"name": @"笑笑语法",@"name1":@"语法糖",@"name3":@"字面量"};
    NSLog(@"%@",dic);
    NSLog(@"%@",dic[@"name3"]);
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dic ];
    NSLog(@"%@",muDic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
