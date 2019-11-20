//
//  BPKeyWordViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/3/17.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPKeyWordViewController.h"
#import "BPKeyWordModel.h"

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


void testFunc1 () {
    BPLog(@" == 1.1 ==");
}

static void testStaticFunc1() {
    BPLog(@" == 2.1 ==");
}
    
static inline void testStaticinLineFunc1() {
    BPLog(@" == 3.1 ==");
}


@interface BPKeyWordViewController ()

@end


@implementation BPKeyWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            case 0:{
                [self testStatic];
            }
                break;
                
            case 1:{
                [self testInstancetype];
            }
                break;
                
            case 2:{
                [self testPoint];
            }
                break;
                
            case 3:{
                [self testBridge];
            }
                break;
            
            case 4:{
                [self testNull];
            }
                break;
        }
    }
}

#pragma mark - static、const

- (void)testStatic {
    BPLog(@"%@,%@,%@,%@,%@,%@",str,static_str1,const_Str1,const_Str2,static_const_str1,static_const_str2);
    [self test];
    BPLog(@"%@,%@,%@,%@,%@,%@",str,static_str1,const_Str1,const_Str2,static_const_str1,static_const_str2);
    
    testFunc1();
    testStaticFunc1();
    testStaticinLineFunc1();
}

- (void)test {
    str = @"1";
    static_str1 = @"2";
    const_Str1 = @"3";
    //const_Str2 = @"4"; // 报错
    //static_const_str1 = @"5"; // 报错
    static_const_str2 = @"6";
    BPLog(@"%@,%@,%@,%@,%@,%@",str,static_str1,const_Str1,const_Str2,static_const_str1,static_const_str2);
}

#pragma mark - id、instancetype

- (void)testInstancetype {
    id model1 = [[BPKeyWordModel alloc] initModel1];
    id model2 = [[BPKeyWordModel alloc] initModel2];

    [model1 test];
    [model2 test];

//    [model1 test1];
//    [model2 test1];
}

#pragma mark - id、NSObject *、void *

- (void)testPoint {
//    id str1 = @"";
//    NSObject *str2 = @"";
//    void *str3 =  @"";
    
//    [str1 test];
//    [str2 test];
//    [str3 test];
}

#pragma mark - 桥接
- (void)testBridge {
    //CFString -> NSString
    CFStringRef cfStr = CFStringCreateWithCString(kCFAllocatorDefault, "veryitman", kCFStringEncodingUnicode);
        
    // 方法1: 需要释放
    NSString *string = (__bridge NSString *)cfStr;
    CFRelease(cfStr);
        
    // 方法2: 不需要释放, __bridge_transfer 自带 release
    string = (__bridge_transfer NSString *)cfStr;
    
    //NSString -> CFString
    NSString *string1 = @"veryitman.com";
    // 方法1: 不需要释放
    CFStringRef cfStr1 = (__bridge CFStringRef)string1;
        
    // 方法2: 需要释放, 这里 retain 了
    CFStringRef cfStr2 = (__bridge_retained CFStringRef)string1;
    CFRelease(cfStr2);
}

#pragma mark - nil、Nil、NSNULL、NULL
- (void)testNull {
    
    NSString *str = nil;
    BPLog(@"str = %@",str); // 打印出来是 (null)
    
    NSString *str1 = [NSNull null];//
    BPLog(@"str1 = %@",str1); // 打印出来是 <null>，<null>一般出现在后台接口返回空值的时候，-[NSNull length]: unrecognized selector sent to instance

    NSArray *array = [NSArray arrayWithObjects:@"1", str1, @"3", nil];

    Class class = Nil;
    int *pointerInt = NULL;
}

@end
