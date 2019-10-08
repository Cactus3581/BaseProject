//
//  BPAlgorithmCharController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/9/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPAlgorithmCharController.h"
#include "BPAlgorithmChar.h"

@interface BPAlgorithmCharController ()

@end

@implementation BPAlgorithmCharController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 字符串单词反转
- (void)reverseSentence {
    char originalStr[] = "the sky is blue";
    char p[] = "the sky is blue";
    char q[] = "xiaruzhen";
    getStr(p,q);
    
    //    char *reversedStr = ReverseSentence(originalStr);
    //    BPLog(@"reversedStr: %s", reversedStr);
    //    BPLog(@"reversedStr: %c", 1+(*originalStr));
}

#pragma mark - KMP
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

@end
