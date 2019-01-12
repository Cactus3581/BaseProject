//
//  BPBlockViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/13.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPBlockViewController.h"
#import "BPBlockModel.h"

typedef void(^BPBlockBlk)(NSString *);//重新起个名字
BPBlockBlk globalBlk; // 定义一个全局的block

NSString *global_string_var = @"global_string_var";// 全局变量
static NSString *global_static_string_var = @"global_static_string_var";// 全局静态变量

@interface BPBlockViewController ()
@property(nonatomic,copy) BPBlockBlk blk; // 用于循环引用例子的
@property (nonatomic,copy) NSString *property_string_var;// 属性变量（堆区）
@end

@implementation BPBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self blockDeclarationAndDefinition];//Block的声明和定义
            }
                break;
                
            case 1:{
                [self handle__block];//Block内存区域及__block（内存区域说明符）
            }
                break;
                
            case 2:{
                [self handleAsyncLife];// 与异步使用的生命周期的例子
            }
                break;
                
            case 3:{
                [self handleCycle];//循环引用例子
            }
                break;
                
            case 4:{
                [self handle_systembBlock];//系统API与Block的结合使用
            }
                break;
                
            case 5:{
                [self challenge];//几道面试题
            }
                break;
                
            case 6:{
                [self block_strongSelf];//Heap-Stack Dance 替代 Weak-Strong Dance
            }
                break;
        }
    }
}


#pragma mark - Block的声明和定义
- (void)blockDeclarationAndDefinition {
    
    // block 的声明： 返回值(^blockName)(参数)
    NSString *(^block1)(NSArray *array,NSNumber *result);
    
    void(^block2)(NSArray *array,NSNumber *result);
    
    void(^block3)(void);
    
    // block 的定义： ^返回值(参数) {}; 注意：返回值和参数可以省略
    
    ^ NSString *(NSArray *array,NSNumber *result) {
        return array[[result integerValue]];
    };
    
    ^ (NSArray *a,NSNumber *result) {
    };
    
    ^ NSString * {
        return nil;
    };
    
    ^ {
    };
    
    //完整声明和定义
    NSString *(^block4)(NSArray *array,NSNumber *result) = ^NSString *(NSArray *array,NSNumber *result) {
        return array[[result integerValue]];
    };
    
    block4(@[@"block4"],@0);//本质：使用函数指针调用函数
    
    //最简声明和定义
    void(^block5)(void) = ^ {
    };
}

#pragma mark - Block内存区域及__block（内存区域说明符）

// 当指针在非栈区（全局、静态、属性(指针在堆区）、自定义对象的属性）：当被block捕获的时候，block的指针还是同一个，所以block里外操作的指针都是同一个，因为操作的都是同一个指针，所以不会产生歧义，不会引起编译错误；
// 当指针在栈区，且不被__block修饰：当被block捕获的时候，block将栈区的指针copy到了堆区，所以block里外操作的指针不同，操作这个指针，会产生歧义，所以引起编译错误；
// 当指针在栈区，且被__block修饰：当被__block修饰时，由__block修饰的变量变成了一个__Block_byref_val_0结构体类型的实例，当变量被block捕获的时候，block将栈区的指针copy到了堆区，当访问栈上的指针的时候，其实是通过__forwarding访问堆上的变量，当访问堆区的指针的时候，会通过__forwarding来访问自身，因为操作的都是堆区的指针，所以不会引起编译错误；
// 要区别"指针重指向"和"对象的更改"：如果不改变指针的重指向，无论是否用__block修饰，操作的性质是”对象的更改“，就不会引起编译错误，比如可变数组的addObject操作

/*
 捕获及捕获时机：block块内使用了外部的变量，则将这些变量保存到自己的结构体里；如果变量开始在栈区，那么捕获后，会有两个变量，一个在栈区，一个在堆区；
 __forwarding：当指针变量被__block修饰后，变成了一个__Block_byref_val_0结构体的类型，结构体里带有__forwarding的变量，以后不管访问哪个区的指针，都是通过__forwarding来访问堆区的变量；
 
 block复制到堆区时：当变量在栈区，变量会copy到堆区；当变量在堆区，变量引用+1；当变量在全局区，什么也不做；
 
 block的划分：根据截获的数据的内存来划分：
 全局block：1.在记述全局变量的地方有声明block时；2.block内部不使用截获的局部变量时（非全局，非static），如果不截获方法内的局部变量（非全局，非static），那么就在全局区，配置在全局的block，在变量作用域外，也可以安全使用；
 栈block：除此之外的Block语法生成的Blcok都是栈block；
 堆block：但是ARC下，会自动将Block复制到堆，复制到堆区的主要目的就是保存block的状态，延长其生命周期。因为block如果在栈上的话，其所属的变量作用域结束，该block就被释放掉，block中的__block变量也同时被释放掉。为了解决栈块在其变量作用域结束之后被释放掉的问题，我们就需要把block复制到堆中。
 */

/*
 堆：head
 栈：stack
 数据区（全局区）：.data区
 */
- (void)handle__block {
    [self handleLocalStackVar];
    [self handleNoStackVar];
    [self handleArray];
}

// 局部变量
- (void)handleLocalStackVar {
    // 局部变量
    NSString *local_string_var = @"local_string_var";
    // 带__block的局部变量
    __block NSString *__block_string_var = @"__block_string_var";

    BPLog(@"1. 定义block之前：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_string_var,local_string_var,&local_string_var);
    BPLog(@"1. 定义block之前：带__block的局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",__block_string_var,__block_string_var,&__block_string_var);
    
    NSString *(^block)(NSArray *array,NSNumber *result) = ^NSString *(NSArray *array,NSNumber *result) {
        BPLog(@"4. 在block里面，修改之前：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_string_var,local_string_var,&local_string_var);
        BPLog(@"4. 在block里面，修改之前：带__block的局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",__block_string_var,__block_string_var,&__block_string_var);
        
        // 局部变量
        //local_string_var = @"local_string_var_InBlock";//编译报错
        __block_string_var = @"__block_string_var_InBlock";
        
        BPLog(@"5. 在block里面，修改之后：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_string_var,local_string_var,&local_string_var);
        BPLog(@"5. 在block里面，修改之后：带__block的局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",__block_string_var,__block_string_var,&__block_string_var);
        
        return array[[result integerValue]];
    };
    BPLog(@"2. 定义block之后，修改之前：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_string_var,local_string_var,&local_string_var);
    BPLog(@"2. 定义block之后，修改之前：带__block的局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",__block_string_var,__block_string_var,&__block_string_var);
    
    local_string_var = @"local_string_var_out";
    __block_string_var = @"__block_string_var_out";

    BPLog(@"3. 定义block之后，修改之后：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_string_var,local_string_var,&local_string_var);
    BPLog(@"3. 定义block之后，修改之后：带__block的局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",__block_string_var,__block_string_var,&__block_string_var);
    
    block(@[@"i am block"],@0);

    BPLog(@"6. 定义block之后，block调用后修改之后：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_string_var,local_string_var,&local_string_var);
    BPLog(@"6. 定义block之后，block调用后修改之后：带__block的局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",__block_string_var,__block_string_var,&__block_string_var);
}

// 指针在非栈区，以下结果：指针所在的地址没变，指针存储的地址变变了，即指向的对象变了
- (void)handleNoStackVar {
    // 全局静态变量
    global_static_string_var = @"global_static_string_var";
    // 全局变量
    global_string_var = @"global_string_var";
    // 局部静态变量
    static NSString *local_static_string_var = @"static_string_var";
    //属性
    _property_string_var = @"_property_string_var";

    BPLog(@"在block里面，修改之前：全局静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_static_string_var,global_static_string_var,&global_static_string_var);
    BPLog(@"在block里面，修改之前：全局变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_string_var,global_string_var,&global_string_var);
    BPLog(@"在block里面，修改之前：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_static_string_var,local_static_string_var,&local_static_string_var);
    BPLog(@"在block里面，修改之前：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",_property_string_var,_property_string_var,&_property_string_var);
    
    NSString *(^block)(NSArray *array,NSNumber *result) = ^NSString *(NSArray *array,NSNumber *result) {
        BPLog(@"在block里面，修改之前：全局静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_static_string_var,global_static_string_var,&global_static_string_var);
        BPLog(@"在block里面，修改之前：全局变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_string_var,global_string_var,&global_string_var);
        BPLog(@"在block里面，修改之前：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_static_string_var,local_static_string_var,&local_static_string_var);
        BPLog(@"在block里面，修改之前：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",_property_string_var,_property_string_var,&_property_string_var);
        // 全局静态变量
        global_static_string_var = @"global_static_string_var_InBlock";
        // 全局变量
        global_string_var = @"global_string_var_InBlock";
        // 局部静态变量
        local_static_string_var = @"static_string_var_InBlock";
        //属性
        _property_string_var = @"_property_string_var_InBlock";
        
        BPLog(@"在block里面，修改之后：全局静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_static_string_var,global_static_string_var,&global_static_string_var);
        BPLog(@"在block里面，修改之后：全局变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_string_var,global_string_var,&global_string_var);
        BPLog(@"在block里面，修改之后：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_static_string_var,local_static_string_var,&local_static_string_var);
        BPLog(@"在block里面，修改之后：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",_property_string_var,_property_string_var,&_property_string_var);
        
        return array[[result integerValue]];
    };
    BPLog(@"定义block之后，修改之前：全局静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_static_string_var,global_static_string_var,&global_static_string_var);
    BPLog(@"定义block之后，修改之前：全局变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_string_var,global_string_var,&global_string_var);
    BPLog(@"定义block之后，修改之前：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_static_string_var,local_static_string_var,&local_static_string_var);
    BPLog(@"定义block之后，修改之前：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",_property_string_var,_property_string_var,&_property_string_var);
    
    global_string_var = @"global_string_var_out";
    global_static_string_var = @"global_static_string_var_out";
    local_static_string_var = @"static_string_var_out";
    _property_string_var = @"_property_string_var_out";

    BPLog(@"定义block之后，修改之后：全局静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_static_string_var,global_static_string_var,&global_static_string_var);
    BPLog(@"定义block之后，修改之后：全局变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_string_var,global_string_var,&global_string_var);
    BPLog(@"定义block之后，修改之后：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_static_string_var,local_static_string_var,&local_static_string_var);
    BPLog(@"定义block之后，修改之后：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",_property_string_var,_property_string_var,&_property_string_var);
    
    block(@[@"i am block"],@0);
    
    BPLog(@"定义block之后，block调用后修改之后：全局静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_static_string_var,global_static_string_var,&global_static_string_var);
    BPLog(@"定义block之后，block调用后修改之后：全局变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",global_string_var,global_string_var,&global_string_var);
    BPLog(@"定义block之后，block调用后修改之后：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",local_static_string_var,local_static_string_var,&local_static_string_var);
    BPLog(@"定义block之后，block调用后修改之后：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",_property_string_var,_property_string_var,&_property_string_var);
}

// 数组
- (void)handleArray {
    // 带__block的数组
    NSMutableArray *muArray = @[@(1)].mutableCopy;
    __block NSMutableArray *blockMuArray = @[@(1)].mutableCopy;
    BPLog(@"1. 定义block之前：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",muArray,muArray,&muArray);
    BPLog(@"1. 定义block之前：局部变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",blockMuArray,blockMuArray,&blockMuArray);

    NSString *(^block)(NSArray *array,NSNumber *result) = ^NSString *(NSArray *array,NSNumber *result) {
        BPLog(@"4. 在block里面，修改之前：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",muArray,muArray,&muArray);
        BPLog(@"4. 在block里面，修改之前：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",blockMuArray,blockMuArray,&blockMuArray);

        [muArray addObject:@(3)];
        [blockMuArray addObject:@(3)];
        //muArray = @[].mutableCopy;//编译报错
        //blockMuArray = @[].mutableCopy;//编译成功
        
        BPLog(@"5. 在block里面，修改之后：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",muArray,muArray,&muArray);
        BPLog(@"5. 在block里面，修改之后：局部静态变量 = %@;对象的地址 = %p;  指针的地址 = %p\n",blockMuArray,blockMuArray,&blockMuArray);
        return array[[result integerValue]];
    };
    BPLog(@"2. 定义block之后，修改之前：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",muArray,muArray,&muArray);
    BPLog(@"2. 定义block之后，修改之前：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",blockMuArray,blockMuArray,&muArray);

    [muArray addObject:@(2)];
    [blockMuArray addObject:@(2)];
    
    BPLog(@"3. 定义block之后，修改之后：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",muArray,muArray,&muArray);
    BPLog(@"3. 定义block之后，修改之后：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",blockMuArray,blockMuArray,&blockMuArray);
    
    block(muArray,@0);
    
    BPLog(@"6. 定义block之后，block调用后修改之后：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",muArray,muArray,&muArray);
    BPLog(@"6. 定义block之后，block调用后修改之后：属性 = %@;对象的地址 = %p;  指针的地址 = %p\n",blockMuArray,blockMuArray,&blockMuArray);
}

#pragma mark - 与异步使用的生命周期的例子
- (void)handleAsyncLife {
    __weak typeof (self) weakSelf = self;
    BPBlockModel *model1 = [[BPBlockModel alloc] init];
    id __weak weakModel1 = model1;
    model1.block = ^(NSDictionary *responseObject) {
        if (self) {
            [self test]; // 不会循环引用, 但是有可能造成self的内存泄露,因为block被dispatch_after持有了，block持有了self，如果block不释放，那么self就不会释放。所以最好加上weakaSelf。
        }
        BPLog(@"%@",weakModel1);//如果直接用model会循环引用
    };
    

    /*
     不会循环引用，但是可能会发生内存泄露：
     在BPBlockModel内部，dispatch_after持有block，block持有self和model2；
     在block执行完前：会捕获self和model2变量，使用copy函数将它们复制到block的结构体内，强持有self和model2；
     执行完之后：block释放，block同时会执行dispose函数，释放self和model2
     */
    BPBlockModel *model2 = [[BPBlockModel alloc] init];
    [model2 handleBlock:^{
        if (self) {
            [self test]; // 不会循环引用
        }
        BPLog(@"%@",model2);// 不会循环引用
    }];
    
    // 同上
    BPBlockModel *model3 = [[BPBlockModel alloc] init];
    BPBlockModel * __weak weakModel3 = model3;
    [model3 handlePropertyBlock:^(NSDictionary *responseObject) {
        if (self) {
            [self test];// 不会循环引用，但是可能会造成内存泄露
        }
        BPLog(@"%@",weakModel3);// 如果直接用model会循环引用
    }];
}

#pragma mark - 循环引用例子：比如控制器在使用一个Block，这个block又在使用控制器就会出现循环引用
- (void)handleCycle {
    __weak typeof (self) weakSelf = self;
    /*
     例子1：经典例子
     代码解释：定义一个和self相同数据类型的weakSelf ，并赋值为self，在block中使用。
     typeof 是一个一元运算，放在一个运算数之前，运算数可以是任意类型。
     可以理解为：我们根据typeof（）括号里面的变量，自动识别变量类型并返回该类型。
     typeof、__typeof__、__typeof的区别：其实它们是没有区别的，只是它们只是针对不同的 c语言编译版本 有所不同的。
     */
    
    /* 也可以使用如下：
    BPBlockViewController * __weak weakSelf = self;
    id __weak weakSelf = self;
    */
    
    
    self.blk = ^(NSString *str) {
        //不管是通过self.property_string_var还是_property_string_var，或是函数调用[self doSomething]，只要 block 中用到了对象的属性或者函数，block就会持有该对象而不是该对象中的某个属性或者函数。
        [weakSelf test];
        BPLog(@"%@",weakSelf.property_string_var);
    };
    self.blk(@"passValueBlock");
    
    //例子2:使用多种方法破解循环引用
    BPBlockModel *model1 = [[BPBlockModel alloc] init];
    id __weak weakModel1 = model1;// 第一种方法：使用__weak
    [model1 handlePropertyBlock:^(NSDictionary *responseObject) {
        BPLog(@"%@",weakModel1);// 如果直接用model会循环引用
    }];
    
    BPBlockModel *model2 = [[BPBlockModel alloc] init];
    __block id blockModel2 = model2;
    [model2 handlePropertyBlock:^(NSDictionary *responseObject) {
        BPLog(@"%@",blockModel2);
        blockModel2 = nil;// 第二种方法：将blockModel2置为nil
    }];
    
    BPBlockModel *model3 = [[BPBlockModel alloc] init];
    [model3 resolvePropertyBlock:^(NSDictionary *responseObject) {
        BPLog(@"%@",model3);// 第三种方法：将block置为nil
    }];
    
    BPBlockModel *model4 = [[BPBlockModel alloc] init];
    id __unsafe_unretained unretainedModel4 = model4;// 第四种方法：使用__unsafe_unretained
    [model4 handlePropertyBlock:^(NSDictionary *responseObject) {
        BPLog(@"%@",unretainedModel4);
    }];
    
    BPBlockModel *model5 = [[BPBlockModel alloc] init];
    weakify(model5);
    [model5 handlePropertyBlock:^(NSDictionary *responseObject) {
        strongify(model5);//在block内部声明一个__strong修饰的变量来防止变量在block执行过程中被释放。
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //执行到这的时候model5可能已经销毁了
            if (model5) {
                BPLog(@"%@",model5);
            }
        });
    }];
    
    /* 例子3: MRC下如何解决循环引用。使用__weak打破循环的方法只在ARC下才有效，在MRC下应该使用__block：__block typeof(self) weakSelf = self;
     这个__block在MRC时代有两个作用：说明变量可改；说明指针不会被Block所retain。
     */
}

#pragma mark - 系统API与Block的结合使用
//  系统方法一般不会引起循环引用，但是会持有block。比如GCD，AFN，UIView动画，一般的类方法，系统的block在结束的时候会释放引用对象；
- (void)handle_systembBlock {
    __weak typeof(self)weakSelf = self;
    /*GCD不需要
     因为将block作为参数传给dispatch_async时，系统会将block拷贝到堆上，而且block会持有block中用到的对象，因为dispatch_async并不知道block中对象会在什么时候被释放，为了确保系统调度执行block中的任务时其对象没有被意外释放掉，dispatch_async必须自己retain一次对象（即self），任务完成后再release对象（即self）。但这里使用__weak，使dispatch_async没有增加self的引用计数，这使得在系统在调度执行block之前，self可能已被销毁，但系统并不知道这个情况，导致block执行时访问已经被释放的self，而达不到预期的结果。
     */
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self test];//执行完释放
    });
    
    //当动画结束时，UIView 会结束持有这个 block，block 对象就会释放掉，从而 block 会释放掉对于 self 的持有。整个内存引用关系被解除。
    [UIView animateWithDuration:0.2 animations:^{
        [self test];//执行完释放
    }];
}

- (void)block_strongSelf {
    //利用了self 做参数传进 block 不会被 Block 捕获：
    __autoreleasing BPBlockModel *model = [BPBlockModel new];
    [model foo];
}

#pragma mark - 面试题
- (void)challenge {
//    [self challenge1];
    [self challenge2];
}

- (void)challenge1 {
    //捕获的值！，不是指针变量！
    static NSUInteger a = 1;
    NSInteger b = 2;
    __block NSInteger c = 3;

    NSInteger d = ^(NSInteger a) {
        //b = 5; // 不能重指向值，但是可以进行加减运算
        return ++a;
    }
    (b);//d=3
    NSInteger (^e)(NSInteger) = ^(NSInteger e) {
        NSInteger f = a + b + c + d + e; //错误2+3+4+3+2 //正确2+2+4+3+2 关键在于b
        a+=d;//5 = 2+3
        c++;//5 = 4+1
        e+=c;// 7 = 2+5；
        return f;
    };
    
    a++;//2
    b++;//3
    c++;//4
    NSInteger g = e(a);
    BPLog(@"%ld,%ld,%ld,%ld,%ld",a,b,c,d,g);//5,3,5,3,13
}

- (void)challenge2 {
    int a = 10;
    __block int b = 20;
    int (^testBlock)(int) = ^(int c){
        int  d = a + b + c;
        BPLog(@"d = %d,a = %d,b = %d,c = %d",d,a,b,c);// d = 80,a = 10,b = 40,c = 30,
        return d;
    };
    a = 20;  //修改值不会影响testBlock内的计算结果
    b = 40;  //修改值会影响testBlock内的计算结果。
    BPLog(@"d = %d",testBlock(30));//d = 80
}

- (void)test {
    BPLog(@"block");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    BPLog(@"vc：dealloc");
}

@end
