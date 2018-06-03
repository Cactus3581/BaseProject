//
//  UIViewController+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/9/14.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIViewController+BPAdd.h"

@implementation UIViewController (BPAdd)

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

- (void)setAlertControllerTitleLabelTextAlignment:(NSTextAlignment)textAlignment {
    if (![self isKindOfClass:[UIAlertController class]]) {
        return;
    }
    UIView *messageParentView = [self getParentViewOfTitleAndMessageFromView:self.view];
    if (messageParentView && messageParentView.subviews.count > 1) {
        UILabel *messageLb = messageParentView.subviews[1];
        messageLb.textAlignment = textAlignment;
    }
}

- (UIView *)getParentViewOfTitleAndMessageFromView:(UIView *)view {
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            return view;
        }else{
            UIView *resultView = [self getParentViewOfTitleAndMessageFromView:subView];
            if (resultView) return resultView;
        }
    }
    return nil;
}

@end
