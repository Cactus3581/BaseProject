//
//  BPAlgorithmChar.c
//  BaseProject
//
//  Created by xiaruzhen on 2019/9/19.
//  Copyright © 2019 cactus. All rights reserved.
//

#include "BPAlgorithmChar.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

//KMP算法
void get_next(char *t,int next[]) {   //修正前的next数组
    int i = 1,j = 0;
    next[0] = -1;
    next[1] = 0;
    while(i < strlen(t)-1) {
        if(j == -1 || t[j] == t[i]) {
            ++i;
            ++j;
            next[i] = j;
        } else {
            j = next[j];
        }
    }
}

void get_nextval(char *t,int nextval[]) {      //修正后的nextval数组
    int i = 1,j = 0;
    nextval[0] = -1;
    nextval[1] = 0;
    int m = strlen(t);
    while(i < strlen(t) - 1) {
        if(j == -1 || t[j] == t[i]) {
            ++i;
            ++j;
            if(t[i]!=t[j]) {
                nextval[i] = j;
            }else {
                nextval[i] = nextval[j];
            }
        } else {
            j = nextval[j];
        }
    }
}

int Index_kmp(char *S,char *t,int next[]) {   //逐项比较
    int j = 0;
    int i = 0;
    int lens = strlen(S);
    int lent = strlen(t);
    
    get_next(t,next);
    
    while(i < lens && j < lent) {
        if(S[i] == t[j] || j == -1) {
            i++;
            j++;
        } else {
            j = next[j];
        }
    }
    
    if (j >= lent) {
        return i - lent;
    } else {
        return -1;
    }
}

char * ReverseSentence(char* s) {
    // 这两个指针用来确定一个单词的首尾边界
    char* p = s ; // 指向单词的首字符
    char* q = s ; // 指向空格或者 '\0'
    
    while(*q != '\0') {
        if (*q ==' ') {
            reverseWord(p, q - 1) ;
            q++ ; // 指向下一个单词首字符
            p = q ;
        } else {
            q++ ;
        }
    }
    reverseWord(p, q - 1) ; // 对最后一个单词逆序
    reverseWord(s, q - 1) ; // 对整个句子逆序
    return s;
}

// 对指针p和q之间的所有字符逆序，对单个单词进行翻转
void reverseWord(char* p, char* q) {
    while(p < q) {
        char t = *p ;
        *p++ = *q ;
        *q-- = t ;
    }
}

void getStr(char* p, char* q) {
    char o[] = "dsds";
    char *m = "dsds";
    
    printf("p = %s,*p = %c\n",p,*p);
    printf("q = %s,*q = %c\n",q,*q);
    //    *p++;
    p++;
    printf("p = %s,*p = %c\n",p,*p);
    printf("p = %s,*p = %c\n",p,*p);
    
    char t = *p ;
    printf("p = %s,*p = %c\n",p,*p);
    printf("t = %c\n",t);
    
    *p++ = *q ;
    printf("p = %s,*p = %c\n",p,*p);
    printf("q = %s,*q = %c\n",q,*q);
    *q-- = t ;
    printf("p = %s,*p = %c\n",p,*p);
    printf("q = %s,*q = %c\n",q,*q);
}

