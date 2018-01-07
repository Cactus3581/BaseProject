//
//  BPBlockViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/13.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPBlockViewController.h"

@interface BPBlockViewController ()
@property (nonatomic,strong) NSString *blockString;
@end

@implementation BPBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
//    [self setBlock];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setcycle];

}

//定义一个block，int类型的返回值，并且有两个参数。
- (void)setBlock
{
    
    //1.最基本的用法
    int (^operation)(int,int) = ^(int a,int b){
        return  a+b;
    };
    BPLog(@"%d",operation(3,5));
    
    
    //2.宏定义一个block
    typedef int (^MyBlock)(int, int);
    //利用宏定义来定义变量

    MyBlock operation_1;
    //定义一个block变量来实现两个参数相加
    operation_1 = ^(int a,int b){
        return a*b;
    };
    //调用block
    BPLog(@"%d",operation_1(3,5));
    
    
    //3.
    int a = 10;
//    给局部变量加上__block之后就可以改变b局部变量的值,将取变量此刻运行时的值
    __block int b = 2;
    
    __block NSString *str1 = @"c";

    __block NSString *str2 = @"d";

    
    //定义一个block
    void (^block)();
    
    block = ^{
//        默认情况下，block内部不能修改外面的局部变量
//        a  =  20;
//        给局部变量加上__block关键字，这个局部变量就可以在block内部修改
        b  =  25;
        str1 = @"a";
        str2 = @"b";

    };
    
    block();
    
    BPLog(@"%d,%d,%@,%@",a,b,str1,str2);
    
    
    
    
    
    //4.static修饰
    static int base = 100;
    MyBlock operation_2 = ^ int (int a,int b){
        return ++base;
    };
    
    BPLog(@"%d",operation_2(1,base));
    
    
}

//循环引用例子：比如控制器在使用一个Block，这个block又在使用控制器就会出现循环引用
- (void)setcycle
{
    //例子1.
        NSMutableArray *firstArray = [NSMutableArray array];
        NSMutableArray *secondArray = [NSMutableArray array];
        [firstArray addObject:secondArray];
        [secondArray addObject:firstArray];
    
    
    //例子2.
    //代码解释：定义一个和self相同数据类型的bself ，并赋值为self，在block中使用
    __weak typeof (self) weakSelf = self;
    
    /*
     注意： typeof 括号中的值和等于后面的值是相同的类型。
     __weak typeof(self.contentView) ws = self.contentView;
     */
    
    self.passValueBlock = ^(NSString *str){
        //循环引用1
        [self test];
        
        //解决方法:
        //[weakSelf test];
        
        //以下调用注释掉的代码同样会造成循环引用，因为不管是通过self.blockString还是_blockString，或是函数调用[self doSomething]，因为只要 block中用到了对象的属性或者函数，block就会持有该对象而不是该对象中的某个属性或者函数。
        //NSString *localString = self.blockString;//循环引用2
        //NSString *localString = _blockString;//循环引用3
        
        //解决方法
        //NSString *localString = weakSelf.blockString;

    };
    
    
    self.passValueBlock(@"s");
    //例子3.
    //宏定义一个block
    typedef void(^blockAct)();
    //利用宏定义来定义变量
    blockAct blockAct_1;
    //定义一个block变量来实现
    blockAct_1 = ^(){
        [self test];
    };
    //调用block
    blockAct_1();
}

- (void)test
{
    BPLog(@"BLOCK");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
