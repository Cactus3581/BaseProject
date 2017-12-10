//
//  BPAppMacro.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#ifndef BPAppMacro_h
#define BPAppMacro_h


#ifndef BPNotificationCenter
#define BPNotificationCenter [NSNotificationCenter defaultCenter]
#endif

#ifndef BPUserDefaults
#define BPUserDefaults [NSUserDefaults standardUserDefaults]
#endif

#ifndef LocalStr
#define LocalStr(_s_) NSLocalizedString((_s_), nil)
#endif


#ifndef BP_CLAMP // 返回中间值
#define BP_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif

#ifndef BP_SWAP // 值交换
#define BP_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif

/**
 说明：在链接静态库的时候如果使用了category，在编译到静态库时，这些代码模块实际上是存在不同的obj文件里的。程序在连接Category方法时，实际上只加载了Category模块，扩展的基类代码并没有被加载。这样，程序虽然可以编译通过，但是在运行时，因为找不到基类模块，就会出现unrecognized selector 这样的错误。我们可以在Other Linker Flags中添加-all_load、-force_load、-ObjC等flag解决该问题，同时也可以使用如下的宏
 使用：
 BPSYNTH_DUMMY_CLASS(NSString_BPAdd)
 */
#ifndef BPSYNTH_DUMMY_CLASS
#define BPSYNTH_DUMMY_CLASS(_name_) \
@interface BPSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation BPSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif

/**
 自定义NSLog
<<<<<<< HEAD
 使用 : BPLog("你好%@",@"wazrx")，第一个"前面无需添加@,添加了也无所谓
 解释 : 将上面的打印换成NSLog可得到 NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" "你好%@"), __FILE__, __FUNCTION__, __LINE__, @"wazrx");  fmt用于替换为我们的输出格式字符串，__FILE__宏在预编译时会替换成当前的源文件名,__LINE__宏在预编译时会替换成当前的行号,__FUNCTION__宏在预编译时会替换成当前的函数名称,__VA_ARGS__是一个可变参数的宏,使得打印的参数可以随意，而##可以在__VA_ARGS__的参数为0的时候去掉前面的逗号，保证打印更美观直观
=======
 使用 : BPLog("你好%@",@"xrz")，第一个"前面无需添加@,添加了也无所谓
 解释 : 将上面的打印换成NSLog可得到 NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" "你好%@"), __FILE__, __FUNCTION__, __LINE__, @"xrz");  fmt用于替换为我们的输出格式字符串，__FILE__宏在预编译时会替换成当前的源文件名,__LINE__宏在预编译时会替换成当前的行号,__FUNCTION__宏在预编译时会替换成当前的函数名称,__VA_ARGS__是一个可变参数的宏,使得打印的参数可以随意，而##可以在__VA_ARGS__的参数为0的时候去掉前面的逗号，保证打印更美观直观
>>>>>>> develop
 
 */

#ifdef DEBUG
#define BPLog(fmt, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String]);
#else
#define BPLog(...)
#endif

/**
 *  判断block存在后执行
 */
#ifndef doBlock
#define doBlock(_b_, ...) if(_b_){_b_(__VA_ARGS__);}
#endif

#ifndef BPEdgeInsetsOne
#define BPEdgeInsetsOne(_s_) UIEdgeInsetsMake(_s_, _s_, _s_, _s_)
#endif

#ifndef BPEdgeInsetsTwo
#define BPEdgeInsetsTwo(_a_, _b_) UIEdgeInsetsMake(_a_, _b_, _a_, _b_)
#endif

/**
 weakify
 strongify用来解除循环引用
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object
#else
#define weakify(object) __block __typeof__(object) block##_##object = object
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object
#else
#define weakify(object) __block __typeof__(object) block##_##object = object
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##_##object
#else
#define strongify(object) __typeof__(object) object = block##_##object
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) object = weak##_##object
#else
#define strongify(object) __typeof__(object) object = block##_##object
#endif
#endif
#endif

/**去除performSelector在ARC中的警告*/
#define PerformSelectorLeakWarningIgnore(_method_) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
_method_; \
_Pragma("clang diagnostic pop") \
} while (0)

<<<<<<< HEAD

#endif /* BPAppMacro_h */



=======
#endif /* BPAppMacro_h */
>>>>>>> develop
