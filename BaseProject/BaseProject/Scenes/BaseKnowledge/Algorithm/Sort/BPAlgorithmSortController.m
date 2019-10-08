//
//  BPAlgorithmSortController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPAlgorithmSortController.h"
#include "BPAlgorithmSort.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

@interface BPAlgorithmSortController ()

@end


@implementation BPAlgorithmSortController

// 编程 = 数据结构 + 算法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
                
            case 0:{
                [self bubbleSort];
            }
                break;
                
            case 1:{
                [self choiceSort];
            }
                break;
                
            case 2:{
                [self insertionSort];
            }
                break;
                
            case 3:{
                [self mergeSort];
            }
                break;
                
            case 4:{
                [self quickSort];
            }
                break;
                
            case 5:{
                [self fib];//递归-斐波那契奇数列
            }
                break;
                
            case 6:{
                [self sum];
            }
                break;
                
            case 7:{
                [self maxsum];
            }
                break;
        }
    }
}

#pragma mark - 冒泡排序
- (void)bubbleSort {
    int array[] = {4,5,6,1,3,2};
    int length = BPArrayLength(array);
    int *bubbleSortArray = bubbleSort(array,length);
    for (int i = 0; i < length; i++) {
        printf("冒泡：%d\n",bubbleSortArray[i]);
    }
}

#pragma mark - 选择排序
- (void)choiceSort {
    
}

#pragma mark - 插入排序
- (void)insertionSort {
    
    int array[] = {4,5,6,1,3,2};
    int length = BPArrayLength(array);
    int *result = insertionSort(array,length);
    for (int i = 0; i < length; i++) {
        printf("插入排序：%d\n",result[i]);
    }
}

#pragma mark - 归并排序
- (void)mergeSort {

    int array[] = {11,8,3,9,7,1,2,5};
    mergeSort(array, 0, BPArrayLength(array)-1);
//    BPPrintfIntArray(array);
}

- (NSArray *)mergeSort:(NSArray *)unSortArray {
    
    NSInteger len = unSortArray.count;
    // 递归终止条件
    if (len <= 1) {
        return unSortArray;
    }
    NSInteger mid = len / 2;
    // 对左半部分进行拆分
    NSArray *lList = [self mergeSort:[unSortArray subarrayWithRange:NSMakeRange(0, mid)]];
    // 对右半部分进行拆分
    NSArray *rList = [self mergeSort:[unSortArray subarrayWithRange:NSMakeRange(mid, len-mid)]];
    // 递归结束后执行下面的语句
    NSInteger lIndex = 0;
    NSInteger rIndex = 0;
    // 进行合并
    NSMutableArray *results = [NSMutableArray array];
    while (lIndex < lList.count && rIndex < rList.count) {
        if ([lList[lIndex] integerValue] < [rList[rIndex] integerValue]) {
            [results addObject:lList[lIndex]];
            lIndex += 1;
        } else {
            [results addObject:rList[rIndex]];
            rIndex += 1;
        }
    }
    // 把左边剩余元素加到排序结果中
    if (lIndex < lList.count) {
        [results addObjectsFromArray:[lList subarrayWithRange:NSMakeRange(lIndex, lList.count-lIndex)]];
    }
    // 把右边剩余元素加到排序结果中
    if (rIndex < rList.count) {
        [results addObjectsFromArray:[rList subarrayWithRange:NSMakeRange(rIndex, rList.count-rIndex)]];
    }
    return results;
}

#pragma mark - 快速排序
- (void)quickSort {
    int array[] = {4,5,6,1,3,2};
    int length = BPArrayLength(array);
    quickSort(array,0,length-1);
    
    for (int i = 0; i<length; i++) {
        printf("快速排序:%d\n",array[i]);
    }
}


#pragma mark - 递归-斐波那契奇数列
- (void)fib {
//    int fibResult = fib(5);
//    printf("递归-斐波那契奇数列:%d\n",fibResult);
    
    BPLog(@"%d",[self fib1:10]);
}

- (int)fib1:(int)n {
    
//    if(n == 1) {
//        return 1;
//    }
//    return [self fib1:n-1] + 1;
    
    int a = [self fib2:1];
    return a+1;
}

- (int)fib2:(int)n {
    int a = [self fib3:1];
    return a;
}

- (int)fib3:(int)n {
    return 1;
}

- (void)circie:(NSMutableArray *)array {
    if (!array.count) {
        return ;
    }
    // 继续移除
    [array removeLastObject];
    [self circie2:array];
}

- (void)circie2:(NSMutableArray *)array {
    if (!array.count) {
        return ;
    }
    // 继续移除
    [array removeLastObject];
    [self circie3:array];
}

- (void)circie3:(NSMutableArray *)array {
    if (!array.count) {
        return ;
    }
    // 继续移除
    [array removeLastObject];
    // [self circie4:array];

}

#pragma mark - sum
- (void)sum {
    int a[] = {1,2,3,4,5};
    int sum = sumNumber(a, 5);
    printf("数组求和 = %d",sum);
}

#pragma mark - maxsum
- (void)maxsum {
    int a[] = {3,2,4,4,2,2,2};
    printf("%d",maxsum(a,7));
}



@end
