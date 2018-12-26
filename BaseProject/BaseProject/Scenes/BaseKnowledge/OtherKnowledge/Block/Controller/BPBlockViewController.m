//
//  BPBlockViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/13.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPBlockViewController.h"
#import "BPBlockAPI.h"

@interface BPBlockViewController ()
@property (nonatomic,copy) NSString *blockString;
@property (nonatomic,strong) BPBlockAPI *blockObj;
@property (nonatomic,weak) NSString *blockStringA;
@end

// 测试目的：分为基本数据类型和OC对象
NSInteger block_numberA = 1;
static NSInteger block_numberB = 2;

NSString *block_strA = @"block_strA";
static NSString *block_strB = @"block_strB";
typedef void (^block1)(id);

block1 blockA;

typedef void (^block)();

block blockB;
@implementation BPBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self war1];
    
    id array = [[NSMutableArray alloc] init];
    blockA = ^(id obj) {
        [array addObject:obj];
    } ;
//    [self test0_1];


    //[self previous];
//    [self captureVal];
    
//    [self setBlock];
}

// 面试题
- (void)war1 {
    static NSUInteger a = 1;
    NSInteger b = 2;
    __block NSInteger c = 3;
    
    NSInteger d = ^(NSInteger a) {
        return ++a;
    }
    (b);
    NSInteger (^e)(NSInteger) = ^(NSInteger e) {
        NSInteger f = a + b + c + d + e;
        a+=d;
        c++;
        e+=c;
        return f;
    };
    
    a++;
    b++;
    c++;
    NSInteger g = e(a);
    BPLog(@"%ld,%ld,%ld,%ld,%ld",a,b,c,d,g);//5,3,5,3,13
}

- (void)tapGRAction {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self testA1];

}
- (void)testA1 {
    blockA([[NSObject alloc] init]);
}

#pragma mark - 值传递 和 指针传递
- (void)testA {
    NSString *str = @"viewDidLoad";
    BPLog(@"1 %@;对象的地址 = %p;  指针的地址 = %p",str,str,&str);
    [self changNSString:&str];
    BPLog(@"4 %@;对象的地址 = %p;  指针的地址 = %p",str,str,&str);
}

- (void)changNSString:(NSString **)str {
    BPLog(@"2 %@;对象的地址 = %p;  指针的地址 = %p",*str,str,&str);
    *str = @"changNSString";
    BPLog(@"3 %@;对象的地址 = %p;  指针的地址 = %p",*str,str,&str);
}

#pragma mark - Block块的定义和使用
- (void)testB {
    [self testB_1];
    [self testB_2];
}

//局部变量：不用__block说明。无法修改。值传递，block内指针的地址改变了，外部的指针的地址没有改变
- (void)testB_1 {
    NSString *str1 = @"a";
    __block NSString *str2 = @"b";
    BPLog(@"1.1 %@;对象的地址 = %p;  指针的地址 = %p",str1,str1,&str1);
    BPLog(@"1.2 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    void (^block1)();
    block1 = ^{
        BPLog(@"3.1 %@;对象的地址 = %p;  指针的地址 = %p",str1,str1,&str1);
        BPLog(@"3.2 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
        str2 = @"b";
        BPLog(@"4.1 %@;对象的地址 = %p;  指针的地址 = %p",str1,str1,&str1);
        BPLog(@"4.2 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    };

    BPLog(@"2.1 %@;对象的地址 = %p;  指针的地址 = %p",str1,str1,&str1);
    BPLog(@"2.2 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    block1();
    BPLog(@"5.1 %@;对象的地址 = %p;  指针的地址 = %p",str1,str1,&str1);
    BPLog(@"5.2 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
}

//局部变量：__block说明。不修改。指针传递，block内指针的地址改变了，外部的指针的地址有改变
- (void)testB_2 {
    __block NSString *str2 = @"a";
    BPLog(@"2.1 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    //定义一个block
    void (^block1)();
    block1 = ^{
        BPLog(@"2.3 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    };
    BPLog(@"2.2 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    block1();
    BPLog(@"2.4 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
}

//局部变量：__block说明。修改。指针传递，block内指针的地址改变了，外部的指针的地址有改变
- (void)test3 {
    __block NSString *str2 = @"a";
    BPLog(@"3.1 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    //定义一个block
    void (^block1)();
    block1 = ^{
        BPLog(@"3.3 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
        str2 = @"b";
        BPLog(@"3.4 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    };
    BPLog(@"3.2 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
    block1();
    BPLog(@"3.5 %@;对象的地址 = %p;  指针的地址 = %p",str2,str2,&str2);
}

//全局变量：修改|不修改。指针传递，指针的地址没有改变,指针存放的对象的地址变了
- (void)test4 {
    BPLog(@"4.1 %@;对象的地址 = %p;  指针的地址 = %p",block_strA,block_strA,&(block_strA));
    //定义一个block
    void (^block)();
    block = ^{
        BPLog(@"4.3 %@;对象的地址 = %p;  指针的地址 = %p",block_strA,block_strA,&(block_strA));
        block_strA = @"b";
        BPLog(@"4.4 %@;对象的地址 = %p;  指针的地址 = %p",block_strA,block_strA,&(block_strA));
    };
    BPLog(@"4.2 %@;对象的地址 = %p;  指针的地址 = %p",block_strA,block_strA,&(block_strA));
    block();
    BPLog(@"4.5 %@;对象的地址 = %p;  指针的地址 = %p",block_strA,block_strA,&(block_strA));
}

//实例变量或者是属性：修改|不修改。指针传递，指针的地址没有改变,指针存放的对象的地址变了。为什么指针的地址没有改变，因为指针在堆区
- (void)test5 {
    _blockString = @"a";
    BPLog(@"5.1 %@;对象的地址 = %p;  指针的地址 = %p",_blockString,_blockString,&(_blockString));//&array不一样
    //定义一个block
    void (^block)();
    block = ^{
        BPLog(@"5.3 %@;对象的地址 = %p;  指针的地址 = %p",_blockString,_blockString,&(_blockString));
        _blockString = @"b";
        BPLog(@"5.4 %@;对象的地址 = %p;  指针的地址 = %p",_blockString,_blockString,&(_blockString));
    };
    BPLog(@"5.2 %@;对象的地址 = %p;  指针的地址 = %p",_blockString,_blockString,&(_blockString));
    block();
    BPLog(@"5.5 %@;对象的地址 = %p;  指针的地址 = %p",_blockString,_blockString,&(_blockString));
}

//自定义对象的属性
- (void)test6 {
    BPBlockAPI *obA = [[BPBlockAPI alloc] init];
    obA.str1 = @"a";
    BPLog(@"1.1 %@;对象的地址 = %p;  指针的地址 = %p",obA,obA,&obA);
//    BPLog(@"1.2 %@;对象的地址 = %p;  指针的地址 = %p",obA.str1,obA.str1,&(obA.str1));
    BPLog(@"1.2 %@;对象的地址 = %p;",obA.str1,obA.str1);
    //定义一个block
    void (^block)();
    block = ^{
        BPLog(@"3.1 %@;对象的地址 = %p;  指针的地址 = %p",obA,obA,&obA);
//        BPLog(@"3.2 %@;对象的地址 = %p;  指针的地址 = %p",obA.str1,obA.str1,&(obA.str1));
        BPLog(@"3.2 %@;对象的地址 = %p;",obA.str1,obA.str1);
        obA.str1 = @"b";
        BPLog(@"4.1 %@;对象的地址 = %p;  指针的地址 = %p",obA,obA,&obA);
//        BPLog(@"4.2 %@;对象的地址 = %p;  指针的地址 = %p",obA.str1,obA.str1,&(obA.str1));
        BPLog(@"4.2 %@;对象的地址 = %p;",obA.str1,obA.str1);
    };
    BPLog(@"2.1 %@;对象的地址 = %p;  指针的地址 = %p",obA,obA,&obA);
//    BPLog(@"2.2 %@;对象的地址 = %p;  指针的地址 = %p",obA.str1,obA.str1,&(obA.str1));
    BPLog(@"2.2 %@;对象的地址 = %p;",obA.str1,obA.str1);
    block();
    BPLog(@"5.1 %@;对象的地址 = %p;  指针的地址 = %p",obA,obA,&obA);
//    BPLog(@"5.2 %@;对象的地址 = %p;  指针的地址 = %p",obA.str1,obA.str1,&(obA.str1));
    BPLog(@"5.2 %@;对象的地址 = %p;",obA.str1,obA.str1);
}

//数组
- (void)test7 {
    NSMutableArray *array = @[].mutableCopy;
    __block NSMutableArray *array1 = @[].mutableCopy;
    BPLog(@"1.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);
    BPLog(@"1.2 %@;对象的地址 = %p;  指针的地址 = %p",array1,array1,&array1); //&array1不一样
    //定义一个block
    void (^block1)();
    block1 = ^{
//        [array addObject:@"a"];
//        [array1 addObject:@"a"];
        BPLog(@"2.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);//&array不一样
        BPLog(@"2.2 %@;对象的地址 = %p;  指针的地址 = %p",array1,array1,&array1);
        
        array1 = @[@"c"].mutableCopy;
        BPLog(@"5.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);//&array不一样
        BPLog(@"5.2 %@;对象的地址 = %p;  指针的地址 = %p",array1,array1,&array1);
    };
    
//    [array addObject:@"b"];
//    [array1 addObject:@"b"];
    BPLog(@"3.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);
    BPLog(@"3.2 %@;对象的地址 = %p;  指针的地址 = %p",array1,array1,&array1);
    
    block1();
    BPLog(@"4.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);
    BPLog(@"4.2 %@;对象的地址 = %p;  指针的地址 = %p",array1,array1,&array1);
}

- (void)test8 {
    __block NSMutableArray *array = @[].mutableCopy;
    BPLog(@"1.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);//&array不一样
    //定义一个block
    void (^block)();
    block = ^{
        BPLog(@"2.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);
        array = @[].mutableCopy;
        [array addObject:@"a"];
        BPLog(@"5.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);
    };
    
    [array addObject:@"b"];
    BPLog(@"3.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);
    
    block();
    BPLog(@"4.1 %@;对象的地址 = %p;  指针的地址 = %p",array,array,&array);
}

#pragma mark - 内存区域，作用域
- (void)test_memory_areas {
    NSMutableArray *arrayA = @[@"a"].mutableCopy;
    NSMutableArray __weak *arrayB = arrayA;
    BPLog(@"1.1 %@;对象的地址 = %p;  指针的地址 = %p",arrayA,arrayA,&(arrayA));
    BPLog(@"1.2 %@;对象的地址 = %p;  指针的地址 = %p",arrayB,arrayB,&(arrayB));

    //定义一个block
    blockB = [^{
        [arrayB addObject:@"b"];
        BPLog(@"2.1 %@;对象的地址 = %p;  指针的地址 = %p",arrayA,arrayA,&(arrayA));
        BPLog(@"2.2 %@;对象的地址 = %p;  指针的地址 = %p",arrayB,arrayB,&(arrayB));
    } copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BPLog(@"3.1 %@;对象的地址 = %p;  指针的地址 = %p",arrayA,arrayA,&(arrayA));
        BPLog(@"3.2 %@;对象的地址 = %p;  指针的地址 = %p",arrayB,arrayB,&(arrayB));
        [self test10];
    });
}

- (void)test10 {
    blockB();
}

#pragma mark - Block的声明和定义：block块其实就是函数指针
- (void)blockDeclarationAndDefinition {

    NSString *(^block1)(NSArray *array,NSNumber *result);//声明

    void(^block2)(NSArray *array,NSNumber *result);//声明

    void(^block3)(void);//声明
    
    ^NSString *(NSArray *a,NSNumber *result) { //定义
        return a[[result integerValue]];
    };
    
    ^ NSString * { //定义
        return nil;
    };
    
    ^ (NSArray *a,NSNumber *result) { //定义
    };
    
    ^ { //定义
    };
    
    //完整声明和定义：将函数指针赋值给block4；
    NSString *(^block4)(NSArray *array,NSNumber *result) = ^NSString *(NSArray *array,NSNumber *result) { //定义
        return array[[result integerValue]];
    };
    
    block4(@[@"block4"],@0);//本质：使用函数指针调用函数
    
    void(^block5)(void) = ^ { //定义
    };

}
#pragma mark - __block意义

#pragma mark - 循环引用（几个例子）

#pragma mark - 系统API与Block的结合使用
- (void)captureVal {
    /*
     block块内 使用了外部的变量，则将这些变量保存到自己的结构体里；
     允许改写的：静态变量（static修饰的）；全局变量（方法外定义的）；
     __block 修饰变量后，将变量变为自己的一部分；
     堆：head
     栈：stack
     数据区（全局区）：.data区
     block的划分：根据截获的数据的内存来划分：如果不截获方法内的局部变量（非全局，非static），那么就在全局区；如果是截获的全局变量，那block就更在全局区；
     配置在全局的block，在变量作用域外，也可以安全使用；如果在栈上的block，如果其所属的变量作用域结束，该block就会废弃；
     这就需要堆了；一般使用copy，将栈上的block复制到堆上，这样即使作用域结束，也可以继续存在；
     
     */
    static NSString *block_strC = @"block_strC";
    static NSInteger block_numberC = 3;

    NSString *block_strD = @"block_strD";
    NSInteger block_numberD = 4;

    __block NSString *block_strE = @"block_strE";
    __block NSInteger block_numberE = 5;
    
    NSMutableArray *muArray = @[@"muArray"].mutableCopy;
    
    NSString *(^block)(NSArray *array,NSNumber *result) = ^NSString *(NSArray *array,NSNumber *result) {
        block_numberA = 11;
        block_numberB = 12;

        block_numberC = 13;
        //block_numberD = 14; //编译报错
        block_numberE = 15;

        block_strA = @"block_stra_InBlock";
        block_strB = @"block_strb_InBlock";
        block_strC = @"block_strc_InBlock";
        //block_strD = @"block_strd_InBlock";//编译报错
        block_strE = @"block_stre_InBlock";

        [muArray addObject:@(1)]; //执行成功：赋值会发生编译错误，但是调用方法不会发生错误
        
        BPLog(@"%@,%@,%@,%@,%@",block_strA,block_strB,block_strC,block_strD,block_strE);
        BPLog(@"%ld,%ld,%ld,%ld,%ld",block_numberA,block_numberB,block_numberC,block_numberD,block_numberE);
        BPLog(@"%@",muArray);
        
        return array[[result integerValue]];
    };
    
    block_strA = @"block_stra_out";
    block_strB = @"block_strb_out";
    block_strC = @"block_strc_out";
    block_strD = @"block_strd_out";
    block_strE = @"block_stre_out";
    
    
    block_numberA = 21;
    block_numberB = 22;
    block_numberC = 23;
    block_numberD = 24;
    block_numberE = 25;

    block(@[@"block4"],@0);
    
    BPLog(@"%@,%@,%@,%@,%@",block_strA,block_strB,block_strC,block_strD,block_strE);
    BPLog(@"%ld,%ld,%ld,%ld,%ld",block_numberA,block_numberB,block_numberC,block_numberD,block_numberE);
    BPLog(@"%@",muArray);
    
    
    
    BPBlockAPI *blockAPI = [[BPBlockAPI alloc] init];
    
    [blockAPI handleBlock:^{
        if (self) {
            [self test];
        }else {
            
        }
    }];
}

- (void)previous {
    /*
     ARC环境下：访问外界变量的block默认存放在堆中，实际上是先放在栈区，在ARC情况下自动又拷贝到堆区，自动释放。
     
     使用copy修饰符的作用就是将block从栈区拷贝到堆区，为什么要这么做呢？我们看下Apple官方文档给出的答案：
     通过官方文档可以看出，复制到堆区的主要目的就是保存block的状态，延长其生命周期。因为block如果在栈上的话，其所属的变量作用域结束，该block就被释放掉，block中的__block变量也同时被释放掉。为了解决栈块在其变量作用域结束之后被释放掉的问题，我们就需要把block复制到堆中。
     
     
     */
    //    BPBlockAPI *block = [[BPBlockAPI alloc] init];
    //    _blockObj = block;
    //    block.block = ^(NSDictionary *responseObject) {
    //        BPLog(@"propery");
    //    };
    //
    //    [block handleBlock:^{
    //        BPLog(@"selector");
    //    }];
    
    //    [self setBlock];
    
    
    self.blockObj = [[BPBlockAPI alloc] init];
    [self.blockObj handleBlock1:^(NSDictionary *responseObject) {
        //        [blockAPI test];
        [self test];
        BPLog(@"ds");
    }];
    
    BPBlockAPI *blockAPI = [[BPBlockAPI alloc] init];
    
    //    [blockAPI handleBlock:^{
    //        if (self) {
    //            [self test];
    //        }
    //    }];
    
    //    blockAPI.block = ^(NSDictionary * responseObject) {
    //        [self test];
    //    };
    //
    //    blockAPI.block = ^(NSDictionary * responseObject) {
    ////        [blockAPI test];
    //    };
    
    
    
    //    [self initSUbViews];
}

- (void)initSUbViews {
    UIButton *backBtn = [[UIButton alloc]init];
    backBtn.frame = CGRectMake(0, 120, 44, 44);
    [backBtn setImage:[UIImage imageNamed:bp_naviItem_backImage] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)pop {
    BPBlockAPI *blockAPI = [[BPBlockAPI alloc] init];
    [blockAPI handleBlock1:^(NSDictionary *responseObject) {
        [blockAPI test];
        [self test];
    }];
}

/*
 
 因为你的block是作为参数传过来的，也就是说，在这个方法没有执行完，block是一直存在的;
 将block作为该类的属性或者成员变量，这样block的生命周期就和实例的生命周期一样了，当然这中情况下就要考虑block会不会持有对象了，可能会造成循环引用或者对象的延迟释放

 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BPLog(@"%ld",BPRetainCount(_blockObj))
}

//定义一个block，int类型的返回值，并且有两个参数。
- (void)setBlock {
    //1.最基本的用法
    int (^operation)(int,int) = ^(int a,int b){
        return  a+b;
    };
    BPLog(@"%d",operation(3,5));
    
    //2.宏定义一个block
    typedef int (^MyBlock)(int, int);
    //利用宏定义来定义变量
    MyBlock operation_1;
    //定义一个block变量来实现两个参数相加
    operation_1 = ^(int a,int b){
        return a*b;
    };
    //调用block
    BPLog(@"%d",operation_1(3,5));
    
    //3.
    int a = 10;
//    给局部变量加上__block之后就可以改变b局部变量的值,将取变量此刻运行时的值
    __block int b = 2;
    __block NSString *str1 = @"c";
    __block NSString *str2 = @"d";
    NSString *str3 = @"d";
    NSMutableArray *array = @[].mutableCopy;

    //定义一个block
    void (^block)();
    
    block = ^{
//        默认情况下，block内部不能修改外面的局部变量
//        a  =  20;
//        给局部变量加上__block关键字，这个局部变量就可以在block内部修改
        b  =  25;
        str1 = @"a";
        str2 = @"b";
        array;
        
        [array addObject:@"a"];
//        str3 = @"d";
    };
    BPLog(@"%@",array);

    block();
    BPLog(@"%d,%d,%@,%@",a,b,str1,str2);
    BPLog(@"%@",array);

    //4.static修饰
    static int base = 100;
    MyBlock operation_2 = ^ int (int a,int b){
        return ++base;
    };
    BPLog(@"%d",operation_2(1,base));
}

//循环引用例子：比如控制器在使用一个Block，这个block又在使用控制器就会出现循环引用
- (void)setcycle {
    //例子1.
        NSMutableArray *firstArray = [NSMutableArray array];
        NSMutableArray *secondArray = [NSMutableArray array];
//        [firstArray addObject:secondArray];
//        [secondArray addObject:firstArray];
    
    
    //例子2.
    //代码解释：定义一个和self相同数据类型的weakSelf ，并赋值为self，在block中使用
    __weak typeof (self) weakSelf = self;
    
    /*
     注意： typeof 括号中的值和等于后面的值是相同的类型。
     __weak typeof(self.contentView) ws = self.contentView;
     */
    
    self.passValueBlock = ^(NSString *str){
        //循环引用1
//        [self test];
        
        //解决方法:
        //[weakSelf test];
        
        //以下调用注释掉的代码同样会造成循环引用，因为不管是通过self.blockString还是_blockString，或是函数调用[self doSomething]，因为只要 block中用到了对象的属性或者函数，block就会持有该对象而不是该对象中的某个属性或者函数。
        //NSString *localString = self.blockString;//循环引用2
        //NSString *localString = _blockString;//循环引用3
        
        //解决方法
        //NSString *localString = weakSelf.blockString;

    };
//    self.passValueBlock(@"s");
    //例子3.
    //宏定义一个block
    typedef void(^blockAct)();
    //利用宏定义来定义变量
    blockAct blockAct_1;
    //定义一个block变量来实现
    blockAct_1 = ^(){
        [self test];
    };
    //调用block
    blockAct_1();
}

- (void)test {
    BPLog(@"BLOCK");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    BPLog(@"dealloc");
}

@end
