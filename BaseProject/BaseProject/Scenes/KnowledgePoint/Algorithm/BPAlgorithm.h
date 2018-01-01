//
//  BPAlgorithm.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#ifndef BPAlgorithm_h
#define BPAlgorithm_h

int * bubble_sort(int a[], int length);//冒泡

int fib(int n);//递归-斐波那契奇数列

void quicksort(int a[],int left, int right);//快速排序

//二分查找 θ(logn)
int binarySearch1(int a[] , int low , int high , int findNum);//递归方法

int binarySearch2(int *a, int findNum,int length);//非递归方法-while循环


/*
 插值查找：
 基本思想：基于二分查找算法，将查找点的选择改进为自适应选择，可以提高查找效率。当然，差值查找也属于有序查找.
 插值查找是对二分查找的优化，是一种优秀的二分查找算法。插值查找也要求待查找的数组是有序的数列，是一种有序查找算法。
 注： 对于表长较大，而关键字分布又比较均匀的查找表来说，插值查找算法的平均性能比折半查找要好的多。反之，数组中如果分布非常不均匀，那么插值查找未必是很合适的选择。
 */

void kmpMatch(char * s,int sLength,char * p,int pLength,int *prefix);

void kmpPrefixFunction(char *p,int length,int *prefix);


//匹配函数的朴素算法,用于比较
void normal_match(char * s,int sLength,char * p,int pLength);
    
#endif /* BPAlgorithm_h */
