//
// UITextField+Blocks.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UITextField+JKBlocks.h"
#import <objc/runtime.h>
typedef BOOL (^JKUITextFieldReturnBlock) (UITextField *textField);
typedef void (^JKUITextFieldVoidBlock) (UITextField *textField);
typedef BOOL (^JKUITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (JKBlocks)
static const void *JKUITextFieldDelegateKey = &JKUITextFieldDelegateKey;
static const void *JKUITextFieldShouldBeginEditingKey = &JKUITextFieldShouldBeginEditingKey;
static const void *JKUITextFieldShouldEndEditingKey = &JKUITextFieldShouldEndEditingKey;
static const void *JKUITextFieldDidBeginEditingKey = &JKUITextFieldDidBeginEditingKey;
static const void *JKUITextFieldDidEndEditingKey = &JKUITextFieldDidEndEditingKey;
static const void *JKUITextFieldShouldChangeCharactersInRangeKey = &JKUITextFieldShouldChangeCharactersInRangeKey;
static const void *JKUITextFieldShouldClearKey = &JKUITextFieldShouldClearKey;
static const void *JKUITextFieldShouldReturnKey = &JKUITextFieldShouldReturnKey;
#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    JKUITextFieldReturnBlock block = textField.bp_shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, JKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    JKUITextFieldReturnBlock block = textField.bp_shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, JKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDidBeginEditing:(UITextField *)textField
{
   JKUITextFieldVoidBlock block = textField.bp_didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, JKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(UITextField *)textField
{
    JKUITextFieldVoidBlock block = textField.bp_didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, JKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    JKUITextFieldCharacterChangeBlock block = textField.bp_shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, JKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(UITextField *)textField
{
    JKUITextFieldReturnBlock block = textField.bp_shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, JKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    JKUITextFieldReturnBlock block = textField.bp_shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, JKUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}
#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))bp_shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, JKUITextFieldShouldBeginEditingKey);
}
- (void)setBp_shouldBegindEditingBlock:(BOOL (^)(UITextField *))shouldBegindEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, JKUITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bp_shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, JKUITextFieldShouldEndEditingKey);
}
- (void)setBp_shouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, JKUITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))bp_didBeginEditingBlock
{
    return objc_getAssociatedObject(self, JKUITextFieldDidBeginEditingKey);
}
- (void)setBp_didBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, JKUITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))bp_didEndEditingBlock
{
    return objc_getAssociatedObject(self, JKUITextFieldDidEndEditingKey);
}
- (void)setBp_didEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, JKUITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *, NSRange, NSString *))bp_shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, JKUITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setBp_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, JKUITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bp_shouldReturnBlock
{
    return objc_getAssociatedObject(self, JKUITextFieldShouldReturnKey);
}
- (void)setBp_shouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, JKUITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bp_shouldClearBlock
{
    return objc_getAssociatedObject(self, JKUITextFieldShouldClearKey);
}
- (void)setBp_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, JKUITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}
#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)bp_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, JKUITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
@end
