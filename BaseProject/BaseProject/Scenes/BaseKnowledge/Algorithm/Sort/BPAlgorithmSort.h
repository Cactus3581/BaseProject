//
//  BPAlgorithmSort.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#ifndef BPAlgorithm_h
#define BPAlgorithm_h

// 冒泡排序
int * bubbleSort(int a[], int length);

// 插入排序
int *insertionSort(int a[], int n);

// 归并排序，O(nlog n)，分治递归
void mergeSort(int *arr, int p, int r);
    
// 快速排序
void quickSort(int a[],int left, int right);

// 斐波那契奇数列
int fib(int n);

// 数组求和-递归
int sumNumber(int *a, int length);

int maxsum(int a[], int n);

#endif /* BPAlgorithm_h */
