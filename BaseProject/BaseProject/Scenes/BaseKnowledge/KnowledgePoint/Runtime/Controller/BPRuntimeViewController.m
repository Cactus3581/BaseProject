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

// 自定义一个方法
void sayFunction(id self, SEL _cmd, id some) {
    NSLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")),[self valueForKey:@"name"],some);
}

- (void)creatClass {
    // 动态创建对象 创建一个Person 继承自 NSObject类
    Class People = objc_allocateClassPair([NSObject class], "Person", 0);
    
    // 为该类添加NSString *_name成员变量
    class_addIvar(People, "_name", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
    // 为该类添加int _age成员变量
    class_addIvar(People, "_age", sizeof(int), sizeof(int), @encode(int));
    
    // 注册方法名为say的方法
    SEL s = sel_registerName("say:");
    // 为该类增加名为say的方法
    class_addMethod(People, s, (IMP)sayFunction, "v@:@");
    
    // 注册该类
    objc_registerClassPair(People);
    
    // 创建一个类的实例
    id peopleInstance = [[People alloc] init];
    
    // KVC 动态改变 对象peopleInstance 中的实例变量
    [peopleInstance setValue:@"苍老师" forKey:@"name"];
    
    // 从类中获取成员变量Ivar
    Ivar ageIvar = class_getInstanceVariable(People, "_age");
    // 为peopleInstance的成员变量赋值
    object_setIvar(peopleInstance, ageIvar, @18);
    
    // 调用 peopleInstance 对象中的 s 方法选择器对于的方法
    // objc_msgSend(peopleInstance, s, @"大家好!"); // 这样写也可以，请看我博客说明
    ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, s, @"大家好");
    
    peopleInstance = nil; //当People类或者它的子类的实例还存在，则不能调用objc_disposeClassPair这个方法；因此这里要先销毁实例对象后才能销毁类；
    
    // 销毁类
    objc_disposeClassPair(People);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
