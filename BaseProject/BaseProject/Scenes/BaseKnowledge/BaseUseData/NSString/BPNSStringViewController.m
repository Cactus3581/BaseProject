//
//  BPNSStringViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNSStringViewController.h"

@interface BPNSStringViewController ()

@end

@implementation BPNSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self string_type];
}

#pragma mark - 编译优化：不同类型的字符串
- (void)string_type {
    //测试代码
    NSString *a = @"string";//__NSCFConstantString
    NSString *b = [[NSString alloc] init];//__NSCFConstantString
    NSString *c = [[NSString alloc] initWithString:@"string"];//__NSCFConstantString
    NSString *d = [[NSString alloc] initWithFormat:@"string"];//NSTaggedPointerString
    NSString *e = [NSString stringWithFormat:@"string"];//NSTaggedPointerString
    NSString *f = [NSString stringWithFormat:@"123456789"];//NSTaggedPointerString
    NSString *g = [NSString stringWithFormat:@"1234567890"];//__NSCFString
    
    BPDLog(a); BPDLog(b); BPDLog(c); BPDLog(d); BPDLog(e); BPDLog(f); BPDLog(g);
}

- (void)handle {
#pragma mark － NSString
    /*
     // 创建字符串对象 6种
     
     // initWithString:相当于直接赋值常量字符串对象
     NSString *str1 = @"张三";
     
     // stringWithString :相当于直接赋值
     NSString *str2 =  @"张三";
     
     
     //initWithFormat:通过传入的格式化字符串进行字符串对象的创建
     NSString *str3 = [[NSString alloc]initWithFormat:@"普通字符串 %@ %d %f",@"iphone",6,6088.00];
     BPLog(@"%@",str3);
     
     //stringWithFormat :其实内部封装了 alloc 以及 initWithFormat
     NSString *str4 = [NSString stringWithFormat:@"通过便利构造器创建字符串"];
     BPLog(@"%@",str4);
     
     
     //initWithUTF8String:将c语言的字符串 转化为oc字符串对象
     NSString *str5 = [[NSString alloc]initWithUTF8String:"我是一个c语言字符串"];
     BPLog(@"%@",str5);
     
     //stringWithUTF8String:通过便利构造器方法将c语言字符串 转化为oc字符串对象
     NSString *str6 = [NSString stringWithUTF8String:"通过便利构造器方法将c语言字符串 转化为oc字符串对象"];
     */
    /*
     //创建一个字符串对象
     
     NSString *str = [NSString stringWithFormat:@"hello world"];
     BPLog(@"%@",str);
     
     //1.替换  将所有符号条件的字符串都进行替换
     NSString *replaceStr = [str stringByReplacingOccurrencesOfString:@"o" withString:@"hanyan"];
     BPLog(@"%@",replaceStr);
     
     //2.拼接
     NSString *appendStr = [str stringByAppendingString:@".cn"];
     BPLog(@"%@",appendStr);
     
     //3.比较长度
     NSUInteger length = [str length];
     BPLog(@"length = %lu",length);
     
     //4.大小写转换
     NSString *upperStr = [str uppercaseString];
     BPLog(@"%@",upperStr);
     //小写
     NSString *lowerStr = [upperStr lowercaseString];
     BPLog(@"%@",lowerStr);
     
     //首字母大写
     NSString *capital = [str capitalizedString];
     BPLog(@"%@",capital);
     
     //5.判断开头 结尾  用途：一般用来判断字符串格式
     BOOL isPerFix = [str hasPrefix:@"ttp"];
     BPLog(@"%d",isPerFix);
     
     BOOL isSuFix = [str hasSuffix:@".com"];
     BPLog(@"%d",isSuFix);
     
     6.字符串截取
     
     substringFromIndex:  从给定位置开始截取到字符串结尾（包括当前位置）
     substringToIndex:   从开头截取到自定位置（不包括当前位置）
     substringWithRange: 通过给定范围进行字符串截取
     
     系统给我们提供了快速创建结构体的方式 NSMake + 结构体名（例如 NSRange NSMakeRange（1,10）;）
     
     NSString *subStr1 = [str substringFromIndex:3];
     BPLog(@"%@",subStr1);
     
     NSString *subStr2 = [str substringToIndex:3];
     BPLog(@"%@",subStr2);
     
     NSString *subStr3 = [str substringWithRange:NSMakeRange(11, 7)];
     BPLog(@"%@",subStr3);
     
     
     //判断相等
     NSString *str2 = [NSString stringWithFormat:@"aa"];
     NSString *str3 = [NSString stringWithFormat:@"aa"];
     BOOL isEqual = [str2 isEqualToString:str3];
     BPLog(@"%d",isEqual);
     
     //比较
     NSInteger result = [str2 compare:str3];
     BPLog(@"result = %ld",result);
     
     #pragma mark NSMutableString 可变字符串 是NSString的子类，增添了NSString 可变的功能
     NSMutableString *str4 = [[NSMutableString alloc]initWithFormat: @"I love M"];
     //增
     //拼接 在字符串末尾拼接
     [str4 appendFormat:@" really"];
     BPLog(@"%@",str4);
     
     //插入 在第二个字节开始插入 插入内容为 @"and mary
     [str4 insertString:@"and mary " atIndex:2];
     BPLog(@"%@",str4);
     
     //删除 从第0个开始 删除6个字节
     [str4 deleteCharactersInRange:NSMakeRange(0, 6)];
     BPLog(@"%@",str4);
     
     //替换   从第0个开始 替换4个字节 替换内容为amy
     [str4 replaceCharactersInRange:NSMakeRange(0, 4) withString:@"amy"];
     BPLog(@"%@",str4);
     
     //改 setString
     [str4 setString:@"以上内容全被我换了！"];
     BPLog(@"%@",str4);
     
     */
    //        NSMutableString *name = [[NSMutableString alloc]initWithFormat:@"sdsd"];
    NSString *picName = @"sdsds.png";
    if ([picName hasSuffix:@"png"]) {
        NSString *newName = [picName stringByReplacingOccurrencesOfString:@"png" withString:@"jpg"];
        BPLog(@"%@",newName);
    }else{
        NSString *newName = [picName stringByAppendingFormat:@".jpg"];
        BPLog(@"%@",newName);
    }
    //rangeOfString： 查找所给字符串在原字符串中的范围 如果length》0，说明存在，如果length < 0，则不存在。
    NSString *str = @"aBcD_EfGk";
    NSRange range = [str rangeOfString:@"EfGk"];
    if (range.length>0) {
        //替换
        NSString *newStar = [str stringByReplacingOccurrencesOfString:@"EfGk" withString:@"WXYZ"];
        //转化小写
        NSString *lowerStr = [newStar lowercaseString];
        BPLog(@"%@",lowerStr);
    }
    BPLog(@"%ld,%ld",range.location,range.length);
}

#pragma mark - 字符串比较降序升序
- (void)string_compare {
    
    NSString *str = @"abcdef";
    NSString *str1 = @"wxyz";
    
    NSInteger result = [str compare:str1];
    if (result == NSOrderedSame) {
        BPLog(@"same");
    } else if (result == NSOrderedAscending) {
        BPLog(@"Ascend");
    } else if (result == NSOrderedDescending) {
        BPLog(@"Descend");
    }
    
    NSString *str2 = @"18";
    NSString *str3 = @"6";
    
    int result1 = [str2 compare:str3 options:NSNumericSearch];
    if (result1 == NSOrderedSame) {
        BPLog(@"same");
        
    } else if (result1 == NSOrderedAscending) {
        BPLog(@"Ascend");
        
    } else if (result1 == NSOrderedDescending) {
        BPLog(@"Descend");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
