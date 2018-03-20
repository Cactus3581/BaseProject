//
//  BPRuntimeViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRuntimeViewController.h"
#import "UIImage+Swizzling.h"
#import "BPRunTimeModel.h"
#import "NSObject+Propery.h"
#import "NSObject+Log.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface BPRuntimeViewController ()

@end

@implementation BPRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    
    //    //1.
    //    // 创建person对象
    //    BPRunTimeModel *BPRunTimeModel = [[BPRunTimeModel alloc] init];
    //
    //    // 调用对象方法
    //    [BPRunTimeModel test];
    //
    //    // 本质：让对象发送消息
    ////    objc_msgSend(BPRunTimeModel, @selector(test));
    //
    //    // 调用类方法的方式：两种
    //    // 第一种通过类名调用
    //    [BPRunTimeModel test1];
    //    // 第二种通过类对象调用
    //    [[BPRunTimeModel class] test1];
    
    // 用类名调用类方法，底层会自动把类名转换成类对象调用
    // 本质：让类对象发送消息
    //    objc_msgSend([BPRunTimeModel class], @selector(test1));
    
    
    
    
    //2.交换方法／方法混淆
    // 需求：给imageNamed方法提供功能:判断图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    UIImage *image = [UIImage imageNamed:@"123"];
    
    
    //3.动态添加方法
    BPRunTimeModel *model = [[BPRunTimeModel alloc]init];
    [model performSelector:@selector(run)];
    
    //4.给系统NSObject类动态添加属性name
    
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"sdsdd";
    BPLog(@"%@",objc.name);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
