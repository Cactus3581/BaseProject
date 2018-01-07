//
//  BPAboutCopyViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/9.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "BPAboutCopyViewController.h"
#import "DataBaseModel.h"

@interface BPAboutCopyViewController ()
@property (getter=getsss,setter=setsss:,nonatomic, copy) NSMutableArray *mutableArray;
@property (nonatomic, copy) NSString *str2;
@property (nonatomic, strong) NSArray *array;



@property (nonatomic, strong) NSArray *array1;

@property (nonatomic, copy) NSArray *array2;

@property (nonatomic, strong) NSMutableArray *array3;
@property (nonatomic, copy) NSMutableArray *array4;

@end

@implementation BPAboutCopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
//    [self testStrong];
//    [self testArray];
//    [self testString];
    
    [self testmuArray_1];
//
//    [self testmuArray];
    
//    BPLog(@"%ld",self.direction);
//    BPLog(@"%ld",self.dir);
//    
//    NSArray *array = [NSArray arrayWithObjects:@1,@2, nil];
//    self.array1 = array;
//    self.array2 = array;
//    array = @[@4,@5];
//    
//    BPLog(@"%p,%p,%p",array,self.array1,self.array2);
//    BPLog(@"%@,%@,%@",array,self.array1,self.array2);

}

- (NSArray *)array1
{
    if (!_array1) {
        _array1 = [NSArray array];
    }
    return _array1;
}

- (NSArray *)array2
{
    if (!_array2) {
        _array2 = [NSArray array];
    }
    return _array2;
}

- (NSMutableArray *)array3
{
    if (!_array3) {
        _array3 = [NSMutableArray array];
    }
    return _array3;
}

- (NSMutableArray *)array4
{
    if (!_array4) {
        _array4 = [NSMutableArray array];
    }
    return _array4;
}
//枚举
- (void)dealWithState:(direction)state {
    switch (state) {
        case left:
            //...
            break;
        case right:
            //...
            break;
        case top:
            //...
        case down:
            //...
            break;
    }
}

- (void)testmuArray
{
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    self.array = mutableArray;
    BPLog(@"%p,%p",self.array,mutableArray);

    [mutableArray removeAllObjects];;
    BPLog(@"%@",self.array);
    
    
    NSArray *array = @[ @1, @2, @3, @4 ];

    [mutableArray addObjectsFromArray:array];
    self.array = [mutableArray copy];
    BPLog(@"%p,%p",self.array,mutableArray);

    [mutableArray removeAllObjects];;
    BPLog(@"%@",self.array);
    

    
    
    
}


- (void)testmuArray_1
{
    
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@1,@2,nil];
//    self.mutableArray = array;
//    BPLog(@"%p,%p,%@,%@",array,self.mutableArray,array,self.mutableArray);
//    
//    [self.mutableArray removeObjectAtIndex:0];
    
    NSString *str1 = @"1";
    self.str2 = str1;
    str1 = @"2";
    BPLog(@"%p,%p",str1,self.str2);
    BPLog(@"%@,%@",str1,self.str2);

    
    
}
- (void)testArray
{
    
    /*
     容器内的元素内容都是指针复制。由此可见，对于容器而言，其元素对象始终是指针复制。如果需要元素对象也是对象复制，就需要实现深拷贝。

     */
    NSArray * mArray1 = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"a"],@"b",@"c",nil];
    NSArray * mArrayCopy1 = [mArray1 copy];
    NSMutableArray *mArrayMCopy1 = [mArray1 mutableCopy];
    //mArrayCopy2,mArrayMCopy1和mArray1指向的都是不一样的对象，但是其中的元素都是一样的对象——同一个指针
    //一下做测试
    NSMutableString *testString = [mArray1 objectAtIndex:0];
    //testString = @"1a1";//这样会改变testString的指针，其实是将@“1a1”临时对象赋给了testString
    [testString appendString:@" tail"];//这样以上三个数组的首元素都被改变了
    BPLog(@"%@,%@,%@",mArray1,mArrayCopy1,mArrayMCopy1);
}
- (void)testString
{
    NSString * string1 = [NSMutableString stringWithFormat:@"test1"];

    NSString * stringCopy1 = [string1 copy];// 产生新对象
    NSMutableString * stringMuCopy1 = [string1 mutableCopy];// 产生新对象
    
    NSMutableString * mustring = [NSMutableString stringWithFormat:@"test2"];
    NSString * stringCopy = [mustring copy];// 产生新对象
    NSMutableString * mstringCopy = [mustring copy];// 产生新对象
    NSMutableString * stringMuCopy = [mustring mutableCopy];// 产生新对象
    
    BPLog(@"%p,%p,%p,%p,%p,%p,%p",string1,stringCopy1,stringMuCopy1,mustring,stringCopy,mstringCopy,stringMuCopy);

}

#pragma mark - strong/copy
- (void)testStrong
{
//    在strong情况下，如果外部被引用的变量更改了，那里面这个值也会更改，因为两个属性指向同一块内存空间 。在这里strong 属于浅拷贝，只赋值对象的指针。
//    为了防止外界修改name,就用copy,因为copy是生成了一份新的内存空间，，所以外界是不能修改值。
    
    DataBaseModel * model = [[DataBaseModel alloc]init];
    NSMutableString * name = [NSMutableString stringWithFormat:@"iOS俱哥"];

    model.name = name;
    model.strongName = name;
    // 不能改变model.name的值，因为其内部copy新的对象
    //改变了model.StrongName的值，因为StrongName和name指向了同一块内存
    [name appendString:@"!!!"];
    
    BPLog(@"p.name = %@",model.name);
    BPLog(@"p.StrongName = %@",model.strongName);
    
    BPLog(@"name:%p,p.name:%p,p.StrongName:%p",name,model.name,model.strongName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
