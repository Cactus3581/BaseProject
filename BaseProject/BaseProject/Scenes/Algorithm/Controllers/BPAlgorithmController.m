//
//  BPAlgorithmController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPAlgorithmController.h"
#include "BPAlgorithm.h"

@interface BPAlgorithmController ()
@end

@implementation BPAlgorithmController

- (void)viewDidLoad {
    [super viewDidLoad];
    //算法
    [self algorithm];
}

- (void)algorithm {
    //    get_next1(7);
    //    char str[] = {@"a",@"b",@"d",@"c",@"e",@"f",@"d",};
    //    char str1[] = {@"e",@"f",@"d"};
    //
    //    get_next(str,str1,7);
    
    int array[10] = {111,22,323,42,51,162,73,181,91,100};
    
    //计算C语言中的数字长度
    int length = sizeof(array) / sizeof(array[0]);
    NSLog(@"%d",length);
    
    //冒泡
    int *bubble_sortArray = bubble_sort(array,length);
    for (int i = 0; i<length-1; i++) {
        printf("\n%d\n",bubble_sortArray[i]);
    }
    
    //递归-斐波那契奇数列
    int fibResult =  fib(5);
    printf("\n%d\n",fibResult);
    
    for (int i = 0; i<length; i++) {
        printf("\n%d\n",array[i]);
    }
    //快速排序
    quicksort(array,0,length-1);
    
    for (int i = 0; i<length; i++) {
        printf("\n%d\n",array[i]);
    }
    
    //二分查找-递归方法
    int binarySearch1Result = binarySearch1(array,0,length-1,array[4]);
    NSLog(@"%d",binarySearch1Result);
    
    //二分查找-非递归方法
    int binarySearch2Result = binarySearch2(array,0,length-1,array[6]);
    NSLog(@"%d",binarySearch2Result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
