//
//  BPPerson.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPerson.h"

/*
 1。 类的实现部分 :以@impementation开头，以@end结尾 只要符号这种形式，就可以完成类的实现。类的实现部分  主要进行 方法的实现。
*/
@implementation BPPerson

-(instancetype)initWithName:(NSString *)name weight:(CGFloat)weight {
    self = [super init];
    if (self) {
        _name = name;
        _weight = weight;
    }
    return self;
}

/*便利构造器
 1、便利构造器是一种快速创建对象的方式。它本质上是把初始化方法做了一次封装，方便外界使用
 2、便利构造器是一个类方法（以+开头）
 
 语法形式 :
 +(当前类类型) 当前类名小写开头With各个参数;
 便利构造器内部就是封装了aclloc 和初始化方法（init）。
 */
+(BPPerson *)personWithName:(NSString*)name weight:(CGFloat)weight {
    BPPerson *person = [[BPPerson alloc]initWithName:name weight:weight];
    return person;
}

- (instancetype)init {
    _name = @"joy";
    _sex = @"男";
    _age = 18;
    _weight = 140;
    NSLog(@"初始化方法:%p",self);
    return self;
}

-(void)sayHi {
    NSLog(@"name:%@ sex:%@ age: %ld,weight :%f",_name,_sex,_age,_weight);
}

//setter getter
- (void)setName:(NSString *)name {
    _name = name;
}

- (NSString *)name {
    return _name;
}

- (NSComparisonResult)compareByAge:(BPPerson *)anotherPerson {
    //降序 注意self 与anothe的使用; 如果传对象用什么表示的思想；传两个对象怎么表示的思想；点语法；三个return的思想；NSOrderedDescending；两两比较，数组返回的思想
    if (self.weight> anotherPerson.weight) {
        return NSOrderedDescending;
        
        //升序
    }else if(self.weight < anotherPerson.weight){
        return NSOrderedAscending;
    }
    //相等
    return NSOrderedSame;
}

//重写desceiption
//desceiption:设置了当前类的输出字符串的格式
- (NSString *)description {
    return [NSString stringWithFormat:@"name:%@ age:%ld",_name,_age];
}

@end
