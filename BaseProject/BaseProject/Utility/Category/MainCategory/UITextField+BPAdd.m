//
//  UITextField+BPAdd.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UITextField+BPAdd.h"
#import <objc/runtime.h>

@implementation UITextField (BPAdd)

- (void)setLeftInsert:(CGFloat)leftInsert{
    objc_setAssociatedObject(self, "bp_leftInsert", @(leftInsert), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIView *leftView = [UIView new];
    leftView.bounds = CGRectMake(0, 0, leftInsert, 1);
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGFloat)leftInsert{
    return [objc_getAssociatedObject(self, "bp_leftInsert") floatValue];
}
@end
