//
//  UIViewController+BPRemoveSelfFromNavi.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/9/14.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIViewController+BPRemoveSelfFromNavi.h"

@implementation UIViewController (BPRemoveSelfFromNavi)

- (void)removeSelf_from_naviViewControllers {
    if (self.navigationController) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[self class]]) {
                [array removeObject:obj];
                *stop = YES;
            }
        }];
        self.navigationController.viewControllers = array;
    }
}

@end

