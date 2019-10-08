//
//  BPAlgorithmSearch.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/9/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#ifndef BPAlgorithmSearch_h
#define BPAlgorithmSearch_h

#include <stdio.h>

//二分查找法-递归方法 θ(logn)
int binarySearch1(int a[] , int low , int high , int findNum);

//二分查找法-/非递归方法-while循环
int binarySearch2(int *a, int findNum,int length);

#endif /* BPAlgorithmSearch_h */
