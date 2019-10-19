//
//  BPClassObjectViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/2/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPClassObjectViewController.h"
#import "BPPerson.h"
#import "BPMan.h"

/*
 类：具有相同特征和行为实物的抽象，是对象的类型。
 对象：具体的事物，是类的实例。
 
 Extension 延展，为有源代码的类 添加私有的实例变量和私有的方法
 @interface＋ 类名（当前类名）＋（）＋@end 进行私有实例变量 和私有方法的声明
 
  category 类目，分类。为没有源代码的类添加方法，一旦添加成功，就相当于原来类具有方法。
  category 包括两个部分
  1.@interface + 类名 （为哪一个类添加分类）＋（分类名）＋@end。进行方法的声明
  2.@implementation +类名（为哪一个类添加分类）＋（分类名）＋@end，进行方法的实现。
 */
@interface BPClassObjectViewController ()

@end

@implementation BPClassObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendMessage];
}

#pragma mark - 发送消息
- (void)sendMessage {
    //创建对象
    BPPerson *person = [[BPPerson alloc] init];
    BPLog(@"对象地址:%p",person);
    //调用  打招呼。
    //中括号[receiver message];消息发送机制（消息语法）
    [person sayHi];
    
    //操作访问实例变量
    person->_weight = 333333333;
    [person sayHi];
}

#pragma mark - 释放池
/*
 
 autorelease  在未来的某一个时刻，将对象的引用计数－1（延缓－1）；一般和自动释放池连用，它会将被修饰的对象 放入离他最近的自动释放池中。
 autoreleasePool自动释放池，当自动释放池自身将要销毁的时候，会对池子内部的每一个对象 发送一个release消息。注意，出池子并不意味着对象一定被销毁，空间一定被回收，只是对象的引用计数发生变化，当减小到0时，才会销毁
 
 */
- (void)configAutoPool {
    //自动释放池对象
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    
    @autoreleasepool {
        
    }
    
    //pool自动释放池
    //[pool release];
    
    
    //1.内存泄漏
    //2.过度延缓释放
    for (int i = 0; i<100; i++) {
        /*
        Person *per = [[Person alloc]init];
         //[per release]; 若没有这句会造成：//1.内存泄漏
        [per autorelease];  //2.这句话会造成过度延缓释放
        */
        @autoreleasepool {
            BPPerson *per = [[BPPerson alloc]init];
        }
    }
}

#pragma mark - copy
- (void)copyObj {
    BPPerson *person = [[BPPerson alloc] init];
    BPPerson *person1 = [person copy];
    
    BPLog(@"%lu,%lu",BPRetainCount(person),BPRetainCount(person1));

    
    BPPerson *per1 = [[BPPerson alloc] init];
    BPPerson *per2 = [[BPPerson alloc] init];
    BPPerson *per3 = [[BPPerson alloc] init];
    NSArray *arr = [[NSArray alloc] initWithObjects:per1,per2,per3, nil];
    
    BPLog(@"per1:%lu,%p",BPRetainCount(per1),per1);

    
    //    NSArray *arr = [[NSArray alloc]initWithObjects:per1,per2,per3, nil];
    BPLog(@"arr[0]:%lu %p",BPRetainCount(arr[0]),arr[0]);
    
    
    //对不可变数组进行copy是一个浅拷贝,相当于retain操作，对数组元素也是浅拷贝，是简单的指针赋值，引用计数没有变化。
    NSArray *copyArr = [arr copy];
    BPLog(@"%p,%p",arr,copyArr);
    BPLog(@"%lu",BPRetainCount(arr));
    BPLog(@"%lu",BPRetainCount(arr[0]));
    
    //对可变数组进行拷贝是一个深拷贝，产生了一个新的数组对象。但是对于数组内的数组元素是浅拷贝，相当于retain操作。
    //
    NSMutableArray *muArr = [[NSMutableArray alloc]initWithObjects:per1,per2,per3, nil];
    NSMutableArray *copyMuArr = [muArr copy];
    BPLog(@"%p,%p",muArr,copyMuArr);
    BPLog(@"%lu %lu",BPRetainCount(muArr),BPRetainCount(copyMuArr));
    
    BPLog(@"%p,%lu,%p,%lu",muArr[0],BPRetainCount(muArr[0]),copyMuArr[0],BPRetainCount(copyMuArr[0]));
}

#pragma mark - 多态
- (void)polymorphism {
    /*
     多态面向对象编程三大特性:
     父类指针可以指向子类对象，使用多态我们可以写出通用的代码减小代码的复杂程度（例如：UI中的addSubView:）
     */
}

#pragma mark - 继承
- (void)inherit {
    BPMan *man = [[BPMan alloc] init];
    [man sayHi];
}

#pragma mark - 赋值方法
- (void)valuation {
    BPPerson *person = [[BPPerson alloc] init];
    //三种方法
    [person setName:@"李四"];
    person.weight = 12;
    //KVC : 好处可以访问私有变量
    [person setValue:@66 forKey:@"weight"];
    
    BPPersonHealth *health = [[BPPersonHealth alloc] init];
    person.health = health;
}

#pragma mark - KVC
- (void)kvc {
    BPPerson *person = [[BPPerson alloc] init];
    //KVC : 好处可以访问私有变量
    [person setValue:@66 forKey:@"weight"];
    [person setValue:@66 forKey:@"_weight"];
    [person setValue:@"170" forKeyPath:@"health.height"];
    
    //kvc取值
    [person valueForKey:@"money"];
    [person valueForKeyPath:@"health.height"];
    
    //批次存入
    NSDictionary *dic = @{@"name":@"zhangsan",@"sex":@"women"};
    [person setValuesForKeysWithDictionary:dic];
    
    BPPersonHealth *health = [[BPPersonHealth alloc] init];
    [dic setValue:health forKey:@"health"];
}

#pragma mark - 字面量 语法糖 笑笑语法  弊端：不可变
- (void)dsds {
    //NSString;
    NSString *str = @"糖";
    NSMutableString *str1 = [NSMutableString stringWithFormat:@"%@",str1 ];
    //NSArray
    NSArray *arr = @[@"1",@"2",@"3"];
    //等价于
    [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSMutableArray *muArr = [NSMutableArray arrayWithObjects:arr, nil];
    [arr objectAtIndex:1];
    //等价于
    arr[1];
    //   NSDictionary
    NSDictionary *dic = @{@"name": @"笑笑语法",@"name1":@"语法糖",@"name3":@"字面量"};
    BPLog(@"%@",dic);
    BPLog(@"%@",dic[@"name3"]);
    
    NSMutableDictionary *muDic = [NSMutableDictionary dictionaryWithDictionary:dic ];
    BPLog(@"%@",muDic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
