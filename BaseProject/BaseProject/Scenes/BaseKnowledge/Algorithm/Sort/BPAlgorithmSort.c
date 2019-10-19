//
//  BPAlgorithmSort.c
//  BaseProject
//
//  Created by Ryan on 2017/12/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#include "BPAlgorithmSort.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

//冒泡排序

int *bubbleSort(int a[], int n) {
    
    if (n <= 1) {
        return a;
    }

    int i, j, temp;
    
     // 外层循环每循环一次就能确定出一个泡泡（最大或者最小），所以内层循环不用再计算已经排好的部分
    for (i = 0; i < n; ++i) {
        
        for (j = 0; j < n - 1 - i; ++j) {
        
            if(a[j] > a[j + 1]) {
                // 交换
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
    return a;
}

// 插入排序
int *insertionSort(int a[], int n) {
    
    if (n <= 1) {
        return a;
    }
    
    for (int i = 1; i < n; ++i) {
        int value = a[i];
        int j = i - 1;
        // 查找插入的位置
        for (; j >= 0; --j) {
            if (a[j] > value) {
                a[j+1] = a[j];  // 数据移动
            } else {
                break;
            }
        }
        // j+1为找到的合适位置
        a[j+1] = value; // 插入数据
    }
    
    return a;
}

// 归并排序算法
void merge(int a[], int start, int mid, int end);

void mergeSort(int *a, int start, int end) {
    
    
    if (start >= end) {
        return;
    }
    
    // 取 p 到 r 之间的中间位置 q
    int mid = (start + end) / 2;
    
    // 分治递归
    mergeSort(a, start, mid);
    mergeSort(a, mid + 1, end);
    
    //合并：将已经有序的 a[start…mid] 和 a[mid+1…end] 合并成一个有序的数组，并且放入 a[start…end]
    merge(a, start, mid, end);
}

//将已经有序的 a[start…mid] 和 a[mid+1…end] 合并成一个有序的数组，并且放入 a[start…end]
void merge(int a[], int start, int mid, int end) {
    
    int i = start, j = mid + 1, k = 0;

    // 申请一个大小跟 a 一样的临时数组
    int *tmp = (int *)malloc((end - start + 1) * sizeof(int));
    
    // 大小比较然后将数据加到临时数组里
    for (;i <= mid && j <= end;) {
        if (a[i] <= a[j]) {
            tmp[k++] = a[i++];
        } else {
            tmp[k++] = a[j++];
        }
    }
    
    // 判断哪个子数组中有剩余的数据，然后将剩余的数据拷贝到临时数组tmp
    if (i == mid + 1) {
        // 将右边的数据加进来
        for (;j <= end;) {
            tmp[k++] = a[j++];
        }
    } else {
        // 将左边的数据加进来
        for (;i <= mid;) {
            tmp[k++] = a[i++];
        }
    }

    // 将 tmp 中的数组拷贝回 a[start...end]
    // 从a数组的start位置开始，使用tmp的数据替换
    memcpy(a + start, tmp, (end - start + 1) * sizeof(int));
    free(tmp);
}

/*
 快速排序: 时间复杂度：O(nlogn)
 通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。
 
 步骤讲解:
 1.设置两个变量i，j ，排序开始时i = 0，就j = array.count - 1；
 2.设置数组的第一个值为比较基准数temp，temp = array.count[0]；
 3.因为设置temp为数组的第一个值，所以先从数组最右边开始往前查找比temp小的值。如果没有找到，j--继续往前搜索；如果找到停止往前搜索，记录j的位置，进入第4步；
 4.从i位置开始往后搜索比temp可以大的值，如果没有找到，i++继续往后搜索；如果找到，记录i的位置，停止往后搜索；
 5.如果i<j,则将a[i],a[j]值互换。效果：保证i左边的数值比temp小，j右边比temp大；
 6.重复第3、4、5步，直到i == j，停止排序；此时找到了temp的准确位置了，并将temp左边所以的值都比它小，右边的值都比temp大；进行递归，分别对左右两边进行递归。
 
 1-6步的每一次完成，都会找到temp的精准位置，并将temp左边所以的值都比它小，右边的值都比temp大
 
 */
void quickSort(int a[],int left,int right) {
    
    int i, j, t, temp;
    
    //开始位置坐标大于结束位置坐标时,直接return,结束下面的操作
    if(left > right) {
        return;
    }
    
    //temp中存的就是基准数(基准数是随机的,但一般都是第一个元素)
    temp = a[left];
    i = left;
    j = right;
    
    while(i != j) {
        
        // 从右边开始找比基准元素的小的元素
        while(a[j] >= temp && i<j) {
            //找到比temp数值大的位置，直到找到比temp小的就停止循环
            j--;
        }
        
        //从左边开始找比基准元素的大的元素
        while(a[i] <= temp && i<j) {
            //找到比temp数值小的位置，直到找到比temp大的就停止循环
            i++;
        }
        
        /*
         进行到此，a[j] <= temp（a[left]) <= a[i]，但是物理位置上还是temp(a[left]) <= i < j，因此接下来交换a[i]和a[j],于是[0,i]这个区间里面全部比temp(a[left])小的，[j,right]这个区间里面全部都是比temp(a[left])大的
         */
        
        // 交换两个数在数组中的位置
        if(i < j) {
            t = a[i];
            a[i] = a[j];
            a[j] = t;
        }
    }
    
    /*
     此时i = j,最终将基准数归位
     每一次调用这个方法，都将temp的值放到了合适的位置，确定了一个值的位置了。
     */
    a[left] = a[i];
    a[i] = temp;
    
//第一轮结束之后，采用递归-二分法：现在就分成了2段了，2段之间的值是temp（已经确定好它的位置了，并且它的左边全是比它小的，右边全是比它大的）
    quickSort(a,left, i-1);//继续处理左边的
    quickSort(a,i+1, right);//继续处理右边的
    
    //以上的每一次递归都会确认某个数的精准位置及保证左（右）边的数字都比它小（大）。
}

int fib(int n) {
    
    if(n == 1 || n == 2) {
        return 1;
    }
    return fib(n-1) + fib(n-2);
}

// 数组求和-递归
int sumNumber(int *a, int length) {
    return length == 0 ? 0 : sumNumber(a, length - 1) + a[length - 1];
}

/*
 输入一个整形数组，数组里有正数也有负数。
//数组中连续的一个或多个整数组成一个子数组，每个子数组都有一个和，求所有子数组的和的最大值。
//例如输入的数组为1, -2, 3, 10, -4, 7, 2, -5，和最大的子数组为3, 10, -4, 7, 2，
因此输出为该子数组的和18。
 */

int maxsum(int a[],  int n){
    int *sum = (int *)malloc(n * sizeof(int));
    sum[0] = a[0];
    int i;
    int max = a[0];
    for(i = 1; i < n;i++){
        sum[i] = (sum[i-1] + a[i] > a[i] ? sum[i-1] + a[i]: a[i]);
        if(max < sum[i]){
            max = sum[i];
        }
    }
    return max;
}  

void fpointd(int a,int *b) {
    a = 5;
    *b = 6;
}

void point() {
    int a = 1;
    int b = 2;
    fpointd(a,&b);
    printf("quickSort12 = %d,%d",a,b);
}

