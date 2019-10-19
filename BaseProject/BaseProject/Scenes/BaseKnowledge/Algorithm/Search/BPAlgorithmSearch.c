//
//  BPAlgorithmSearch.c
//  BaseProject
//
//  Created by Ryan on 2019/9/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#include "BPAlgorithmSearch.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
/*
 二分法查找其实就是折半查找，一种效率较高的查找方法,当数据量很大适宜采用该方法.针对有序数组来查找的。时间复杂度是O(log n)
 主要思想是：（设查找的数组期间为array[low, high]）
 1.确定该期间的中间位置mid
 2.将查找的值findNum与array[mid]比较。若相等，查找成功返回此位置；否则确定新的查找区域，继续二分查找。
 */

// 二分查找-递归方法
int binarySearch1(int a[] , int low , int high , int findNum) {
    int mid = ( low + high ) / 2; //求中点位置
    if (low > high)
        return -1; //查找失败
    else
    {
        if (a[mid] > findNum)
            return binarySearch1(a, low, mid - 1, findNum); //在序列的前半部分查找
        else if (a[mid] < findNum)
            return binarySearch1(a, mid + 1, high, findNum); //在序列的后半部分查找
        else
            return mid;
    }
}

/*
 二分查找-非递归方法-while循环
 */
int binarySearch2(int a[], int findNum,int length) {
    int low = 0;
    int high = length - 1;
    
    
    while (low <= high) {
        int mid = ( low + high) / 2;   //此处一定要放在while里面，求中点位置
        if (a[mid] < findNum)
            low = mid + 1; // 继续在后半区间进行查找
        else if (a[mid] > findNum)
            high = mid - 1; // 继续在前半区间进行查找
        else
            return mid; // 找到待查元素
    }
    return  -1;
}

