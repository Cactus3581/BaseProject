//
//  UIAlertView+BPAdd.m
//  RedEnvelopes
//
//  Created by xiaruzhen on 16/3/21.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "UIAlertView+BPAdd.h"
#import "NSObject+BPAdd.h"
#import <objc/runtime.h>
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UIAlertView_BPAdd)

@interface _BPAlertDelegateObject : NSObject<UIAlertViewDelegate>

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;

+ (instancetype)bp_initWithLeftBlock:(dispatch_block_t)leftBlock rightBlock:(dispatch_block_t)rightBlock;

@end

@implementation _BPAlertDelegateObject

+ (instancetype)bp_initWithLeftBlock:(dispatch_block_t)leftBlock rightBlock:(dispatch_block_t)rightBlock{
    _BPAlertDelegateObject *obj = [_BPAlertDelegateObject new];
    obj.leftBlock = leftBlock;
    obj.rightBlock = rightBlock;
    return obj;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_leftBlock && buttonIndex == 0) {
        _leftBlock();
        return;
    }
    if (_rightBlock && buttonIndex == 1) {
        _rightBlock();
        return;
    }
}

@end

@implementation UIAlertView (BPAdd)

+(void)bp_showAlertViewWith:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonClickedConfig:(dispatch_block_t)leftBlock rightButtonTitle:(NSString *)rightButtonTitle rightButtonClickedConfig:(dispatch_block_t)rightBlock{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:leftButtonTitle, rightButtonTitle, nil];
    _BPAlertDelegateObject *obj = [_BPAlertDelegateObject bp_initWithLeftBlock:leftBlock rightBlock:rightBlock];
    alertView.delegate = obj;
    [alertView bp_setAssociateValue:obj withKey:"_BPAlertDelegateObject"];
    [alertView show];
}

+ (void)bp_showOneAlertViewWith:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonClickedConfig:(dispatch_block_t)block{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:buttonTitle, nil];
    _BPAlertDelegateObject *obj = [_BPAlertDelegateObject bp_initWithLeftBlock:block rightBlock:nil];
    alertView.delegate = obj;
    [alertView bp_setAssociateValue:obj withKey:"_BPAlertDelegateObject"];
    [alertView show];
}

@end
