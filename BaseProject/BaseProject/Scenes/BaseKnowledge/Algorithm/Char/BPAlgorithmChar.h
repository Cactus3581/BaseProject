//
//  BPAlgorithmChar.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/9/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#ifndef BPAlgorithmChar_h
#define BPAlgorithmChar_h

#include <stdio.h>

//kmp算法
void get_next(char *t,int next[])  ;

void get_nextval(char *t,int nextval[]) ;

int Index_kmp(char *S,char *t,int next[]) ;

// 反转字符串
void reverseWord(char* p, char* q);

char *  ReverseSentence(char *s);
void getStr(char* p, char* q);

#endif /* BPAlgorithmChar_h */
