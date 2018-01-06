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
#import "BPTestViewController.h"
#import "BPWeakView.h"
#import "NSTimer+BPAdd.h"
#import "NSTimer+BPUnRetain.h"

@interface BPMemoryViewController ()

@end

@interface BPMemoryViewController()<BPTestViewControllerDelegate>

@property(nonatomic,weak) UIButton *weakButton;
@property(nonatomic,strong) UIButton *strongButton;

@property(nonatomic,weak) NSString *weakStr;
@property(nonatomic,strong) NSString *strongStr;

@property(nonatomic,weak) BPTestViewController *weakVc;
@property(nonatomic,strong) BPTestViewController *strongVc;

@property(nonatomic,strong) BPWeakView *strongView;
@property(nonatomic,weak) BPWeakView *zoomAssignView;

@end

static int b = 10;

int age = 24;//全局初始化区（数据区）
NSString *name;//全局未初始化区（BSS区）
static NSString *sName = @"Dely";//全局（静态初始化）区

@implementation BPMemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self head_stack];
    //    [self testPoint];
    //    [self testZombie];
    
    //    [self testWeak];
    //    [self testBlock];
    
    //    [self testDelegate];
    //    [self testTimer];
    //    [self testSystem];
}

/*
 本文的堆和栈是操作系统的内存中堆和栈，不是数据结构中的堆和栈。
 参数和局部变量在栈
 */
- (void)head_stack {
    int tmpAge;//栈
    NSString *number = @"123456"; //123456在常量区，number在栈上。文字常量区 存放常量字符串，程序结束后由系统释放
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];//分配而来的8字节的区域就在堆中，array在栈中，指向堆区的地址
    NSInteger total = [self getTotalNumber:1 number2:1];
    
    
    char s[] = "abc"; //栈
    char *p2; //栈
    char *p3 = "123456";  //123456\0在常量区，p3在栈上。
    static int c = 0; //全局（静态）初始化区
    char * p1 = (char *)malloc(10);   //分配得来的10 字节的区域就在堆区。
    p2 = (char *)malloc(20);  //分配得来的 20字节的区域就在堆区。
    strcpy(p1, "123456");   //123456\0放在常量区，编译器可能会将它与p3所指向的"123456"优化成一块。
}

- (NSInteger)getTotalNumber:(NSInteger)number1 number2:(NSInteger)number2{
    return number1 + number2;//number1和number2 栈区
}

// 系统方法一般不会引起循环引用
- (void)testSystem {
    /*
     可以不用weak的，比如GCD，AFN，UIView动画，一般的类方法
     原因：
     1. 其实只要抓住循环引用的本质，就不难理解。所谓循环引用，是因为当前控制器在引用着block，而block又引用着self即当前控制器，这样就造成了循环引用。系统的block或者AFN等block的调用并不在当前控制器中调用，那么这个self就不代表当前控制器，那自然也就没有循环引用的问题。以上引用均指强引用；
     2. afn可以看一下源码 在block结束的时候置空了，执行完手动释放block，不就不会循环引用， 理论上还是会有循环引用的警告 但是afn也做了处理 把警告消除了；
     3. 因为系统的block在结束的时候会释放引用对象，有兴趣可以看，GCD源码；
     4. UIView的动画block不会造成循环引用的原因就是，这是个类方法，当前控制器不可能强引用一个类，所以循环无法形成；
     */
}


- (void)testPoint {
    self.strongStr = @"abc";
    //self.strongStr = nil; //将指针置为nil，没有其他指针再指向字符串了，所以释放了；
    _strongStr = nil;
    BPLog(@"%ld",_strongStr.length);
}

- (void)testZombie {
    NSMutableArray *array = @[@"1"].mutableCopy;
    id obj = [array objectAtIndex:0];
    [array removeObjectAtIndex:0];
    BPLog(@"%@",obj);
    BPLog(@"%@",array);
    BPLog(@"%ld",BPRetainCount(obj));
    
    __unsafe_unretained NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    [arrayM addObject:@"1"];
    [arrayM addObject:@"2"];
    BPLog(@"%@",arrayM);
}

/*
 1. 对象：什么是面向对象，或者什么是对象语言：oc是对象语言，在oc的世界里一切皆对象；如果想使用这门语言就必须要创建对象；
 2. ARC机制和内存管理：如上面所说，我们编程就要创建对象，但是不能只创建对象，不释放对象吧，这就会造成内存泄露。所以这就用到了ARC和内存管理的知识，ARC不是垃圾回收机制，MRC才是，ARC只是一个特性，编译器帮我们在MRC的基础上加了retain release，autorelease的代码，所以ARC是编译时的特性，不是垃圾回收机制，更不是运行时的特性。
 3. 对象与指针：一般来说，我们在编程中创建的都是对象，我们使用变量来指向该对象，这个变量就是指针；换句话说，我们是使用指针来操作对象，并不是直接拿到对象来用，当然，我们使用指针，你也可以理解成是直接操作的对象，因为指针里保存着对象的地址；
 4. 修饰符：
 1> 在OC中，如果我们创建了对象，但是没有声明一个指针去指向该对象，该对象就会刚创建完就释放。说明：在ARC中内存的管理是由一个叫自动引用计数的东西，当对象的retainCount的值>0时，才不会被释放，若等于0就会被释放；那什么情况下指向该对象计数就会+1，当用strong修饰指针时，才会+1；让对象不被销毁，这就用到了下面的修饰符。
  都有哪些修饰符呢：strong，weak，assign，__unsafe_unretained
 2> strong
 隐式修饰：我们一般在方法内即函数体内创建的对象，用指针指向该对象，该对象的retainCount就会+1，所以该对象就不会被释放，为什么呢：因为默认的对象修饰符是strong，被strong修饰的指针，会强持有该对象；那什么时候销毁呢，在函数体结束的时候释放，因为该变量在函数栈里；
 显示修饰：在声明的属性里，如果用strong修饰，就表明在当前的声明类里，声明的类强持有该对象；一般在该类delloc的时候会销毁；
 3> weak：UIView控件会使用，因为UIView一般来说，只针对父view负责，不应当被类文件（VC）所强持有；用于修饰delegate，防止循环引用，造成内存泄露（下面具体说）；
 4> assign和__unsafe_unretained：其实是一个东西，不同的时代不同的叫法，容易造成野指针，访问僵尸对象，会造成crash，下面会具体讲；
 
 */

- (void)testWeak {
    //BPLog(@"%ld",BPRetainCount(_weakButton));// 打印被释放的对象的引用计数会crash
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = kRedColor;
    button.frame = CGRectMake(100, 100, 100, 100);
    BPLog(@"%ld",BPRetainCount(button));
    
    _weakButton = button;
    self.weakButton = button;
    _strongButton = button;
    self.strongButton = button;
    _strongButton = self.weakButton;
    
    _strongButton = nil;
    
    BPLog(@"%ld",BPRetainCount(button));
    BPLog(@"%ld",BPRetainCount(_weakButton));
    BPLog(@"%ld",BPRetainCount(_strongButton));
    BPLog(@"%ld",BPRetainCount(button));
}

/*
 翻译过来，闭包是一个函数（或指向函数的指针），再加上该函数执行的外部的上下文变量（有时候也称作自由变量）。
 在 Objective-C 语言中，一共有 3 种类型的 block：
 _NSConcreteGlobalBlock 全局的静态 block，不会访问任何外部变量。
 _NSConcreteStackBlock 保存在栈中的 block，当函数返回时会被销毁。在arc中不存在
 _NSConcreteMallocBlock 保存在堆中的 block，当引用计数为 0 时会被销毁。
 在ARC下：似乎已经没有栈上的block了，要么是全局的，要么是堆上的
 
 打破循环
 1. 使用__weak打破循环的方法只在ARC下才有效，在MRC下应该使用__block
 2.在block执行完后，将block置nil，这样也可以打破循环引用(原因 ：blcok属性是copy的，对象对block属性强持有，当将对象的属性指针置为nil后，没有其他指针指向了block属性，所以block释放了，这也是YTK在内部解决掉循环引用的方案)
 这样做的缺点是，block只会执行一次，因为block被置nil了，要再次使用的话，需要重新赋值。
 
 
 为什么blk1类型是NSGlobalBlock，而blk2类型是NSStackBlock？blk1和blk2的区别在于，blk1没有使用Block以外的任何外部变量，Block不需要建立局部变量值的快照，这使blk1与函数没有任何区别
 */
- (void)testBlock {
    
    //self持有block
    __weak typeof(self)weakSelf = self;
    self.strongView.block = ^(NSString *str) {
        //注：以下代码都会造成循环引用，因为不管是通过self.view还是_strongButton，或是函数调用[self push]，因为只要 block中用到了对象的属性或者函数，block就会持有该对象而不是该对象中的某个属性或者函数。
        
        //BPLog(@"%p",self.view);//循环引用
        //BPLog(@"%p",_strongButton);//循环引用
        //[self push];//循环引用
    };
    
    self.strongView.block(@"");
    
    
    
    //self不持有block
    BPWeakView *view = [[BPWeakView alloc] init];
    __weak  BPWeakView * weakView = view;
    //    weakify(view);
    view.block = ^(NSString *str) {
        //BPLog(@"%p",view);//导致循环引用
        //BPLog(@"%p",self.view);//不会导致循环引用，因为view强引用了block，而不是self，
        //BPLog(@"%p",weakView);//不会导致循环引用
        //strongify(view);
        
        BPWeakView *strongView = weakView;//在block中声明的引用变量strongView在函数中声明，存在于函数栈上。不存在block堆上，所以不是一个内存空间；防止在后面的使用过程中self被释放；然后在之后的block块中使用该强引用self，注意在使用前要对self进行了nil检测，因为多线程环境下在用弱引用self对强引用self赋值时，弱引用wself可能已经为nil了。
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //BPLog(@"%p",weakSelf.view);//不会循环引用，但是执行到这的时候view可能已经销毁了
            if (strongView) {
                BPLog(@"%ld",BPRetainCount(strongView));//不会导致循环引用
            } else {
                
            }
        });
    };
    view.block(@"");//函数指针指向block块，即实现块
    
    
    /*
     貌似类方法不存在循环引用？
     1. 循环引用不应该看是对象方法还是类方法，应该看引用关系；
     2. 类方法一般不会导致循环引用，因为对象一般不持有类或者说是类对象；
     3. 类对象随app生命周期，所以类不会被释放；
     */
    [BPWeakView setBlock2:^(NSString *str) {
        
    } block2:^{
        BPLog(@"%ld",BPRetainCount(self));
        BPLog(@"%@",(self.strongStr));
        
    }];
    
    [BPWeakView setBlock3:self block:^() {
        BPLog(@"%ld",BPRetainCount(self));
        BPLog(@"%@",(self.strongStr));
    }];
    
    
    
    /*
     这是调用方法:
     1.当block作为函数参数的时候，系统会自动将block迁移到堆上；
     2.block作为对象的属性我明白循环引用怎么回事，但是作为函数参数是什么样的原因？：方法和参数都是属于对象的？
     2.当block作为对象属性的时候，将block块赋值给属性，然后再调用block；
     
     下面的方法为什么会导致循环引用：
     block并不是对象的属性 / 变量，而是方法的参数 / 临时变量。这里因为block只是一个临时变量，view1并没有对其持有，所以没有造成循环引用
     
     
     */
    BPWeakView *view1 = [[BPWeakView alloc] init];
    BPLog(@"%ld",BPRetainCount(view1));
    __weak  BPWeakView * weakView1 = view1;
    [view1 setSuccess:^NSString *(NSString *str1) {
        //这是block的实现
        BPLog(@"%p",view1);//不会导致循环引用，虽然被警告了
        BPLog(@"%p",self.view);//不会导致循环引用，因为view强引用了block，而不是self，
        BPLog(@"%p",weakView1);//不会导致循环引用
        return @"block1";
    } fail:^(NSString *str2) {
        BPLog(@"%p",view1);//导致循环引用
        BPLog(@"%p",self.view);//不会导致循环引用，因为view强引用了block，而不是self，
        BPLog(@"%p",weakView1);//不会导致循环引用
    }];
    
    /*GCD不需要
     因为将block作为参数传给dispatch_async时，系统会将block拷贝到堆上，而且block会持有block中用到的对象，因为dispatch_async并不知道block中对象会在什么时候被释放，为了确保系统调度执行block中的任务时其对象没有被意外释放掉，dispatch_async必须自己retain一次对象（即self），任务完成后再release对象（即self）。但这里使用__weak，使dispatch_async没有增加self的引用计数，这使得在系统在调度执行block之前，self可能已被销毁，但系统并不知道这个情况，导致block执行时访问已经被释放的self，而达不到预期的结果。
     因为gcd执行完后会释放。
     */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self push];
        //执行完释放
    });
    
    //当动画结束时，UIView 会结束持有这个 block，block 对象就会释放掉，从而 block 会释放掉对于 self 的持有。整个内存引用关系被解除。
    [UIView animateWithDuration:0.2 animations:^{
        self.view ;
    }];
    
    //捕获变量
    NSString *str = @"a";
    //int a = 1; //在block内修改报错
    __block int a = 1;
    self.weakVc.successDataSource = ^(NSString *str) {
        str = @"b";//oc对象可以被修改：指针传值
        BPLog(@"%@",str);
        
        a = 2;//被__block修饰后：指针传值；否则值传递
        BPLog(@"%d",a);
        
        b = 11;//全局静态可以被修改：指针传值
        BPLog(@"%d",b);
    };
    self.weakVc.successDataSource(@"");
}

- (void)testDelegate {
    /*
     delegate引起循环引用的原因：
     [self.view addSubview:view1]，如果appdelegate的修饰符是strong的话：self.view 强引用view1，view1的代理是self.view，导致循环引用
     
     */
    BPWeakView *view1 = [[BPWeakView alloc] init];
    view1.frame = CGRectMake(0, 0, 100, 100);
    view1.backgroundColor = kRedColor;
    view1.delegate = self;
    [self.view addSubview:view1];
    
}

- (void)testTimer {
    //aTarget(t)：发送消息的目标，timer会强引用aTarget，直到调用invalidate方法
    
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(push) userInfo:nil repeats:YES];
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
    NSTimer *timer = [NSTimer bp_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        strongify(self);
        [self push];
        BPLog(@"----------------");
        if (i++ > 10) {
            [timer invalidate];
        }
    }];
}


- (void)push {
    
}

- (void)rightBarButtonItemClickAction:(id)sender {
    BPLog(@"%p",self.weakVc);
    [self.navigationController pushViewController:self.weakVc animated:YES];
}

- (BPWeakView *)zoomAssignView {
    if (!_zoomAssignView) {
        _zoomAssignView = [[BPWeakView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        _zoomAssignView.backgroundColor = kGreenColor;
    }
    return _zoomAssignView;
}

- (BPWeakView *)strongView {
    if (!_strongView) {
        _strongView = [[BPWeakView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
        _strongView.backgroundColor = kGreenColor;
    }
    return _strongView;
}

- (UIButton *)weakButton {
    if (!_weakButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        _weakButton = button;
        _weakButton.backgroundColor = kRedColor;
        _weakButton.frame = CGRectMake(100, 100, 100, 100);
    }
    return _weakButton;
}

- (BPTestViewController *)weakVc {
    if (!_weakVc) {
        BPTestViewController *weakVc = [[BPTestViewController alloc] init];
        weakVc.delegate = self;
        [self addChildViewController:weakVc];
        _weakVc = weakVc;
    }
    return _weakVc;
}

/*
 1. 在哪个文件写delloc，就是指的当该文件释放的时候，就会走
 2. 都说对象释放了就会走delloc，但是为什么在delloc里打印计数，还是有值？：如果他的引用计数为0的时候你也能输出的话，它真的被释放了吗？既然被释放了，它就不存在了，你还怎么输出，也就是说，引用计数为0的时候是没办法输出的；如果引用技术为0，那个对象已经不存在了，你还能输出吗？dealloc方法在最后执行，dealloc方法执行完了引用计数才是0
 3.那么dealloc方法是在什么时候执行呢？ ：dealloc方法在最后一次release后被调用,但此时实例变量（Ivars）并未释放，父类的dealloc的方法将在子类dealloc方法返回后自动调用.析构对象,并释放空间
 */

- (void)dealloc {
    BPLog(@"retain  count = %ld\n",BPRetainCount(_weakButton));
    BPLog(@"retain  count = %ld\n",BPRetainCount(self.view));
    BPLog(@"%p,%.2f",_strongButton,_strongButton.bounds.size.width);
    BPLog(@"%p",self.view);
    BPLog(@"%p",self);
    
    // ... //
    // 非Objc对象内存的释放，如CFRelease(...)
    // ... //
}


/*
 什么时候会创建autoreleasepool?
 线程启动runloop后自动生成NSAutoreleasePool接受对象,当当前runloop迭代结束时,释放该pool.
 enumerateObjectUsingBlock:,系统在这类快速遍历方法中会自动添加autoreleasepool.
 什么时候需要手动创建autoreleasepool?
 非UI框架
 大量临时变量
 辅助线程
 需要注意的是通过@autoreleasepool{ ... }创建的pool,会在block块执行结束后便销毁.
 */

/*
 那么什么时候生成该对象呢?在此之前发生了什么?
 启动app之后,动态库从start方法开始,完成动态库的加载;
 读取镜像文件,包括动态链接和可执行文件,类有了初始内存.
 进入运行时初始化,将编译阶段的数据重新存储,更新类的内存结构.
 调用所有类与分类的+load方法
 进入main方法
 某个条件触发,创建了该对象,初始化isa指针,为之分配了内存
 对象去完成自己的使命,在此过程中引用计数发生变化,变化中系统会基于TLS做出优化,并在SideTable中保存对象的引用计数和弱引用信息
 最后调用dealloc方法,析构对象,释放内存,一切又归于平静了.
 */

@end
