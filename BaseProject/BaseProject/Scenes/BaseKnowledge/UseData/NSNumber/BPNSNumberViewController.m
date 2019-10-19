//
//  BPNSNumberViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSNumberViewController.h"

@interface BPNSNumberViewController ()

@end

@implementation BPNSNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//JSON传数字：
- (void)test1 {
    NSString *json = @"{\"a\":66.6, \"b\":66.66, \"c\":66.666, \"d\":66.6666}";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"%@", dict);
    for (NSString *key in [dict allKeys]) {
        id object = [dict objectForKey:key];
        NSLog(@"%@: %@ - %@", key, [object class], object);
        
        float xf = [object floatValue];
        double yf = [object doubleValue];
        printf("nf: %f - df: %f\n", xf, yf);
    }
}

// JSON传字符串类型的数字：

- (void)test2 {
    NSString *json = @"{\"a\":\"66.6\",\"b\":\"66.66\",\"c\":\"66.666\",\"d\":\"66.6666\"}";
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSLog(@"dict: %@", dict);
    for (NSString *key in [dict allKeys]) {
        id object = [dict objectForKey:key];
        NSLog(@"%@: %@ - %@", key, [object class], object);
        
        float xf = [object floatValue];
        double yf = [object doubleValue];
        printf("nf: %f - df: %f\n", xf, yf);
    }
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
