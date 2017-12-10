//
//  UINavigationController+KeyboardFix.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UINavigationController+BPKeyboardFix.h"

@implementation UINavigationController (BPKeyboardFix)

// This fixes an issue with the keyboard not dismissing on the iPad's login screen.
// http://stackoverflow.com/questions/3372333/ipad-keyboard-will-not-dismiss-if-modal-view-controller-presentation-style-is-ui/3386768#3386768
// http://developer.apple.com/library/ios/#documentation/uikit/reference/UIViewController_Class/Reference/Reference.html

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

@end
