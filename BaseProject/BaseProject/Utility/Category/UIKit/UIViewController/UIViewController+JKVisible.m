//
//  UIViewController+JKVisible.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UIViewController+JKVisible.h"

@implementation UIViewController (JKVisible)
- (BOOL)bp_isVisible {
    return [self isViewLoaded] && self.view.window;
}
@end
