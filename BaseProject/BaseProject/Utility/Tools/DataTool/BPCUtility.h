//
//  BPCUtility.h
//  BaseProject
//
//  Created by Ryan on 2019/9/20.
//  Copyright © 2019 cactus. All rights reserved.
//

#ifndef BPCUtility_h
#define BPCUtility_h

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>

#ifndef BPArrayLength
#define BPArrayLength(array) (sizeof(array) / sizeof(array[0]))
#endif

#ifndef BPPrintfIntArray
#define BPPrintfIntArray(array) \
{\
    BPPrintfPointIntArray(array,(BPArrayLength(array)))\
}
#endif

#ifndef BPPrintfPointIntArray
#define BPPrintfPointIntArray(array,length) \
{\
    printf("开始打印 C 语言数组\n");\
    for (int i = 0; i<length; i++) {\
        printf("index = %d, value = %d\n",i,array[i]);\
    }\
    printf("结束打印 C 语言数组\n");\
}
#endif

#endif /* BPCUtility_h */
