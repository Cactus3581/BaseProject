//
//  BPMemoryViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/28.
//  Copyright © 2017年 cactus. All rights reserved.
//

//http://blog.csdn.net/lvxiangan/article/details/50202673
//https://www.cnblogs.com/flyFreeZn/p/4264220.html
//https://www.jianshu.com/p/746c747e7e00

#import "BPMemoryViewController.h"
#import "NSTimer+BPAdd.h"
#import "NSTimer+BPUnRetain.h"
#import "BPMemoryModel.h"

@interface BPMemoryViewController()

@property(nonatomic,strong) NSString *stringStrong;
@property(nonatomic,copy) NSString *stringCopy;
@property(nonatomic,assign) NSString *stringAssign;//assign 也可修饰对象，但是作用同__unsafe_retained 弱引用，且容易成为野指针

@property (nonatomic,weak) NSTimer *timer;
@property (nonatomic, copy) NSMutableArray *muArray;
@property NSString *propertyString; // 采用默认的修饰符
@end


NSString *name;//全局未初始化区（BSS区）
static NSString *sName = @"Dely";//全局（静态初始化）区

@implementation BPMemoryViewController

@synthesize stringStrong = _stringStrong; //当getter和setter方法同时被重写时，不会自动生成这俩方法，也不会自动生成实例变量，所以需要@synthesize。
@synthesize stringCopy = _stringCopy;

/*
 enumerateObjectUsingBlock:,系统在这类快速遍历方法中会自动添加autoreleasepool.
 什么时候需要手动创建autoreleasepool?大量临时变量
 需要注意的是通过@autoreleasepool{ ... }创建的pool,会在block块执行结束后便销毁.
 */

/*
 启动app之后,动态库从start方法开始,完成动态库的加载;
 读取镜像文件,包括动态链接和可执行文件,类有了初始内存.
 进入运行时初始化,将编译阶段的数据重新存储,更新类的内存结构.
 调用所有类与分类的+load方法
 进入main方法
 某个条件触发,创建了该对象,初始化isa指针,为之分配了内存
 对象去完成自己的使命,在此过程中引用计数发生变化,变化中系统会基于TLS做出优化,并在SideTable中保存对象的引用计数和弱引用信息
 最后调用dealloc方法,析构对象,释放内存,一切又归于平静了.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self memory_reWriteSetterAndetter];// 重写setter getter方法
            }
                break;
                
            case 1:{
                [self memory_memoryZones];//内存分区
            }
                break;
                
            case 2:{
                [self memory_superSelf];//self与super的区别
            }
                break;
                
            case 3:{
                [self memory_delegate];//delegate的循环引用
            }
                break;
                
            case 4:{
                [self memory_timer];//NSTimer的循环引用
            }
                break;
                
            case 5:{
                [self memory_secondaryPointer];//二级指针，指针传递，修改对象
            }
                break;
                
            case 6:{
                [self memory_accessingIvar];//不在本类中，访问实例变量（不是属性）
            }
                break;
                
            case 7:{
                [self memory_symbolization];//修饰符
            }
                break;
                
            case 8:{
                [self memory_sizeof];// 占据内存大小
            }
                break;
                
            case 9:{
                [self memory_type];// 编译优化：同一个对象的不同类型
            }
                break;
                
            case 10:{
                [self change];//面试题
            }
                break;
        }
    }
}

#pragma mark - 修饰符
- (void)memory_symbolization {
    // strong和copy在一般情况下，没什么区别，在涉及到深拷贝下会不一样
    NSString *str = [NSString stringWithFormat:@"string"];
    NSString *str1 = str;
    NSString *str2 = [str copy];
    BPLog(@"%p,%p,%p",&str,&str1,&str2);// 三个指针的地址均不一样
}

#pragma mark - 重写setter getter方法
//ARC与MRC的getter方法一致,就setter方法有着略微区别.
- (void)memory_reWriteSetterAndetter {
    self.stringStrong = @"stringStrong";
    NSString *stringStrong = self.stringStrong;
    
    self.stringCopy = @"stringCopy";
    NSString *stringCopy = self.stringCopy;
}

- (void)setStringStrong:(NSString *)stringStrong {
    _stringStrong = stringStrong;// ARC
    
    /* MRC
     [stringStrong retain];
     [_stringStrong release];
     _stringStrong = stringStrong;
     */
}

- (NSString *)stringStrong {
    return _stringStrong;
}

- (void)setStringCopy:(NSString *)stringCopy {
    _stringCopy = [stringCopy copy];// ARC
    /* MRC
    [_stringCopy release];
    _stringCopy = [stringCopy copy];
     */
}

- (NSString *)stringCopy {
    return _stringCopy;
}

- (void)setStringAssign:(NSString *)stringAssign {
    _stringAssign = stringAssign;// ARC||MRC
}

#pragma mark - 内存分区
/*assign和__unsafe_unretained：其实是一个东西，不同的时代不同的叫法，容易造成野指针，访问僵尸对象，会造成crash，下面会具体讲；

开启ARC后，如果部署iOS版本是5.0以上，请使用weak，5.0以下的才用unsafe_unretained，*/

- (void)memory_memoryZones {
/*
 本文的堆和栈是操作系统的内存中堆和栈，不是数据结构中的堆和栈。
 */
    int tmpAge;//栈
    NSString *number = @"123456"; //123456在常量区，number在栈上。文字常量区 存放常量字符串，程序结束后由系统释放
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];//分配而来的8字节的区域就在堆中，array在栈中，指向堆区的地址
    NSInteger total = [self getTotalNumber:1 number2:1];//参数和局部变量在栈
}

- (NSInteger)getTotalNumber:(NSInteger)number1 number2:(NSInteger)number2{
    return number1 + number2;//number1和number2 栈区
}

#pragma mark - 访问实例变量（不是属性）
- (void)memory_accessingIvar {
    BPMemoryModel *memoryModel = [[BPMemoryModel alloc] init];
    [memoryModel setValue:@"readonlyString" forKey:@"readonlyString"];
    
    //封装就是把类的一些信息隐藏起来，不允许外部程序直接访问，而是通过这个类提供的方法来实现对内部隐藏的信息的访问和操作。
    memoryModel->_readonlyInstanceString = @"readonlyString";
    
    /* 编译报错
     memoryModel.readonlyString = @"readonlyString";
     memoryModel->_readonlyString = @"readonlyString";
     */
}

#pragma mark - self 与 super
- (void)memory_superSelf {
    [BPMemoryViewController class_super_getClass];
    [self objc_super_getClass];
}

+ (void)class_super_getClass {
    BPLog(@"%@,%@,%@",self,[self class],[super class]);
}

- (void)objc_super_getClass {
    BPLog(@"%@,%@,%@",self,[self class],[super class]);
}

#pragma mark - 二级指针，指针传递，修改对象
- (void)memory_secondaryPointer {
    // 对象
    NSString *name = @"A";
    NSString *name1 = name;
    
    [self setAName:name];
    BPLog(@"%@",name);
    [self setBName:&name];
    BPLog(@"%@",name);
    BPLog(@"%@",name1);
    
    // 属性
    self.propertyString = @"D";
    [self setAAName:self.propertyString];
    BPLog(@"%@",self.propertyString);
    [self setBBName:&(_propertyString)];// 对于属性，如果是__autoreleasing，会报错，这里采用的是strong
    BPLog(@"%@",self.propertyString);
    
    // 基本数据
    NSInteger a = 10;
    [self setAIntType:a];
    BPLog(@"%ld",a);
    [self setBIntType:&a];
    BPLog(@"%ld",a);
    
    NSString *__autoreleasing pointer = @"P";
    
    NSString * __autoreleasing *error = &pointer;
}

- (void)setAName:(NSString *)name {
    name = @"B";
    BPLog(@"%@",name);
}

- (void)setBName:(NSString **)name {
    *name = @"C";
    BPLog(@"%@",*name);
}

- (void)setAAName:(NSString *)name {
    name = @"E";
    BPLog(@"%@",name);
}

- (void)setBBName:(NSString *__strong*)name {
    *name = @"F";
    BPLog(@"%@",*name);
}

- (void)setAIntType:(NSInteger)number {
    number = 1;
    BPLog(@"%ld",number);
}

- (void)setBIntType:(NSInteger *)number {
    *number = 2;// 虽然是指针的值传递，但是修改的是对象内容
    BPLog(@"%ld",*number);
}

// 系统方法一般不会引起循环引用，比如GCD，AFN，UIView动画，一般的类方法，系统的block在结束的时候会释放引用对象，有兴趣可以看，GCD源码；


/*

 4> assign和__unsafe_unretained：其实是一个东西，不同的时代不同的叫法，容易造成野指针，访问僵尸对象，会造成crash，下面会具体讲；
 1. 使用__weak打破循环的方法只在ARC下才有效，在MRC下应该使用__block

 */


- (void)memory_block {
    __weak typeof(self)weakSelf = self;
    /*GCD不需要
     因为将block作为参数传给dispatch_async时，系统会将block拷贝到堆上，而且block会持有block中用到的对象，因为dispatch_async并不知道block中对象会在什么时候被释放，为了确保系统调度执行block中的任务时其对象没有被意外释放掉，dispatch_async必须自己retain一次对象（即self），任务完成后再release对象（即self）。但这里使用__weak，使dispatch_async没有增加self的引用计数，这使得在系统在调度执行block之前，self可能已被销毁，但系统并不知道这个情况，导致block执行时访问已经被释放的self，而达不到预期的结果。
     因为gcd执行完后会释放。
     */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self test];
        //执行完释放
    });
    
    //当动画结束时，UIView 会结束持有这个 block，block 对象就会释放掉，从而 block 会释放掉对于 self 的持有。整个内存引用关系被解除。
    [UIView animateWithDuration:0.2 animations:^{
        self.view ;
    }];
}

#pragma mark - delegate的循环引用
- (void)memory_delegate {
    /*
     delegate引起循环引用的原因：
     [self.view addSubview:view1]，如果appdelegate的修饰符是strong的话：self.view 强引用view1，view1的代理是self.view，导致循环引用
     
     */
}

#pragma mark - NSTimer的循环引用
- (void)memory_timer {
    //aTarget(t)：发送消息的目标，timer会强引用aTarget，直到调用invalidate方法
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(test) userInfo:nil repeats:YES];
//    _timer = timer;
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//    [timer fire];
    
    
    /*
     第一个问题：为什么说会出现循环引用？
     在一般做法的角度来说：
     self->timer:创建定时器时,当前控制器引用而定时器了(为什么要引用定时器?下面要用到这个定时器对象来让（target）self执行命令，如果不长时间强引用定时器，定时器会释放。)
     timer->self:说到这先把NSTimer的创建方法说下，timer当repeat的时候，为了让方法可以执行下去。必须确定target的生命周期至少在手动调用invalidate之前或是事件出口执行完的时候，所以timer必对target做强持有，也就是定时器保留了self(当前控制器)，不让他提前释放，所以这也就是NSTimer强持有target的原因了。
     
     第二个问题： nstimer为何可以转移target为类对象？说明：这就是这个问题的关键啊，转移target，不对当前self做强持有，打破循环。那么为什么不能是其他对象呢？
     可以是其他对象。转移成nsginer的类对象，是因为类对象生命周期
     
     第三个问题：self持有timer是确定的，block持有self也是确定的，这说明self并不持有block，怎么会导致循环引用：这是因为这里的block是timer.info，self持有timer，timer持有block，block持有self造成了循环引用。
     
     第四个问题：为什么当pop时，此时timer还在执行任务，delloc走了，但是在vc里还是执行任务，vc不是已经释放了吗？
     执行任务的block块 在timer的info里，target是NSTimer的类对象
     */
    
    //把timer的target设置为了timer的分类，从而消除了timer对vc的引用
    
    
    __block NSInteger i = 0;
    weakify(self);
    self.timer = [NSTimer bp_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        strongify(self);
        [self test];
        BPLog(@"----------------");
        if (i++ > 10) {
            [timer invalidate];
        }
    }];
}


- (void)test {
    
}

#pragma mark - sizeof
- (void)memory_sizeof {
    
    int a = 10;
    // 1,2,3 都是得到的int类型的大小
    NSInteger length1 = sizeof(int);         //4，求的是一个int类型占的大小
    NSInteger length2 = sizeof(a);           //4，求的是一个int类型占的大小
    NSInteger length3 = sizeof(10);          //4，求的是一个int类型占的大小
    NSInteger length4 = sizeof(int *);       //8，求的是指针占的大小


    NSString *string = @"string";
    // 下面都是得到的指针的大小，
    NSInteger length5 = sizeof(NSString *);  //8，求的是指针占的大小
    NSInteger length6 = sizeof(@"string");   //8，根据字符串长度而定的内存区域。
    NSInteger length7 = sizeof(string);      //8，根据字符串长度而定的内存区域。

    BPLog(@"%ld,%ld,%ld,%ld,%ld,%ld,%ld",length1,length2,length3,length4,length5,length6,length7);
}

#pragma mark - 编译优化：同一个对象的不同类型
- (void)memory_type {
    //测试代码
    NSString *a = @"string";
    NSString *b = [[NSString alloc] init];
    NSString *c = [[NSString alloc] initWithString:@"string"];
    NSString *d = [[NSString alloc] initWithFormat:@"string"];
    NSString *e = [NSString stringWithFormat:@"string"];
    NSString *f = [NSString stringWithFormat:@"123456789"];
    NSString *g = [NSString stringWithFormat:@"1234567890"];
    
    BPDLog(a); BPDLog(b); BPDLog(c); BPDLog(d); BPDLog(e); BPDLog(f); BPDLog(g);
    
    NSArray *a1 = @[@"1",@"2"];
    NSArray *a2 = [[NSArray alloc] init];
    NSArray *a3 = [[NSArray alloc] initWithObjects:@"1", nil];
    NSArray *a4 = [[NSArray alloc] initWithArray:@[@"a",@"b"]];
    NSArray *a5 = [NSArray arrayWithObjects:@"m",@"n", nil];
    NSArray *a6 = [[NSArray alloc] init];
    NSArray *a7 = @[];
    
    BPDLog(a1); BPDLog(a2); BPDLog(a3); BPDLog(a4); BPDLog(a5); BPDLog(a6);BPDLog(a7);
}


#pragma mark - 面试题
- (void)change {
    /*
     NSMutableArray *muArray = [[NSMutableArray alloc] init];
     self.muArray = muArray; //崩溃 调用setter方法: _muArray = [muArray copy];
     _muArray = muArray; //不崩溃 访问的是实例变量，没有进行copy操作；
     //修饰词通过setter方法决定属性的内存管理.
     [_muArray removeAllObjects];
     */
    
    /*
     _muArray = [[NSMutableArray alloc] init];
     [_muArray removeAllObjects];//不崩溃：之前的疑惑点在这：_muArray指的是谁，这里指的肯定是NSMutableArray类的对象,虽然是copy，但是这里没用到copy方法，所以_muArray一直是NSMutableArray的对象，除非用到了setter方法;
     */
    
    /*
     _muArray = [[NSMutableArray alloc] init];
     [_muArray addObject:@"1"];
     NSMutableArray *muArray = [[NSMutableArray alloc] init];
     [muArray addObject:@"2"];
     BPLog(@"%@,%@",muArray,_muArray);
     
     //self.muArray = muArray;//崩溃
     _muArray = muArray;//不崩溃
     BPLog(@"%@,%@",muArray,_muArray);
     [_muArray removeAllObjects];
     
     //总结：我知道我的迷惑点在哪里了：属性或者实例变量表明它只是一个指针，不是真正的对象，除非它指向了一个真正的对象，才能对对象起到作用；属性的修饰词只关系到对象的setter getter方法，其他方法不会被修饰词影响到。
     */
    
    self.muArray = [[NSMutableArray alloc] init];
    //[self.muArray removeAllObjects];//崩溃
}

- (void)dealloc {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
     //非Objc对象内存的释放，如CFRelease(...)
}

@end
