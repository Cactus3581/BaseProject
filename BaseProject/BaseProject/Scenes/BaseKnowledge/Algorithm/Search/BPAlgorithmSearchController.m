//
//  BPAlgorithmSearchController.m
//  BaseProject
//
//  Created by Ryan on 2019/9/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPAlgorithmSearchController.h"
#include "BPAlgorithmSearch.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

@interface BPAlgorithmSearchController ()
@end

@implementation BPAlgorithmSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    
    if (self.needDynamicJump) {
        
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            
                
            case 0:{
                [self binarySearch1Result];//二分查找-递归方法
            }
                break;
                
            case 1:{
                [self binarySearch2Result];//二分查找-非递归方法
            }
                break;
        }
    }
}

#pragma mark - 二分查找-递归方法
- (void)binarySearch1Result {
    int array[10] = {1,2,3,4,5,6,7,8,9,10};
    int length = sizeof(array) / sizeof(array[0]);
    int binarySearch1Result = binarySearch1(array,0,length-1,array[6]);
    printf("二分查找-递归方法:%d\n",binarySearch1Result);
}

#pragma mark - 二分查找-非递归方法
- (void)binarySearch2Result {
    int array[10] = {1,2,3,4,5,6,7,8,9,10};
    int length = sizeof(array) / sizeof(array[0]);
    int binarySearch2Result = binarySearch2(array,array[8],length);
    printf("二分查找-非递归方法:%d\n",binarySearch2Result);
}

@end
