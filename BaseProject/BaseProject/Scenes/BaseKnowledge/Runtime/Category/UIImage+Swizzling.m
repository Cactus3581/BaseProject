//
//  UIImage+Swizzling.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/15.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "UIImage+Swizzling.h"
#import <objc/runtime.h>

@implementation UIImage (Swizzling)

// 加载分类到内存的时候调用
+ (void)load {
    
    // 获取imageNamed方法地址
    Method originalMethod = class_getClassMethod(self, @selector(imageNamed:));
    // 获取imageWithName方法地址
    Method swizzledMethod = class_getClassMethod(self, @selector(imageWithName:));
    
    
    // 要先尝试添加原 selector 是为了做一层保护，因为如果这个类没有实现 originalSelector ，但其父类实现了，那 class_getInstanceMethod 会返回父类的方法。这样 method_exchangeImplementations 替换的是父类的那个方法，这当然不是你想要的。所以我们先尝试添加 orginalSelector ，如果已经存在，再用 method_exchangeImplementations 把原方法的实现跟新的方法实现给交换掉。
    BOOL didAddMethod = class_addMethod(self, @selector(imageNamed:), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // 如果原始方法不存在
    if (didAddMethod) {
        class_replaceMethod(self, @selector(imageWithName:), method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        // 交换方法地址，相当于交换实现方式
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

// 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.

// 既能加载图片又能打印
+ (instancetype)imageWithName:(NSString *)name {
    // 这里调用imageWithName，相当于调用imageName
    UIImage *image = [self imageWithName:name];
    
    if (image == nil) {
        //BPLog(@"加载空的图片");
    }
    return image;
}


@end
