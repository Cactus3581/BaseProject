//
//  BPKeyWordViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/3/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPKeyWordViewController.h"
#import "BPKeyWordModel.h"

@interface BPKeyWordViewController ()

@end

//定义了一个对象类型为 NSString *，变量名为str，初值为@"str"的指针变量
// 一般形式的全局变量，仅限本文件使用，指针可以重指向
 NSString *str = @"str";

// static：修饰全局/局部静态变量，限本文件使用，指针可以通过修改重指向其他地址
static NSString *static_str1 = @"static_str1";
//NSString *static static_str2 = @"static_str2"; // 语法报错

// const：全局非静态（只读）常量

// const修饰的是指针变量指向的内存空间，所以指针可以重指向，但是指针所指向的地址中的内容不能更改
const NSString *const_Str1 = @"const_Str1";
// const修饰的是指针变量，所以指针不能重指向，但是指针所指向的地址中的内容可以更改
NSString *const const_Str2 = @"const_Str2";

// static与const结合使用，利用的是static限定本文件作用域 和 const的指针不能重指向的特性
static  NSString *const static_const_str1 = @"static_const_str1";//当修改指针时报错
static const NSString *static_const_str2 = @"static_const_str2";//一般不这样用


@implementation BPKeyWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BPLog(@"%@,%@,%@,%@,%@,%@",str,static_str1,const_Str1,const_Str2,static_const_str1,static_const_str2);
    [self test1];
    BPLog(@"%@,%@,%@,%@,%@,%@",str,static_str1,const_Str1,const_Str2,static_const_str1,static_const_str2);
}

- (void)test1 {
    str = @"1";
    static_str1 = @"2";
    const_Str1 = @"3";
    //const_Str2 = @"4"; // 报错
    //static_const_str1 = @"5"; // 报错
    static_const_str2 = @"6";
    BPLog(@"%@,%@,%@,%@,%@,%@",str,static_str1,const_Str1,const_Str2,static_const_str1,static_const_str2);
}

- (void)test2 {
    id model1 = [[BPKeyWordModel alloc] initModel1];
     id model2 = [[BPKeyWordModel alloc] initModel2];
    [model1 test1];
    [model2 test1];
}

@end
