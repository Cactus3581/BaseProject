//
//  BPRuntimeViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPRuntimeViewController.h"
#import <objc/message.h>
#import <objc/runtime.h>

#import "People.h"
#import "Animal.h"
#import "Bird.h"
#import "People+Associated.h"
#import "BPSwizzlingParent.h"
#import "BPSwizzlingChild.h"
#import "BPSwizzlingParent+BPSwizzling.h"
#import "BPSwizzlingParent+BPSwizzlingB.h"
#import "BPSwizzlingChild+BPSwizzing.h"

#import "NSObject+BPWatchDealloc.h"
#import "NSObject+BPModel.h"

#import "BPRuntimeSark.h"
#import "NSObject+BPSark.h"
#import "BPCategoryParentModel.h"
#import "BPCategorySubModel.h"

@interface BPRuntimeViewController () {
    NSString * _dynamicString2;//手动添加，由于@dynamic不能像@synthesize那样向实现文件(.m)提供实例变量，所以我们需要在类中显式提供实例变量。
}

@property int age;  // 年龄
@property NSString *propertyString;
@property (nonatomic, copy) NSString *synthesizeString1;
@property (nonatomic, copy) NSString *synthesizeString2;
@property (nonatomic, copy) NSString *dynamicString1;
@property (nonatomic, copy) NSString *dynamicString2;//需要手动添加，网上看

@end


@implementation BPRuntimeViewController

//@synthesize和@dynamic
@synthesize synthesizeString1;
@synthesize synthesizeString2 = _re_synthesizeString2;
@dynamic dynamicString1;
@dynamic dynamicString2;

//协议的属性
@synthesize protocolName = _protocolName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self base_msgSend];//函数调用的几种方法
            }
                break;
                
            case 1:{
                [self hookMethods];// 交换方法的实现
            }
                break;
                
            case 2:{
                [self creatClass];// 动态创建类
            }
                break;
                
            case 3:{
                [self getIvar];// 获取属性、变量、方法
            }
                break;
                
            case 4:{
                [self addPropertyToCategory];// 给category添加关联对象
            }
                break;
                
            case 5:{
                [self autoEncode];// 归档反归档
            }
                break;
                
            case 6:{
                [self autoModel];// 模型转换
            }
                break;
                
            case 7:{
                [self addMethodIMP];//动态解析 动态添加方法
            }
                break;
                
            case 8:{
                [self exchangeObj];//消息转发 动态更换调用对象
            }
                break;
                
            case 9:{
                [self invocation];//消息完整转发 实现不提供声明和实现，不修改调用对象，而是修改方法
            }
                break;
                
            case 10:{
                [self getPropertyAttribute]; // 打印属性的性质
            }
                break;
                
            case 11:{
                [self perform]; //perform 基础调用方法
            }
                break;
                
            case 12:{
                [self use_invocation_performSelector_multiplePara];//invocation 传递多个参数
            }
                break;
                
            case 13:{
                [self imp_functionPointer]; // 函数指针
            }
                break;
                
            case 14:{
                [self selfAndSuperInInstanceMethod]; // self与super的class
                [BPRuntimeViewController selfAndSuperInClassMethod];
            }
                break;
                
            case 15:{
                [self dynamicType]; // 动态特性
            }
                break;
                
            case 16:{
                [self designKVO]; // 设计KVO
            }
                break;
                
            case 17:{
                [self synthesizeString]; //synthesize
            }
                break;
                
            case 18:{
                [self handleProtocolName]; //协议的属性
            }
                break;
                
            case 19:{

            }
                break;
                
            case 20:{
                [self changeSark]; //面试题
            }
                break;
                
            case 21:{
                [self getThing]; // runtime API
            }
                break;
                
            case 22:{
                [self addMethodToCategory]; // 向category 添加方法
            }
                break;
        }
    }
}

#pragma mark - 面试题
- (void)changeSark {
    // 测试代码1
    [NSObject p_foo];
//    [[NSObject new] p_foo];// 编译错误

    // 测试代码2
    NSString *name = @"ryan";
    id cls = [BPRuntimeSark class];
    void *obj = &cls;// 相当于创建了一个对象:对象是指向类对象地址的变量
    [(__bridge id)obj speak];// 为什么把name加进来了？：实例变量是对象的地址+偏移量，一般的偏移量是4，也就是在这个栈上+4，往上看就是name。
}

#pragma mark - 动态类型
- (void)designKVO {
    
    // 注册kvo
    [self.view addObserver:self forKeyPath:@"pauseTimer" options:NSKeyValueObservingOptionNew context:nil];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (didEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];//注册程序进入后台通知

    __weak typeof (self) weakSelf = self;
    [self bp_executeAtDealloc:^{
        [weakSelf.view removeObserver:weakSelf forKeyPath:@"pauseTimer"];
        [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
}

- (void)didEnterBackground {
    
}

#pragma mark - 动态类型
- (void)dynamicType {
    //类族（工厂模式构建的）：NSNumber同NSArray也是含有隐藏的多个子类
    NSMutableArray *muArray = @[].mutableCopy;
    BPLog(@"== %d,%d",[muArray class] == [NSArray class],[muArray class] == [NSMutableArray class]);// 0,0
    BPLog(@"isMemberOfClass %d,%d",[muArray isMemberOfClass:[NSArray class]],[muArray isMemberOfClass:[NSMutableArray class]]);// 0,0
    BPLog(@"isKindOfClass %d,%d",[muArray isKindOfClass:[NSArray class]],[muArray isKindOfClass:[NSMutableArray class]]); // 1,1
    
    BPLog(@"NSArray %d,%d",[[NSArray class] isKindOfClass:[NSArray class]],[[NSArray class] isMemberOfClass:[NSArray class]]); // 0,0
    BPLog(@"NSObject %d,%d",[[NSObject class] isKindOfClass:[NSObject class]],[[NSObject class] isMemberOfClass:[NSObject class]]); // 1,0
    BPLog(@"UIViewController %d,%d",[[UIViewController class] isKindOfClass:[UIViewController class]],[[UIViewController class] isMemberOfClass:[UIViewController class]]); // 0,0


    // sing=1没有声明，也没有实现，但是sing的sel指向了otherdSing的函数实现；dance=0没有声明，也没有实现；hello=1提供了声明和实现；say=0有声明，没实现；
    People *people = [[People alloc] init];
    BPLog(@"%d,%d,%d,%d",[people respondsToSelector:@selector(sing)],[people respondsToSelector:@selector(dance)],[people respondsToSelector:@selector(hello)],[people respondsToSelector:@selector(say)]);// 1,0,1,0
    
    NSArray *array1 = @[];

    BPLog(@" == %@,%@",[@"" class],[NSString class]);//__NSCFConstantString,NSString
    BPLog(@" == %d,%d",[array1 isKindOfClass:[NSMutableArray class]],[[array1 class] isKindOfClass:[NSMutableArray class]]);//0,0

    // sing=0没有声明，也没有实现，调用的是People的同名方法；
    Bird *bird = [[Bird alloc] init];
    BPLog(@"%d",[bird respondsToSelector:@selector(sing)]);// 0
    
    
    // sing=0没有声明，也没有实现；dance=1没有声明，是通过forwardInvocation添加的；
    Animal *animal = [[Animal alloc] init];
    BPLog(@"%d,%d",[animal respondsToSelector:@selector(sing)],[animal respondsToSelector:@selector(dance)]);// 0,1
    
    UIViewController *vc = [[UIViewController alloc] init];
    BPLog(@"conformsToProtocol = %d",[vc conformsToProtocol:@protocol(BPDynamicJumpHelperProtocol)]);
    BPLog(@"conformsToProtocol = %d",[self conformsToProtocol:@protocol(BPDynamicJumpHelperProtocol)]);
}

#pragma mark - self与super的class方法
- (void)selfAndSuperInInstanceMethod {
    
    //在实例方法里使用，以下返回的都是当前类：`BPRuntimeViewController`：
    Class a1 = [self class]; // 不管是类还是对象，返回的都是类本身
    Class a2 = [super class];
    Class a3 = [BPRuntimeViewController class];

    //在实例方法里使用，以下返回的都是当前类的父类：`BPBaseViewController`：
    Class b1 = [self superclass]; // 不管是类还是对象，返回的都是类本身
    Class b2 = [super superclass];
    Class b3 = [BPRuntimeViewController superclass];
    
    BPLog(@"%@,%@,%@,%@,%@,%@,%@",self,NSStringFromClass(a1),NSStringFromClass(a2),NSStringFromClass(a3),NSStringFromClass(b1),NSStringFromClass(b2),NSStringFromClass(b3));
}

// 在类方法中
+ (void)selfAndSuperInClassMethod {
    //在类方法里使用，以下返回的都是当前类：`BPRuntimeViewController`：
    Class a1 = [self class]; // 不管是类还是对象，返回的都是类本身
    Class a2 = [super class];
    Class a3 = [BPRuntimeViewController class];
    
    //在类方法里使用，以下返回的都是当前类的父类：`BPBaseViewController`：
    Class b1 = [self superclass]; // 不管是类还是对象，返回的都是类本身
    Class b2 = [super superclass];
    Class b3 = [BPRuntimeViewController superclass];
    
    BPLog(@"%@,%@,%@,%@,%@,%@,%@",self,NSStringFromClass(a1),NSStringFromClass(a2),NSStringFromClass(a3),NSStringFromClass(b1),NSStringFromClass(b2),NSStringFromClass(b3));
}

#pragma mark - 打印属性的属性
- (void)getPropertyAttribute {
    _age = 18;
    _propertyString = @"Ryan";
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

#pragma mark - 基础使用：消息发送：一个象可以通过四种方式调用其方法

- (void)printStr:(NSString *)str {
    BPLog(@"printStr  %@",str);
}

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

#pragma mark - 函数指针：消息发送
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

#pragma mark - HOOK
- (void)hookMethods {

    BPSwizzlingParent *parent = [[BPSwizzlingParent alloc] init];
    [parent foo];
    [parent p_foo];
    [parent p1_foo];

    BPSwizzlingChild *child = [[BPSwizzlingChild alloc] init];
    [child foo];
    [child s_foo];
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
    SEL sel = sel_registerName("say:");
    // 为该类增加名为say的方法
    class_addMethod(People, sel, (IMP)sayFunction, "v@:@");
    
//    Method instanceMethod = class_getInstanceMethod(People, sel);
//    class_addMethod(People, sel, method_getImplementation(instanceMethod), method_getTypeEncoding(instanceMethod));
    
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
    ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, sel, @"大家好");//强制转换objc_msgSend函数类型为带三个参数且返回值为void函数，然后才能传三个参数。
    
    peopleInstance = nil; //当People类或者它的子类的实例还存在，则不能调用objc_disposeClassPair这个方法；因此这里要先销毁实例对象后才能销毁类；
    
    // 销毁类
    objc_disposeClassPair(People);
}

- (void)getThing {
    People *myClass = [[People alloc] init];
    unsigned int outCount = 0;
    Class cls = People.class;
    // 类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"==========================================================");
    // 父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"==========================================================");
    // 是否是元类
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
    NSLog(@"==========================================================");
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
    NSLog(@"==========================================================");
    // 变量实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"==========================================================");
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instace variable %s", ivar_getName(string));
    }
    NSLog(@"==========================================================");
    // 属性操作
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    free(properties);
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    NSLog(@"==========================================================");
    // 方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %s", method_getName(classMethod));
    }
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"==========================================================");
    // 协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"==========================================================");
    
    
    // 获取所有加载的Objective-C框架和动态库的名称
    const char ** objc_copyImageNames ( unsigned int *outCount );
    // 获取指定类所在动态库
    const char * class_getImageName ( Class cls );
    // 获取指定库或框架中所有类的类名
    const char ** objc_copyClassNamesForImage ( const char *image, unsigned int *outCount );
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
    cangTeacher.phoneNumber = 10086;
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
    
    
//    会报错
    People *model = [[People alloc] init];
    model.unfinishIvar = @"unfinishIvar";
    BPLog(@"%@",model.unfinishIvar);
     
}

#pragma mark - category - 添加方法
- (void)addMethodToCategory {
    /*
     主类分类的执行顺序，决定了方法实现的顺序，进而决定了消息发送时，哪个具体实现来实现。

     先主类，再分类
     主类顺序：父->子
     分类顺序：无关父子，有可能先子类的categoty，再主类的category；同个主类的分类看编译顺序。
     比如主类parent，sub，分类：p1，p2 s1，s2: parent->sub->s2->p2->p1->p2
     */
    
    BPCategoryParentModel *parent = [[BPCategoryParentModel alloc] init];
    BPCategorySubModel *sub = [[BPCategorySubModel alloc] init];
    
    [parent test];
    [sub test];
    
    [parent test1];
    [sub test1];
}

#pragma mark - 自动归档&反归档
- (void)autoEncode {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍井空";
    cangTeacher.age = 18;
    cangTeacher.occupation = @"老师";
    cangTeacher.nationality = @"日本";
    
    NSString *path = NSHomeDirectory();
    path = [NSString stringWithFormat:@"%@/cangTeacher",path];
    // 归档
    [NSKeyedArchiver archiveRootObject:cangTeacher toFile:path];
    // 解归档
    People *teacher = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    BPLog(@"热烈欢迎，从%@远道而来的%ld岁的%@%@",teacher.nationality,teacher.age,teacher.name,teacher.occupation);
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

- (void)use_invocation_performSelector_multiplePara {
    id target = self;
    NSString *methodName = @"invocationWithString:num:array:";
    NSArray *array1 = @[@"a", @"b", @"c", @"d"];
    NSArray *array = @[@"A", @(1), array1];
    [self testWithTarget:target SELString:methodName parameters:array];
}

- (void)invocationWithString:(NSString *)string num:(NSNumber *)number array:(NSArray *)array {
    BPLog(@"%@, %@, %@", string, number, array);
}

// 如何实现performSelector 传入多个参数
- (id)testWithTarget:(id)target SELString:(NSString *)sel parameters:(NSArray *)parameters {
    // 创建SEL
    SEL selector = NSSelectorFromString(sel);
    // 创建NSMethodSignature
    NSMethodSignature *methodSignature = [target methodSignatureForSelector:selector];
    // 创建NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
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
    if (methodSignature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

//使用NSInvocation调用block
- (void)use_invocation_block {
//    void (^block1)(int) = ^(int a){
//        BPLog(@"block1 %d",a);
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

- (void)perform {
    
    // 同步方法，在当前线程下执行
    [self performSelector:@selector(testPerform:) withObject:@(1)];// 主线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelector:@selector(testPerform:) withObject:@(2)];// 子线程
    });

    // 异步执行，即使delay传参为0，仍为异步执行；只能在主线程中执行，在子线程中不会调到aSelector方法。
    [self performSelector:@selector(testPerform:) withObject:@(3) afterDelay:1];;// 主线程异步
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelector:@selector(testPerform:) withObject:@(4) afterDelay:1]; // 不执行
    });

    //开启子线程在后台运行
    [self performSelectorInBackground:@selector(testPerform:) withObject:@(5)]; // 子线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelectorInBackground:@selector(testPerform:) withObject:@(6)];// 子线程
    });
    
    /*
     @selector在主线程下执行；
     当前线程是否要被阻塞，YES为阻塞，NO为不阻塞。
     waitUntilDone为NO：即不用等待@selector执行完成，直接执行下面的代码
     waitUntilDone为YES：即需要等待callBack执行完成后，子线程才会继续执行后面的代码；
    */
    [self performSelectorOnMainThread:@selector(testPerform:) withObject:@(7) waitUntilDone:NO];//主线程
    [self performSelectorOnMainThread:@selector(testPerform:) withObject:@(8) waitUntilDone:YES];//主线程
    
    //调用指定线程中的某个方法，在子线程下执行
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(newThread:) object:nil];
    [thread setName:@"bp_runtine_perform"];
    [thread start];
    [self performSelector:@selector(testPerform:) onThread:thread withObject:@(11) waitUntilDone:NO];
    [self performSelector:@selector(testPerform:) onThread:thread withObject:@(12) waitUntilDone:YES];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self performSelector:@selector(testPerform:) onThread:thread withObject:@(13) waitUntilDone:NO];
        [self performSelector:@selector(testPerform:) onThread:thread withObject:@(14) waitUntilDone:YES];
    });
}

- (void)testPerform:(NSNumber *)number {
    if (number.integerValue == 7 || number.integerValue == 8) {
//        sleep(5);
    }
    BPLog(@"testPerform_%@_%@_%d",number,BPThread);
}

- (void)newThread:(id)obj {
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
        //[currentRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

#pragma mark - @synthesizehe和@dynamic
- (void)synthesizeString {
    self.synthesizeString1;
    synthesizeString1;
    //_synthesizeString1;// 报错
    
    self.synthesizeString2;
    _re_synthesizeString2;
    // _synthesizeString2 //报错

    
    self.dynamicString1;
//    _dynamicString1; //报错
//    dynamicString1; //报错

    self.dynamicString2;
    _dynamicString2;
//    dynamicString2; //报错

}

- (void)setDynamicString1:(NSString *)dynamicString1 {
    
}

- (NSString *)dynamicString1 {
    return nil;
}

- (void)setDynamicString2:(NSString *)dynamicString2 {
    _dynamicString2 = dynamicString2;
}

- (NSString *)dynamicString2 {
    return _dynamicString2;
}

#pragma mark - 协议的属性
- (void)handleProtocolName {
    self.protocolName = @"BPDynamicJumpHelperProtocol";
    BPLog(@"protocolName",self.protocolName)
}

- (void)setProtocolName:(NSString *)protocolName {
    _protocolName = protocolName;
}

- (NSString *)protocolName {
    return _protocolName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
}

@end
