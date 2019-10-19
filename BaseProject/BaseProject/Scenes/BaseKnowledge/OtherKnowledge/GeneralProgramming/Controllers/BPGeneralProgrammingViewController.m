//
//  BPGeneralProgrammingViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/12/25.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPGeneralProgrammingViewController.h"
static NSString * const test1 = @"test1"; //const修饰的是test1这个指针变量，所以test1不可修改，也就是不能修改存储的地址，即不能指向其他对象
static NSString const *test2 = @"test2";  //const修饰的是test2指针变量所指向的对象，所以@"test2"对象本身不可修改，但是可以修改test2的指针变量；

static NSInteger const test3 = 3; // 不可修改

static NSString *test4 = @"test4";

@interface BPGeneralProgrammingViewController ()

@end

@implementation BPGeneralProgrammingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self ternaryOperator];// 三目运算符
            }
                break;
                
            case 1:{
                BPLog(@"进函数栈");
                [self basics_staticAndConst];// static/const
                BPLog(@"出函数栈");
                BPLog(@"test2 = %@,%p,%p",test2,test2,&test2);
                BPLog(@"test4 = %@,%p,%p",test4,test4,&test4);
            }
                break;
        }
    }
}

#pragma mark - static const
- (void)basics_staticAndConst {
    
    //test1 = @"test1-1";//不可修改test1变量
    
    BPLog(@"test2 = %p,%p",test2,&test2);//  test2对象所在的地址，&test2指针所在的地址
    
    test2 = @"test2-2";
    
    BPLog(@"test2 = %p,%p",test2,&test2);

    //test3 = 3;//不可修改test1变量
    
    BPLog(@"test4 = %@,%p,%p",test4,test4,&test4);
    test4 = @"test4-4";
    BPLog(@"test4 = %@,%p,%p",test4,test4,&test4);
}

#pragma mark - 三目运算符
- (void)ternaryOperator {
    NSInteger a =  5>3?4:1;
    NSInteger b =  5?:1; // == 5?5:1
    //NSInteger c =  5?1:; //报错
    NSInteger c =  !1?:1;

    BPLog(@"a = %ld,b = %ld,c = %ld",a,b,c);
}

@end
