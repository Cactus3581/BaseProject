//
//  BPStaticConstViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/3/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPStaticConstViewController.h"
@interface BPStaticConstViewController ()

@end


// 一般全局变量
NSString *str = @"str";//仅限本文件使用，字符串能被修改

// 关于static
static NSString *static_str1 = @"static_str1"; //仅限本文件使用，字符串能被修改
//NSString *static static_str2 = @"static_str2"; //语法报错


// 关于本文件中的const
const NSString *local_constStr1 = @"local_constStr1"; //可以修改
NSString * const local_constStr2 = @"local_constStr2"; // 不可以被修改

// 关于static与const结合
static const NSString *static_Const_str1 = @"static_Const_str1";//仅限本文件使用，字符串能被修改
static  NSString * const static_Const_str2 = @"static_Const_str2";//字符串不能被修改

@implementation BPStaticConstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    
//    [self testStatic];
//    [self testConst];
    [self testStatic_const];
    
    
/*
 用法总结：
 1. 在函数外，直接定义对象，不需要额外添加修饰符，对象可被修改； 一般形式的全局变量
 2. 只用static修饰，对象可以被修改，但是生命周期在APP运行期； 用static修饰就是静态变量（也叫全局静态变量），不用static修饰的就是全局非静态变量；
 修饰局部变量：让局部变量只初始化一次；局部变量在程序中只有一份内存；并不会改变局部变量的作用域，仅仅是改变了局部变量的生命周期（只到程序结束，这个局部变量才会销毁）
 修饰全局变量：全局变量的作用域仅限于当前文件
 
 3. 用const修饰：一般不定义在本文件内，字符串可以被修改，也可以不被修改（主要）；用const修饰的就是常量；全局非静态／静态常量
 4. 用static，const一起修饰：全局静态常量，在本文件内字符串可以被修改，也可以不被修改（主要）；

 
 常用的三种：
 1. static 修饰全局静态变量，比如cell的标识符
 2. static+const在本文件内使用，修饰不可变字符串，全局静态常量
 3. const在单独一个文件内使用，修饰字符串，变成不可变的常量。
 */
}

- (void)testStatic
{
    str = @"sd";
//    BPLog(@"%@",str);
    
    static_str1 = @"static_str1_change";
    
    BPLog(@"%@",static_str1);

    
    [self keepTest_static];
}

- (void)keepTest_static
{
//    BPLog(@"%@",str);
//    BPLog(@"%@",static_str1);

}


- (void)testConst
{
//    //test1:
//    local_constStr1 = @"local_constStr1_change";
//    BPLog(@"%@", local_constStr1); //
//
////    local_constStr2 = @"local_constStr2_change";//报错：不能修改
//
//    //test2:
//    extern NSString * testStr1;
//    testStr1 = @"const_test1_change";
//    BPLog(@"%@", testStr1); //
//
//    [self keepTest_const];
    
    
    //2. 报错：不能修改
//    extern NSString * const testStr2;
//    testStr2 = @"const_test2_change";
//    BPLog(@"%@", testStr2); //
}

- (void)keepTest_const
{
//    BPLog(@"%@", local_constStr1); //

    extern NSString * testStr1;
//    BPLog(@"%@", testStr1); //

}

- (void)testStatic_const
{
    static_Const_str1 = @"static_Const_str1_change";//被改变;
//    static_Const_str2 = @"static_Const_str2_change"; //报错

    BPLog(@"%@",static_Const_str1);
    

//    //test2:
//    extern NSString * testStr1;
//    testStr1 = @"const_test1_change";
//    BPLog(@"%@", testStr1); //
//    
//    //test2:报错
//    extern NSString * testStr2;
//    testStr1 = @"const_test1_change";

    
    
    
    [self keepTest_static_const];
}

- (void)keepTest_static_const
{
//    BPLog(@"%@",static_Const_str1);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
