//
//  BPDesignPatternsBlockViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDesignPatternsBlockViewController.h"


#pragma mark - 函数声明
int max(int a,int b);

#pragma mark - 函数定义
int max(int a,int b) {
    return a>b?a:b;
}

//重定义
typedef int (*VALUE)(int,int);
typedef float (^BlockType)(float,float);

//全局变量
int b = 100;

@interface BPDesignPatternsBlockViewController ()

@end

@implementation BPDesignPatternsBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)handle {
#pragma mark - 函数指针
    //重定义
    //函数名字 ： typedef int (*)(参数类型);
    //定义了一个数据类型为void（＊）（），变量名为p_sayHi，初值为NULL的一个指针变量。
    int (*p_max)(int a,int b) = NULL;
    p_max = max; //将sayHi函数的地址赋值给sayHi，那么指针变量p_sayHi就指向了sayHi的函数。p_sayHi就可以当函数名来使用。
    NSLog(@"%d",p_max(2,3));
    
#pragma mark - block 匿名函数，就是没有名字的函数。语法快
    //block变量的定义，和block语法块的实现。
    // 在block中，有一个"^"起标识作用，block语法快，其实就是一个匿名函数 它相较其他函数可以进行函数 嵌套定义。
    //        void(^sayHiBlock)() = ^void ()
    //        {
    //            NSLog(@"sds");
    //        };//定义了一个数据类型为void（^)(),变量名为sayHiBlock,初值为^void(){NSLog(@"ds");}的一个block变量。
    //block的使用
    //        sayHiBlock;
     //求两个数之和
     int (^sumBlock)(int,int) = ^int(int a,int b){
     return a+b;
     };
     int sum =  sumBlock(5,6);
     NSLog(@"%d",sum);
     
     
     //求两个数之差
     int (^subBlock)(int,int) = ^int (int a,int b)
     {
     return a - b;
     };
     NSLog(@"%d",subBlock(11,1));
     
     int (^exchange)(NSString *b) = ^int(NSString *b)
     {
     
     return [b intValue];
     
     };
     NSLog(@"%d",exchange(@"12"));
     
     //加法
     BlockType sumBlock1 = ^float (float a,float b)
     {
     return a+b;
     };
     NSLog(@"%.2f",sumBlock1(5.0,4.0));
     
     //减法
     BlockType subBlock1 = ^float(float a,float b)
     {
     return a-b;
     };
     NSLog(@"%.2f",subBlock1(5.0,4.0));
     //cheng法
     BlockType subBlock2 = ^float(float a,float b)
     {
     return a*b;
     };
     NSLog(@"%.2f",subBlock2(5.0,4.0));
     //chu法
     BlockType subBlock3 = ^float(float a,float b)
     {
     return a/b;
     };
     NSLog(@"%.2f",subBlock3(5.0,4.0));
     
     #pragma mark - block 与 变量
     // __block 告诉编译器 将所修饰的变量在block仍然被识别为可以改变的量。
     __block int a  =10;
     int (^testBlock)() = ^int()
     {
     a = 15; //对于局部变量 在block被识别为不可改变的量，不可以改变，但是可以访问。需要在函数外加__.
     b++;//对于全局变量，在block内部 仍然识别为变量。
     NSLog(@"%d",a);
     return a;
     };
     testBlock();
     NSLog(@"%d",testBlock());
}

@end
