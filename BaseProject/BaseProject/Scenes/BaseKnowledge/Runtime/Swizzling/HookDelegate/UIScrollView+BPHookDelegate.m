//
//  UIScrollView+BPHookDelegate.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/10/26.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "UIScrollView+BPHookDelegate.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+BPSwizzling.h"

@implementation UIScrollView (BPHookDelegate)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        [self bp_swizzleInstanceMethodWithClass:[self class] originalSelector:@selector(setDelegate:) swizzledSelector:@selector(bp_setDelegate:)];
    });
}

- (void)bp_setDelegate:(id)delegate {
    [self bp_setDelegate:delegate];
    // 进一步交换 delegateClass 的代理方法
    [[self class] bp_swizzleDelegateMethodWithOrigClass:[delegate class] origSelector:@selector(scrollViewDidScroll:) swizClass:[self class] swizSelector:@selector(bp_scrollViewDidScroll:) placedSelector:@selector(add_scrollViewDidScroll:)];
}

- (void)bp_scrollViewDidScroll:(UIScrollView *)scrollView {
    [self bp_scrollViewDidScroll:scrollView];
    BPLog(@"滚动ing");
}

- (void)add_scrollViewDidScroll:(UIScrollView *)scrollView {
    BPLog(@"滚动ing");
}

@end
