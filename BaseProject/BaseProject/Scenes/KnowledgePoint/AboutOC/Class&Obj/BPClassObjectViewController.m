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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
