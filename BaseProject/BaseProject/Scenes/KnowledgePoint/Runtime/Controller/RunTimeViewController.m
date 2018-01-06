//
//  RunTimeViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/15.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "RunTimeViewController.h"
#import "UIImage+Swizzling.h"
#import "RunModel.h"
#import "NSObject+Propery.h"
#import "NSObject+Log.h"
#import <objc/message.h>
#import <objc/runtime.h>

@interface RunTimeViewController ()

@end



@implementation RunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    
//    //1.
//    // 创建person对象
//    RunModel *runmodel = [[RunModel alloc] init];
//    
//    // 调用对象方法
//    [runmodel test];
//    
//    // 本质：让对象发送消息
////    objc_msgSend(runmodel, @selector(test));
//    
//    // 调用类方法的方式：两种
//    // 第一种通过类名调用
//    [RunModel test1];
//    // 第二种通过类对象调用
//    [[RunModel class] test1];
    
    // 用类名调用类方法，底层会自动把类名转换成类对象调用
    // 本质：让类对象发送消息
//    objc_msgSend([RunModel class], @selector(test1));
    
    
    
    
    //2.交换方法／方法混淆
    // 需求：给imageNamed方法提供功能:判断图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    UIImage *image = [UIImage imageNamed:@"123"];
    
    
    //3.动态添加方法
    RunModel *model = [[RunModel alloc]init];
    [model performSelector:@selector(run)];
    
    //4.给系统NSObject类动态添加属性name
    
    NSObject *objc = [[NSObject alloc] init];
    objc.name = @"sdsdd";
    BPLog(@"%@",objc.name);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
