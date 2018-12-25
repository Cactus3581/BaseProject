//
//  BPRuntimeViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRuntimeViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>

#import "People.h"
#import "Animal.h"
#import "Bird.h"
#import "People+Associated.h"
#import "UIImage+Swizzling.h"

@interface BPRuntimeViewController ()
@property int age;  // 年龄
@property NSString *propertyString;

@end

@implementation BPRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self base_msgSend];
//    [self exchangeMethods];
//    [self creatClass];
//    [self getIvar];
//    [self addPropertyToCategory];
//    [self autoEncode];

//    [self autoModel];
//    [self addMethodIMP];
//    [self exchangeObj];
//    [self invocation];
//    [self getPropertyAttribute];
//    [self use_invocation];
//    [self use_invocation_performSelector_multiplePara];
//    [self imp_functionPointer];

}


- (void)getPropertyAttribute {
    _age = 18;
    _propertyString = @"xiaruzhen";
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for(int i = 0; i < outCount; i++) {
        unsigned int count = 0;
        objc_property_attribute_t *attributes = property_copyAttributeList(properties[i], &count);
        for(int j = 0; j < count; j++){
            BPLog(@"attribute.name = %s, attribute.value = %s", attributes[j].name, attributes[j].value);
        }
    }
}

#pragma mark - 基础使用：消息发送
- (void)base_msgSend {
    // 创建person对象
    People *person = [[People alloc] init];
    
    // 调用对象方法1
    [person hello];
    
    // 调用对象方法2
    ((void(*)(id, SEL)) objc_msgSend)((id)person, @selector(hello));
    
    // 调用类方法1-通过类名调用
    [People hi];
    // 调用类方法2-类对象调用
    [[People class] hi];
    
    // 调用类方法3-底层会自动把类名转换成类对象调用
    ((void(*)(id, SEL)) objc_msgSend)([People class], @selector(hi));
    


}

- (void)imp_functionPointer {
    // 定义普通的c语言函数指针
    int (* func)(int val); //定义一个函数指针变量
    func = test ; //把函数test地址直接赋给func
    BPLog(@"%d",func(2));
    
    // 定义OC语言函数指针
    NSString *(*func1) (id, SEL, NSString *); //定义一个IMP，函数指针变量
    NSString *params = @"getFuncPointer";
    func1 = (NSString * (*)(id,SEL,NSString *))[self methodForSelector:@selector(getFuncPointer:)];//通过methodForSelector方法根据SEL获取对应的函数指针
    func1(self,@selector(getFuncPointer:),params);//通过取到的IMP（函数指针）跳过runtime消息传递机制，直接执行message方法
}

- (NSString *)getFuncPointer:(NSString *)param {
    BPLog(@"%@",param);
    return param;
}

int test(int val) {
    return val+1;
}

#pragma mark - 交换方法的实现
- (void)exchangeMethods {
    // 需求：给imageNamed方法提供功能:判断图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    UIImage *image = [UIImage imageNamed:@"123"];
}

#pragma mark - 动态创建一个类，并创建成员变量和方法，最后赋值成员变量并发送消息。其中成员变量的赋值使用了KVC和object_setIvar函数两种方式
// 自定义一个方法
void sayFunction(id self, SEL _cmd, id some) {
    BPLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")),[self valueForKey:@"name"],some);
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
    // objc_msgSend(peopleInstance, s, @"大家好!"); // 这样写会报错，但是也可以通过Build Setting–> Apple LLVM 7.0 – Preprocessing–> Enable Strict Checking of objc_msgSend Calls 改为 NO
    ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, s, @"大家好");//强制转换objc_msgSend函数类型为带三个参数且返回值为void函数，然后才能传三个参数。
    
    peopleInstance = nil; //当People类或者它的子类的实例还存在，则不能调用objc_disposeClassPair这个方法；因此这里要先销毁实例对象后才能销毁类；
    
    // 销毁类
    objc_disposeClassPair(People);
}

#pragma mark - 获取对象所有的属性名称和属性值、获取对象所有成员变量名称和变量值、获取对象所有的方法名和方法参数数量。
- (void)getIvar {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍井空";
    cangTeacher.age = 18;
    [cangTeacher setValue:@"东京" forKey:@"address"];
    
    NSDictionary *propertyResultDic = [cangTeacher allProperties];
    for (NSString *propertyName in propertyResultDic.allKeys) {
        BPLog(@"属性名字:%@, 属性值:%@",propertyName, propertyResultDic[propertyName]);
    }
    
    NSDictionary *ivarResultDic = [cangTeacher allIvars];
    for (NSString *ivarName in ivarResultDic.allKeys) {
        BPLog(@"变量名字:%@, 变量值:%@",ivarName, ivarResultDic[ivarName]);
    }
    
    NSDictionary *methodResultDic = [cangTeacher allMethods];
    for (NSString *methodName in methodResultDic.allKeys) {
        BPLog(@"方法名字:%@, 参数个数:%@", methodName, methodResultDic[methodName]);
    }
}

#pragma mark - 添加属性和回调，但是添加属性没有什么意义，用的比较多的就是添加回调了。

- (void)addPropertyToCategory {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍井空";
    cangTeacher.age = 18;
    cangTeacher.phoneNumber = @"10086";
    [cangTeacher setValue:@"老师" forKey:@"occupation"];
    cangTeacher.associatedBust = @(90);
    cangTeacher.associatedCallBack = ^(){
        BPLog(@"苍老师要写代码了！");
    };
    cangTeacher.associatedCallBack();
    
    NSDictionary *propertyResultDic = [cangTeacher allProperties];
    for (NSString *propertyName in propertyResultDic.allKeys) {
        BPLog(@"属性名字:%@, 属性值:%@",propertyName, propertyResultDic[propertyName]);
    }
    
    NSDictionary *methodResultDic = [cangTeacher allMethods];
    for (NSString *methodName in methodResultDic.allKeys) {
        BPLog(@"方法名字:%@, 方法参数个数:%@", methodName, methodResultDic[methodName]);
    }
    
    /*
    会报错
    People *model = [[People alloc] init];
    model.unfinishIvar = @"unfinishIvar";
    BPLog(@"%@",model.unfinishIvar);
     */
}


#pragma mark - 自动归档&反归档
- (void)autoEncode {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍井空";
    cangTeacher.age = @18;
    cangTeacher.occupation = @"老师";
    cangTeacher.nationality = @"日本";
    
    NSString *path = NSHomeDirectory();
    path = [NSString stringWithFormat:@"%@/cangTeacher",path];
    // 归档
    [NSKeyedArchiver archiveRootObject:cangTeacher toFile:path];
    // 解归档
    People *teacher = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    BPLog(@"热烈欢迎，从%@远道而来的%@岁的%@%@",teacher.nationality,teacher.age,teacher.name,teacher.occupation);
}

#pragma mark - 自动模型转换与KVC的比较
- (void)autoModel {
    NSDictionary *dict = @{
                           @"name" : @"苍井空",
                           @"age"  : @18,
                           @"occupation" : @"老师",
                           @"nationality" : @"日本"
                           };
    
    // 字典转模型
    People *cangTeacher = [[People alloc] initWithDictionary:dict];
    BPLog(@"热烈欢迎，从%@远道而来的%@的%@%@",cangTeacher.nationality,cangTeacher.age,cangTeacher.name,cangTeacher.occupation);
    
    // 模型转字典
    NSDictionary *covertedDict = [cangTeacher covertToDictionary];
    BPLog(@"%@",covertedDict);
}

#pragma mark - 动态添加方法
- (void)addMethodIMP {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍老师";
    [cangTeacher sing]; // 在sing 声明的情况下，动态添加sing方法的实现
    [cangTeacher performSelector:@selector(sing)]; // 在sing没有声明的情况下，动态添加sing方法的实现
}

#pragma mark - 动态更换调用对象
- (void)exchangeObj {
    Bird *bird = [[Bird alloc] init];
    bird.name = @"小小鸟";
    ((void (*)(id, SEL))objc_msgSend)((id)bird, @selector(sing));
}

#pragma mark - 实现不提供声明和实现，不修改调用对象，而是修改方法
- (void)invocation {
    Animal *animal = [[Animal alloc] init];
    ((void(*)(id, SEL)) objc_msgSend)((id)animal, @selector(sing));
}

#pragma mark - 使用NSMethodSignature和NSInvocation执行method 或 block
/*
 NSMethodSignature和NSInvocation是Foundation框架为我们提供的一种调用方法的方式，经常用于消息转发。

 NSMethodSignature用于描述method的类型信息：返回值类型，及每个参数的类型。
 
 因为方法调用有self（调用对象）和_cmd（选择器）这2个隐含参数，因此设置参数时，索引应该从2开始。
 因为参数是对象，所以必须传递指针，即&object。
 methodReturnLength为0时，表明返回类型是void，因此不需要获取返回值。返回值是对象的情况下，不需要我们来创建buffer。但如果是C风格的字符串、数组等类型，就需要自行malloc，并释放内存了。
 
 */

- (void)use_invocation {
    //一个实例对象可以通过三种方式调用其方法
    //type1
    [self printStr:@"hello world 1"];
    
    //type2
    [self performSelector:@selector(printStr:) withObject:@"hello world 2"];
    
    //type3
    //获取方法签名
    NSMethodSignature *signature;
    signature = [NSMethodSignature instanceMethodSignatureForSelector:@selector(printStr:)];//类方法创建
    signature = [self methodSignatureForSelector:@selector(printStr:)]; //实例方法创建
    
    //获取方法签名对应的invocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    /**
     设置消息接受者，与[invocation setArgument:(__bridge void * _Nonnull)(self) atIndex:0]等价
     */
    [invocation setTarget:self];
    
    /**设置要执行的selector。与[invocation setArgument:@selector(printStr:) atIndex:1] 等价*/
    [invocation setSelector:@selector(printStr:)];
    
    //设置参数
    NSString *str = @"hello world 3";
    [invocation setArgument:&str atIndex:2];
    
    //开始执行
    [invocation invoke];
}

- (void)printStr:(NSString *)str {
    NSLog(@"printStr  %@",str);
}

- (void)use_invocation_performSelector_multiplePara {
    id target = self;
    NSString *methodName = @"invocationWithString:num:array:";
    NSArray *array1 = @[@"a", @"b", @"c", @"d"];
    NSArray *array = @[@"A", @(1), array1];
    [self testWithTarget:target SELString:methodName parameters:array];
}

- (void)invocationWithString:(NSString *)string num:(NSNumber *)number array:(NSArray *)array {
    NSLog(@"%@, %@, %@", string, number, array);
}

// 如何实现performSelector 传入多个参数
- (id)testWithTarget:(id)target SELString:(NSString *)sel parameters:(NSArray *)parameters {
    // 创建SEL
    SEL selector = NSSelectorFromString(sel);
    // 创建NSMethodSignature
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    // 创建NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 设置target
    invocation.target = target;
    // 设置SEL
    invocation.selector = selector;
    // 增加参数
    [parameters enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [invocation setArgument:&obj atIndex:idx+2];
    }];
    // 开始调用
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

//使用NSInvocation调用block
- (void)use_invocation_block {
//    void (^block1)(int) = ^(int a){
//        NSLog(@"block1 %d",a);
//    };
//    
//    //type1：常用的方法，不再赘述
//    block1(1);
//    
//    //type2：由block生成的NSInvocation对象的第一个参数是block本身，剩下的为 block自身的参数。
//    //获取block类型对应的方法签名。
//    NSMethodSignature *signature = aspect_blockMethodSignature(block1);
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    [invocation setTarget:block1];
//    int a=2;
//    [invocation setArgument:&a atIndex:1];
//    [invocation invoke];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
