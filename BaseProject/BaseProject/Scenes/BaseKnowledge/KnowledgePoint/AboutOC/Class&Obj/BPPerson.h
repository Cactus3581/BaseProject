//
//  BPPerson.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPPersonHealth.h"

/*
 1.接口部分:以@interface 开头，以@end结尾，只要符合这种形式，就可以完成类的接口部分。
 接口部分完成实例变量(也称为静态特征) 和方法的声明

 2.实例变量的可见度
 @public 公共的，在类的内部和外部都可以进行实例变量的访问 －－破坏了封装特性
 @private 私有的，只有在当前类内部才能够直接访问，在类的内部及其子类都不可以进行访问－－破坏了继承特性
 @protected 受保护的，只有当前类及其子类才能进行访问     －－系统默认的
 
 3.import 比include高级，避免重复导入
 
 4.对于两个类 A和B 互相导入头文件 就会引起循环导入现象.解决办法：首先在一个类，A的.h文件中 使用@class 修饰B类，然后在A的.m文件中导入B的头文件
 */

@interface BPPerson : NSObject <NSCopying> {//copy协议
#pragma 实例变量
@public
    NSString *_name;
    CGFloat _weight;
    NSString *_email;
@private
    NSString *_sex;
@protected
    NSInteger _age;
}

#pragma 属性
@property NSString *name;
@property (nonatomic,copy,setter = writeEmail:) NSString *email;
@property (nonatomic,assign) CGFloat weight;
@property (nonatomic,strong) BPPersonHealth *health;

//初始化方法
-(instancetype)init;

//便利构造器
+(BPPerson *)personWithName:(NSString*)name weight:(CGFloat)weight;

//打招呼
-(void) sayHi;

//setter getter
-(void)setName:(NSString *)name;

-(NSString *)name;

//按照姓名升序

- (NSComparisonResult)compareByAge:(BPPerson *)anotherPerson;
- (NSComparisonResult)compareByName:(BPPerson *)anotherStudent;
- (NSComparisonResult)compareByName2:(BPPerson *)anotherStudent;

//重写description
- (NSString *)description;

@end
