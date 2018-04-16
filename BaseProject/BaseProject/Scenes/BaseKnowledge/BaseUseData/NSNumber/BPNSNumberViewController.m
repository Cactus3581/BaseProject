//
//  BPNSNumberViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSNumberViewController.h"

@interface BPNSNumberViewController ()

@end

@implementation BPNSNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)handle {
#pragma mark - NSNumber 数值对象类
    
    // nsnumber nsvalue  中转站    基本数据类型  nsnumver 对象@
    //  结构体 nsvalue  对象
    //整型－>整型数值对象
    NSNumber *intNum = [NSNumber numberWithInt:10];
    BPLog(@"%@",intNum);
    NSNumber *intNum1 = @10; // @10等价于便利构造器创建数值对象
    [NSNumber numberWithInt:10];
    BPLog(@"%@",intNum1);
    //浮点型－>
    NSNumber *floatNum = [NSNumber numberWithFloat:5.2];
    BPLog(@"%@",floatNum);
    NSNumber *floatNum2 = @5.2;
    BPLog(@"%@",floatNum2);
    //字符型
    NSNumber *charNum = [NSNumber  numberWithChar:'A'];
    BPLog(@"%@",charNum);
    NSNumber *charNum1 = @'A';
    BPLog(@"%@",charNum1);
    
    //整型数值对象 ——> 整型
    int a = [intNum intValue];
    BPLog(@"%d",a);
    //        int e = [@4 intValue];
    //        BPLog(@"%d",4);  为什么不行
    
    float b = [floatNum floatValue];
    BPLog(@"%.2f",b);
    
    //字符型对象－> 字符
    char d = [@'f' charValue];
    BPLog(@"%c",d);
    //        char c = [charNum charValue];
    //        BPLog(@"%c",c);
    
#pragma mark -NSValue
    //结构体 ->对象
    NSValue *rangValue = [NSValue valueWithRange:NSMakeRange(10, 5)];
    BPLog(@"%@",rangValue);
    
    //结构体对象 ->结构体
    NSRange range = [rangValue rangeValue];
    BPLog(@"%ld %ld",range.location,range.length);
    
    //练习：将 1 2 5.0 'a' {3,2}放入数组中
    NSValue *a1 = [NSValue valueWithRange:NSMakeRange(3, 2)];
    NSArray *arr = [[NSArray alloc]initWithObjects:@1,@2,@5.1,@'a',a1, nil];
    BPLog(@"%@",arr);
    
    //字符串的强大。
    //通过NSString 进行 数值<->对象转化
    NSString *a2 = @"100";
    NSInteger a3 = [a2 integerValue];
    BPLog(@"%ld",a3);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
