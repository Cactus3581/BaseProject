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

// 编程 = 数据结构 + 算法
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self bubble];//冒泡
//
//    [self fib];//递归-斐波那契奇数列
//
//    [self quicksort];//快速排序
//
//    [self binarySearch1Result];//二分查找-递归方法
//
//    [self binarySearch2Result];//二分查找-非递归方法
//
//    [self sum];

//    [self kmp];
    
    int a[] = {3,2,4,4,2,2,2};
    printf("%d",maxsum(a,7));
    
}

//递归-斐波那契奇数列
- (void)fib {
    int fibResult =  fib(5);
    printf("递归-斐波那契奇数列:%d\n",fibResult);
}

//冒泡
- (void)bubble {
    int array[10] = {111,22,323,42,51,162,73,181,91,100};
    //计算C语言中的数字长度
    int length = sizeof(array) / sizeof(array[0]);
    printf("数组长度:%d\n",length);
    
    int *bubble_sortArray = bubble_sort(array,length);
    for (int i = 0; i < length; i++) {
        printf("冒泡：%d\n",bubble_sortArray[i]);
    }
}

//快速排序
- (void)quicksort {
    int array[10] = {111,22,323,42,51,162,73,181,91,100};
    int length = sizeof(array) / sizeof(array[0]);
    quicksort(array,0,length-1);
    
    for (int i = 0; i<length; i++) {
        printf("快速排序:%d\n",array[i]);
    }
}

//二分查找-递归方法
- (void)binarySearch1Result {
    int array[10] = {1,2,3,4,5,6,7,8,9,10};
    int length = sizeof(array) / sizeof(array[0]);
    int binarySearch1Result = binarySearch1(array,0,length-1,array[6]);
    printf("二分查找-递归方法:%d\n",binarySearch1Result);
}

//二分查找-非递归方法
- (void)binarySearch2Result {
    int array[10] = {1,2,3,4,5,6,7,8,9,10};
    int length = sizeof(array) / sizeof(array[0]);
    int binarySearch2Result = binarySearch2(array,array[8],length);
    printf("二分查找-非递归方法:%d\n",binarySearch2Result);
}

- (void)sum {
    int a[] = {1,2,3,4,5};
    int sum = sumNumber(a, 5);
    printf("数组求和 = %d",sum);
}

- (void)kmp {
//    char str1[] = {'a','e','f','w','g','d'};
//    char str2[] = {'e','f','d'};
    
    char *s = "adbadabbaabadabbadada";
    char *t = "adabbadada";

    int *next = (int *)malloc((strlen(t) + 1) * sizeof(int));//修正后的nextval数组

    int result = Index_kmp(s,t,next);
    
    if(result == -1) {
        printf("\n无匹配项！\n");
    }
    else {
        printf("\n在第%d项开始匹配成功\n",result+1);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
