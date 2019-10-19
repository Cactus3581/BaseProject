//
//  KSCPointViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/9/20.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSCPointViewController.h"

@interface KSCPointViewController ()

@end


//函数的参数会进行拷贝。当函数是值时，会进行值拷贝，生成一个新的值，跟原来的值没有任何关系；当函数是指针时，会进行指针拷贝，生成一个新的指针，指向原来的对象，但是指针跟原来的指针没有任何关系；
// 因为基本数据类型占内存很小，所以当它们作为参数时，一般可以使用值传递；但是数组只能指针传递，如果是值传递会对大块内存进行拷贝

// &取一个变量的地址；* 定义一个变量，或者取一个变量所指向的另一个变量的值

@implementation KSCPointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self point13];
    
    int a[] = {1,2,3};
    int tmp[] = {4,5};

    // 将 tmp 中的数组拷贝回 a[start...end]
    memcpy(a + 0, tmp, (2) * sizeof(int));
    BPPrintfPointIntArray(a,3);
}

#pragma mark - C指针
// 指针是一个变量，其值为另一个变量的地址
// 声明和定义指针：每一个变量都有一个内存地址，每一个内存地址都可以使用&取地址符获取地址
- (void)point12 {

    // 实际变量的声明
    int var = 1;
    
    // 使用 *号 定义一个变量是指针变量，并把变量的地址赋值给指针，在指针变量中存储了 var 的地址
    int *p;
    
    // 置为空指针
    p = NULL;
    
    p = &var;
    
    printf("变量地址: %p\n", &var);
    
    printf("在指针变量中存储的地址: %p\n", p);
    
    printf("使用指针访问值: %d\n", *p);
}

#pragma mark - C 指针的算术运算
// C 指针是一个用数值表示的地址。因此可以对指针进行四种算术运算：++、--、+、-。

- (void)point13 {
    
    // 数组可以看成一个指针
    int  var[] = {10, 100, 200};
    
    printf("value = %d\n",*(var+1)); // 100
    
    int  i, *p;
    
    // 使用指针代替数组
    p = var;
    
    for ( i = 0; i < 3; i++) {
        
        printf("存储地址：var[%d] = %x\n", i, p); // %x 为16进制整数
        printf("存储值：var[%d] = %d\n", i, *p);
        
        // ptr 每增加一次，移动指针到下一个内存位置
        p++;
    }
}

#pragma mark - 指针数组
- (void)point14 {
    
    
    int var[] = {10, 100, 200};
    
    // ptr数组中的每个元素，都是一个指向 int 值的指针。该数组称为指针数组

    //首先从p 处开始,先与[]结合,因为其优先级比*高,所以p是一个数组,然后再与*结合,说明数组里的元素是指针类型,然后再与int 结合,说明指针所指向的内容的类型是整型的,所以 p 是一个由返回整型数据的指针所组成的数组

    int *p[3];
    
    for (int i = 0; i < 3; i++) {
        //赋值为整数的地址
        p[i] = &var[i];
    }
    
    for (int i = 0; i < 3; i++) {
        printf("Value of var[%d] = %d\n", i, *p[i] );
    }
    
    // 使用指向字符的指针数组来存储一个字符串列表
    const char *array[] = {
        "a",
        "b",
        "c",
    };
    
    for (int i = 0; i < 3; i++) {
        printf("%d = %s\n", i, array[i]);
    }
}

#pragma mark - C 指向指针的指针：二级指针
// 第一个指针存储实际值的地址，第二个指存储第一个指针的地址
- (void)point15 {
    
    int  var;
    int  *ptr;
    
    //在变量名前放置两个星号，声明一个二级指针
    int  **pptr;
    
    var = 3000;
    
    // 获取 var 的地址
    ptr = &var;
    
    // 使用运算符 & 获取 ptr 的地址
    pptr = &ptr;
    
    // 使用 pptr 获取值
    printf("Value of var = %d\n", var);
    printf("Value available at *ptr = %d\n", *ptr);
    
    //使用两个星号运算符访问这个值
    printf("Value available at **pptr = %d\n", **pptr);
}

#pragma mark - C 传递指针给函数
// 可以将函数外部的地址传递到函数内部，使得在函数内部可以操作函数外部的数据
- (void)point16 {
    
    int var = 0;
    int *p = &var;

    printf("a的地址：%p,%p\n",&var,p);

    getVar(&var);
    // 输出实际值
    printf("var: %d\n", var);
    
    int a[3] = {1, 2, 3};
    // a是一个指向数组的指针，更确切的说：a是一个指向数组的第一个元素的指针，也叫做头指针
    getAverage(a, 3);
    
    // 跟上面含义是一样的
    int *ap = a;
    getAverage(ap, 3);
}


//声明函数参数为指针类型
void getVar(int *var) {
    printf("地址：%p\n",var);
    *var = 1;
}

void getAverage(int *arr, int length) {
    for (int i = 0; i < length; ++i) {
        arr[i] = length-1;
    }
}

#pragma mark - C 从函数返回指针
- (void)point17 {
    
    // 使用指针表示数组，即第一个数组元素的地址
    int *p;
    
    p = getRandom();
    
    for (int i = 0; i < 10; i++) {
        printf("*(p + [%d]) : %d\n", i, *(p + i) );
    }
}

int * getRandom() {
    
    // C 语言不支持在调用函数时返回局部变量的地址，除非定义局部变量为 static 变量。
    static int r[10];
    
    /* 设置种子 */
    srand((unsigned)time(NULL));
    
    for (int i = 0; i < 10; ++i) {
        r[i] = rand();
        printf("%d\n", r[i]);
    }
    return r;
}

#pragma mark - C 数组

- (void)point {

    // 定义数组时，返回头指针，指向第一个数组元素
    // 显式地指定数组大小
    int a[] = {11,8,3,9,7,1,2,5};
    
    // 不能这样写，只有字符串可以这么写
    // int *a = {1};
    
    // 不能这样写，因为a也是个指针
    // int *a2 = &a;
    int *p = a;
    
    printf("%d",*p);
    printf("%d",a[0]);

    // sizeof(a)来获取数组的长度，不要对指针使用 sizeof 操作符，必须在函数方法中传入数组的长度
    int b[] = {11,8,3,9,7,1,2,5};

    testArray(p,b);
}

// int *a, int b[]含义都是一样的，本质上都是传递的数组指针，不能在函数内部使用sizeof获取数组长度，所以必须显式增加一个数组长度参数
void testArray(int *a, int b[]) {
    a[0] = 1;
    b[0] = 1;
}

#pragma mark - OC 对象的二级指针
// 二级指针字符串
- (void)ocObjectPoint {
    
    NSString *str1 = @"str1";
    NSString *str2 = @"str2";
    
//    NSString *__autoreleasing str2 = @"str2";
//    NSString * __autoreleasing *str3 = &str2;

    BPLog(@"指针存储的对象地址 1:%p, 指针的地址：%p",str1,&str1);
    BPLog(@"指针存储的对象地址 1:%p, 指针的地址：%p",str2,&str2);

    [self testStr:str1 b:&str2];

    BPLog(@"指针存储的对象地址 4:%p, 指针的地址：%p",str1,&str1);
    BPLog(@"指针存储的对象地址 4:%p, 指针的地址：%p",str2,&str2);
}

- (void)testStr:(NSString *)str1 b:(NSString **)str2 {
    
    // 指针本身复制了
    BPLog(@"指针存储的对象地址 2:%p, 指针的地址：%p",str1,&str1);
    BPLog(@"指针存储的对象地址 2:%p, 指针的地址：%p",*str2,str2);
    
    str1 = @"a";
    *str2 = @"b";
    
    BPLog(@"指针存储的对象地址 3:%p, 指针的地址：%p",str1,&str1);
    BPLog(@"指针存储的对象地址 3:%p, 指针的地址：%p",*str2,str2);
}

#pragma mark - OC 基本数据类型的指针

// 二级指针基本数据类型
- (void)ocBasePoint {
    int a = 1;
    int b = 2;
    [self testInt:a b:&b];
    BPLog(@"quickSort1 = %d,%d",a,b);
}

- (void)testInt:(int)a b:(int *)b {
    a = 5;
    *b = 6;
}

#pragma mark - C语言创建字符串的几种方法

- (void)string {
    // 以字符串数组的形式初始化
    char s[] = "array"; // 栈变量
    char s6[] = {'a','b',0};
    
    s[0] = 'b';
    printf("%s\n",s);
    
    // 以字符串指针的形式初始化
    char *s1 = "pointer";// 常量
    printf("%s,%c,%c\n",s1,*s1,*(s1+2));  //pointer,p,i
    
    // 字符串初始化，没有内容
    char *s2 = (char *)malloc(sizeof(char));// 堆变量
    s2[0] = 'a';
    
    // 字符初始化
    char p = 'p';
}

@end
