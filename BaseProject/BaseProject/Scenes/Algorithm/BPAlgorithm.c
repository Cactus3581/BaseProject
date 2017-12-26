//
//  BPAlgorithm.c
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/26.
//  Copyright © 2017年 cactus. All rights reserved.
//

#include "BPAlgorithm.h"
#include "string.h"

/*
 冒泡排序，核心思想：归位（以下是从左到右归位）
 1.从列表的第一个数字到倒数第二个数字，逐个检查：若某一位上的数字大于他的下一位，则将它与它的下一位交换。
 2.重复1号步骤(倒数的数字加1。例如：第一次到倒数第二个数字，第二次到倒数第三个数字，依此类推...)，直至再也不能交换。
 
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(1)
 
 */

int * bubble_sort(int a[], int length)
{
    int i, j, temp;
    for (j = 0; j < length - 1; j++)
        for (i = 0; i < length - 1 - j; i++) //外层循环每循环一次就能确定出一个泡泡（最大或者最小），所以内层循环不用再计算已经排好的部分
        {
            if(a[i] > a[i + 1])
            {
                temp = a[i];
                a[i] = a[i + 1];
                a[i + 1] = temp;
            }
        }
    return a;
}

/*
 递归-斐波那契奇数列
 程序调用自身的编程技巧称为递归,是函数自己调用自己。
 递归就是有去（递去）有回（归来）；
 递归的基本思想是把规模大的问题转化为规模小的相似的子问题来解决。在函数实现时，因为解决大问题的方法和解决小问题的方法往往是同一个方法，所以就产生了函数调用它自身的情况。另外这个解决问题的函数必须有明显的结束条件，这样就不会产生无限递归的情况了。
 
 递归思想用递归用程序表达出来，确定了三个要素：递 + 结束条件 + 归。
 
 递归的要素:
 递归就是在过程或函数里面调用自身;
 在使用递归时,必须有一个明确的递归结束条件,称为递归出口.
 
 递归的步骤：
 递推:把复杂的问题的求解推到比原问题简单一些的问题的求解;
 回归:当获得最简单的情况后,逐步返回,依次得到复杂的解.
 
 递归的优势：
 大问题化为小问题,可以极大的减少代码量；
 用有限的语句来定义对象的无限集合；
 代码更简洁清晰，可读性更好
 
 递归的劣势：
 递归调用函数,浪费空间；
 递归太深容易造成堆栈的溢出；
 
 学过编译原理的童鞋都知道，函数是在栈（对，就是童鞋们在数据结构上学习的栈）上运行的.
 已知：Fib(1) = 1；Fib(2) = 2，Fib(n) = n，如果n=4，求Fib(4)：
 要求fib(4)，必须在栈上求Fib(3)（要求Fib(3),必须再为在栈上求Fib(2)和Fib(1)，要求Fib(2)，在栈上继续求fib(1)（类似fib(3)的过程））。
 这样的递归算法，必须在栈上记录函内的局部变量、传递参数、返回地址（直到调用结束后回到哪）和上一栈帧的EBP和BP（恢复调用者栈），并且频繁出栈入栈是需要系统开销的，虽然单次入栈出栈开销不大，但是如果要求Fib(1000)这样的函数，恐怕一般的单机估计得跑几十分钟甚至半天了。
 
 递归的实现是通过调用函数本身，函数调用的时候，每次调用时要做地址保存，参数传递等，这是通过一个递归工作栈实现的。具体是每次调用函数本身要保存的内容包括：局部变量、形参、调用函数地址、返回值。那么，如果递归调用N次，就要分配N局部变量、N形参、N调用函数地址、N返回值。这势必是影响效率的。
 如果调用层数比较深，需要增加额外的堆栈处理（还有可能出现堆栈溢出的情况）
 递归算法和循环算法总结：一般递归调用可以处理的算法，也通过循环去解决常需要额外的低效处理。
 */
int fib(int n)
{
    
    if(n==1||n==2)
    {
        return 1;
        
    }
    return fib(n-1)+fib(n-2);
}


/*
 快速排序: 平均空间复杂度：O(nlogn);平均时间复杂度：O(n^2)
 核心思想：归位 + 二分法+ 递归
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
void quicksort(int a[],int left,int right)
{
    int i, j, t, temp;
    if(left > right)  //开始位置坐标大于结束位置坐标时,直接return,结束下面的操作
    {
        //递归结束的条件就是left > right
        return;
    }
    temp = a[left];  //temp中存的就是基准数(基准数是随机的,但一般都是第一个元素)
    i = left;
    j = right;
    
    while(i != j)
    {
        //顺序很重要，要先从右边开始找:从右边开始找比基准元素的小的元素
        while(a[j] >= temp && i<j)
        {
            //找到比temp数值大的位置，直到找到比temp小的就停止循环
            j--;
        }
        
        //再找左边的:从左边开始找比基准元素的大的元素
        while(a[i] <= temp && i<j)
        {
            //找到比temp数值小的位置，直到找到比temp大的就停止循环
            i++;
        }
        
        /*
         进行到此，a[j] <=temp(a[left]) <= a[i],但是物理位置上还是temp(a[left]) <= i < j，因此接下来交换a[i]和a[j],于是[0,i]这个区间里面全部比temp(a[left])小的，[j,right]这个区间里面全部都是比temp(a[left])大的
         以下是交换两个数在数组中的位置：
         */
        
        if(i < j)
        {
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
    quicksort(a,left, i-1);//继续处理左边的，这里是一个递归的过程
    quicksort(a,i+1, right);//继续处理右边的 ，这里是一个递归的过程
    
    //以上的每一次递归都会确认某个数的精准位置及保证左（右）边的数字都比它小（大）。
}


/*
 二分法查找其实就是折半查找，一种效率较高的查找方法,当数据量很大适宜采用该方法.针对有序数组来查找的。时间复杂度是O(log n)
 主要思想是：（设查找的数组期间为array[low, high]）
 1.确定该期间的中间位置mid
 2.将查找的值findNum与array[mid]比较。若相等，查找成功返回此位置；否则确定新的查找区域，继续二分查找。
 */

// 二分查找-递归方法
int binarySearch1(int a[] , int low , int high , int findNum)
{
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
int binarySearch2(int a[] , int low , int high , int findNum)
{
    while (low <= high)
    {
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

//KMP算法
void get_next(char pattern[], int next[],int p_len) {
    int i = 0; // i用来记录当前计算的next数组元素的下标， 同时也作为模式串本身被匹配到的位置的下标
    int j = 0; // j == -1 代表从在i的位置模式串无法匹配成功，从下一个位置开始匹配
    next[0] = -1; // next[0]固定为-1

    while (++i < p_len) {
        if (pattern[i] == pattern[j]) {
            // j是用来记录当前模式串匹配到的位置的下标， 这就意味着当j = l时，
            // 则在pattern[j]这个字符前面已经有l - 1个成功匹配,
            // 即子串前缀和后缀的最长公共匹配字符数有l - 1个。
            next[i] = j++;

            // 当根据next[i]偏移后的字符与偏移前的字符向同时
            // 那么这次的偏移是没有意义的，因为匹配必定会失败
            // 所以可以一直往前偏移，直到
            // 1): 偏移前的字符和偏移后的字符不相同。
            // 2): next[i] == -1
            while (next[i] != -1 && pattern[i] == pattern[next[i]]) {
                next[i] = next[next[i]];
                printf("next = %d,%d\n",i,next[i]);
            }
        } else {
            next[i] = j;
            j = 0;
            if (pattern[i] == pattern[j]) {
                j++;
            }
        }
    }
}

int index_KMP(char sourceStr[], char subStr[], int next[]){

    int i = 0;
    int j = 0;
    while(i < strlen(sourceStr) && j < strlen(subStr)) {

        if(j == 0 || sourceStr[i] == subStr[j]){

            i++;
            j++;
        } else {

            j=next[j];
        }
    }
    if (j == strlen(subStr)) {

        return i - (int)strlen(subStr);
    } else {

        return -1;//匹配失败
    }
}

/*
 KMP算法

 KMP算法的改进之处在于：能够知道在匹配失败后，有多少字符是不需要进行匹配可以直接跳过的，匹配失败后，下一次匹配从什么地方开始能够有效的减少不必要的匹配过程。
 */
void GetNext(char* p,int next[]) {
    int pLen = strlen(p);
    next[0] = -1;
    int k = -1;
    int j = 0;
    while (j < pLen - 1)
    {
        //p[k]表示前缀，p[j]表示后缀
        if (k == -1 || p[j] == p[k])
        {
            ++k;
            ++j;
            if (p[j] != p[k])
                next[j] = k;   //之前只有这一行
            else
                //因为不能出现p[j] = p[ next[j ]]，所以当出现时需要继续递归，k = next[k] = next[next[k]]
                next[j] = next[k];
        }
        else
        {
            k = next[k];
        }
    }
}
int kmp(char *s,char *p){
    int sLen = strlen(s);
    int pLen = strlen(p);
    int next[pLen];
    GetNext(p,next);
    int i = 0;
    int j = 0;
    
    while(i<sLen && j<pLen){
        if(j == -1 || s[i] == p[j]){
            i++;
            j++;
            
        }
        else{
            j = next[j];
        }
    }
    //匹配成功，返回模式串p在文本串s中的位置，否则返回-1
    if (j == pLen)
        return i - j;
    else
        return -1;
}

