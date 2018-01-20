//
//  BPAppToolMacro.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

/*
 一 基本用法
 1.宏定义需要加括号的两种情况:
 (1)如果宏的替换列表中带有运算符,那么使用要将替换列表放到括号中。例如#define MAX_VALUE(X,Y) ((X) > (Y) ? (X) : (Y))
 (2)如果宏有参数,每次参数在替换列表中出现时都要放在括号中。同上
 #define MAX_VALUE(X,Y) ((X) > (Y) ? (X) : (Y))// 求两个数中的最大值
 
 2.#运算符和##运算符
 (1)出现在宏定义中的#运算符把跟在其后的参数转换成一个字符串。有时把这种用法的#称为字符串化运算符。例如：
 #define PASTE(n) "adhfkj"#n
 main()
 {
 printf("%s\n",PASTE(15));
 }
 宏定义中的#运算符告诉预处理程序，把源代码中任何传递给该宏的参数转换成一个字符串。所以输出应该是adhfkj15。
 
 //参考
 //https://onevcat.com/2014/01/black-magic-in-macro/
 //http://blog.csdn.net/wang1514869032/article/details/52121043
 
 */
#import "BPUtilConstant.h"

#ifndef BPAppToolMacro_h
#define BPAppToolMacro_h

//常用宏
#pragma mark - 常用宏
//通知
#ifndef kNotificationCenter
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#endif

#ifndef kUserDefaults
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#endif

/**字体大小*/
#ifndef BPFont
//#define BPFont(_s_) [UIFont systemFontOfSize:widthRatio(_s_)]
#define BPFont(_s_) [UIFont systemFontOfSize:_s_]
#endif

#ifndef BPFontName
#define BPFontName(name,F) [UIFont fontWithName:name size:F]
#endif

#ifndef kApplication
#define kApplication        [UIApplication sharedApplication]
#endif

#ifndef kKeyWindow
#define kKeyWindow          ([UIApplication sharedApplication].keyWindow)
#endif

#ifndef kAppDelegate
#define kAppDelegate        ([UIApplication sharedApplication].delegate)
#endif

//APP版本号
#ifndef kAppVersion
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif

//App build版本号
#ifndef kAppBuildVersion
#define kAppBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#endif

//系统版本号
#ifndef kSystemVersion
#define kSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#endif

//App 名字
#ifndef kAppName
#define kAppName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#endif

// 直接判断机型
#ifndef kiPHONE4
#define kiPHONE4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#endif

#ifndef kiPHONE5
#define kiPHONE5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#endif

#ifndef kiPHONE6
#define kiPHONE6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#endif

#ifndef kiPHONE6P
#define kiPHONE6P (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)
#endif

//本地化
#ifndef BPLocalizedString
#define BPLocalizedString(_s_) NSLocalizedString((_s_), nil)
#endif

#ifndef BPLocalizedStringFromTable
#define BPLocalizedStringFromTable(_s_,_table_) NSLocalizedStringFromTable((_s_),(_table_),nil)
#endif

//用来读去bundle中本地化字段的方法。而在使用中，我们用的更多的是以上两个简化的宏
#ifndef BPLocalizedStringForKey
#define BPLocalizedStringForKey(key) \
    [[NSBundle mainBundle] localizedStringForKey:(key) value:nil table:@"BaseProject"]
#endif

//获取当前语言
#ifndef kCurrentLanguage
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#endif

// 返回中间值
#ifndef BP_CLAMP
#define BP_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif

// 值交换
#ifndef BP_SWAP
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
 使用 : BPLog("你好%@",@"xrz")，第一个"前面无需添加@,添加了也无所谓
 解释 : 将上面的打印换成NSLog可得到 NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" "你好%@"), __FILE__, __FUNCTION__, __LINE__, @"xrz");  fmt用于替换为我们的输出格式字符串，__FILE__宏在预编译时会替换成当前的源文件名,__LINE__宏在预编译时会替换成当前的行号,__FUNCTION__宏在预编译时会替换成当前的函数名称,__VA_ARGS__是一个可变参数的宏,使得打印的参数可以随意，而##可以在__VA_ARGS__的参数为0的时候保障编译正确;
    在这个宏中,"..."指可变参数。可变参数的实现方式就是使用"..."所代表的内容替代__VA_ARGS__,看看下面的代码。
    ##作用是粘合，将前后两个部分粘合成一个整体。
 */
#ifdef DEBUG
#define BPLog(fmt, ...) fprintf(stderr,"%s:%d\t%s\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,__PRETTY_FUNCTION__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String]);
#else
#define BPLog(...)
#endif

/**
 *  判断block存在后执行
 */
#ifndef doBlock
#define doBlock(_b_, ...) if(_b_){_b_(__VA_ARGS__);}
#endif

// 设置edgeInset
#ifndef kEdgeInsetsOne
#define kEdgeInsetsOne(_s_) UIEdgeInsetsMake(_s_, _s_, _s_, _s_)
#endif

#ifndef kEdgeInsetsTwo
#define kEdgeInsetsTwo(_a_, _b_) UIEdgeInsetsMake(_a_, _b_, _a_, _b_)
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

//获取图片资源
#ifndef kGetNamedImage
#define kGetNamedImage(imageName) ([UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]])
#endif

#ifndef kGetBundleTypeImage
#define kGetBundleTypeImage(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］
#endif

#ifndef kGetBundleImage
#define kGetBundleImage(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］
#endif

//GCD 的宏定义
//GCD - 一次性执行
#ifndef BP_DISPATCH_ONCE_BLOCK
#define BP_DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
#endif

//GCD - 在Main线程上运行
#ifndef BP_DISPATCH_MAIN_THREAD
#define BP_DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
#endif

//GCD - 开启异步线程
#ifndef BP_DISPATCH_GLOBAL_QUEUE_DEFAULT
#define BP_DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
#endif

//设置 view 圆角和边框
#ifndef kViewBorderRadius
#define kViewBorderRadius(View,Radius,Width,Color)\
\[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]
#endif

//获取沙盒Document路径
#ifndef kDocumentPath
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
#endif

//获取沙盒temp路径
#ifndef kTempPath
#define kTempPath NSTemporaryDirectory()
#endif

//获取沙盒Cache路径
#ifndef kCachePath
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
#endif

// 数据库目录
#ifndef PATH_DATABASE_CACHE
#define PATH_DATABASE_CACHE [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#endif

//例如 KVO 中的那个 KeyPath, 有时我们直接输入，并不好输入，而且容易输入错误，没有提示。这样写后，直接有提示，而且方便。
#ifndef BP_KEY_PATH
#define BP_KEY_PATH(objc,keyPath) @(((void)objc.keyPath,#keyPath))
//PQ_KEY_PATH(self.tableView, contentOffset);
#endif

//颜色
#ifndef kRGB
#define kRGB(_r_, _g_, _b_) [UIColor colorWithRed:(_r_) / 255.0 green:(_g_) / 255.0 blue:(_b_) / 255.0 alpha:1.0]
#endif

#ifndef kRGBA
#define kRGBA(_r_, _g_, _b_, _a_) [UIColor colorWithRed:(_r_) / 255.0 green:(_g_) / 255.0 blue:(_b_) / 255.0 alpha:(_a_)]
#endif

#ifndef kRGBF
#define kRGBF(_r_, _g_, _b_) [UIColor colorWithRed:(_r_) green:(_g_) blue:(_b_) alpha:1.0]
#endif

#ifndef kRandomColor
#define kRandomColor kRGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))
#endif

#ifndef kAlphaComponentColor
#define kAlphaComponentColor(color, a) [color colorWithAlphaComponent:a]
#endif

// RGB颜色转换（16进制->10进制）
#ifndef kHexColor
#define kHexColor(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#endif

//获取一段时间间隔
#ifndef kStartTime
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#endif

#ifndef kEndTime
#define kEndTime   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
#endif

//由角度转换弧度
#ifndef kDegreesToRadian
#define kDegreesToRadian(x)      (M_PI * (x) / 180.0)
#endif

//由弧度转换角度
#ifndef kRadianToDegrees
#define kRadianToDegrees(radian) (radian * 180.0) / (M_PI)
#endif


/**设备类型*/
#ifndef kiPHONE
#define kiPHONE    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#endif

#ifndef kiPAD
#define kiPAD      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#endif

#ifndef kiPOD
#define kiPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#endif

/**懒加载*/
#ifndef LAZY
#define LAZY(class,name) -(class *)name { \
    if (_##name == nil) { \
        _##name = [[class alloc] init]; \
    }\
        return _##name;\
    }
#endif

//字符串是否为空
#ifndef kStringIsEmpty
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#endif

//数组是否为空
#ifndef kArrayIsEmpty
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
#endif

//字典是否为空
#ifndef kDictIsEmpty
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
#endif

//是否是空对象  ( " \ ":连接行标志，连接上下两行 )
#ifndef kObjectIsEmpty
#define kObjectIsEmpty(_object) (_object == nil \
    || [_object isKindOfClass:[NSNull class]] \
    || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
    || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))
#endif

/*如果支持横屏可以用下面的宏:
 bounds 以点为单位，随着屏幕方向变化而变化
 NativeBounds 以像素为单位，固定为portrait-up的坐标系
 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
    #define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
    #define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
    #define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
    #define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
    #define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
    #define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

//获取retainCount
#ifndef BPRetainCount
#define BPRetainCount(__POINTER) (__POINTER ? CFGetRetainCount((__bridge  CFTypeRef)(__POINTER)):(0))
#endif

//获取retainCount
#ifndef BPThread
#define BPThread [NSThread currentThread],[NSThread isMainThread]
#endif


//释放一个对象
#ifndef BPSAFE_RELEASE
#define BPSAFE_RELEASE(__POINTER) { [__POINTER release]; __POINTER = nil; }
//#define SAFE_DELETE(P) if(P) { [P release], P = nil; }
#endif

//提示框 
#ifndef BPAlert
#define BPAlert(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:bp_alert_title message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:bp_alert_cancelText otherButtonTitles:nil]; [alert show]; }
#endif

//设置加载提示框（第三方框架：Toast）
#define kToast(str)              CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
    [kWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
    kWindow.userInteractionEnabled = NO; \
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
    kWindow.userInteractionEnabled = YES;\
});\

//DEBUG 模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define BPAlertLog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif

#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)

/**DEBUG*/
// DebugBreak()
#if TARGET_IPHONE_SIMULATOR
// simulator
#define DebugBreak() kill(getpid(),SIGINT)
#else
// device
#define DebugBreak()
#endif

#if DEBUG
#define BPRequiredCast(id, _class) (assert([(id) isKindOfClass:[_class class]]), ((_class*)id))
#else
#define BPRequiredCast(id, _class) ((_class*)id)
#endif

//注意不要用＃ifdef TARGET_IPHONE_SIMULATOR, 因为在device上， TARGET_IPHONE_SIMULATOR被定义为0。
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif

//使用 ARC 和 MRC
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

#endif /* BPAppToolMacro_h */
