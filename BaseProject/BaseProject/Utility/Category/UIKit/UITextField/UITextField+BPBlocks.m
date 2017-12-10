//
// UITextField+Blocks.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UITextField+BPBlocks.h"
#import <objc/runtime.h>
typedef BOOL (^BPUITextFieldReturnBlock) (UITextField *textField);
typedef void (^BPUITextFieldVoidBlock) (UITextField *textField);
typedef BOOL (^BPUITextFieldCharacterChangeBlock) (UITextField *textField, NSRange range, NSString *replacementString);
@implementation UITextField (BPBlocks)
static const void *BPUITextFieldDelegateKey = &BPUITextFieldDelegateKey;
static const void *BPUITextFieldShouldBeginEditingKey = &BPUITextFieldShouldBeginEditingKey;
static const void *BPUITextFieldShouldEndEditingKey = &BPUITextFieldShouldEndEditingKey;
static const void *BPUITextFieldDidBeginEditingKey = &BPUITextFieldDidBeginEditingKey;
static const void *BPUITextFieldDidEndEditingKey = &BPUITextFieldDidEndEditingKey;
static const void *BPUITextFieldShouldChangeCharactersInRangeKey = &BPUITextFieldShouldChangeCharactersInRangeKey;
static const void *BPUITextFieldShouldClearKey = &BPUITextFieldShouldClearKey;
static const void *BPUITextFieldShouldReturnKey = &BPUITextFieldShouldReturnKey;
#pragma mark UITextField Delegate methods
+ (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BPUITextFieldReturnBlock block = textField.bp_shouldBegindEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BPUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [delegate textFieldShouldBeginEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BPUITextFieldReturnBlock block = textField.bp_shouldEndEditingBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BPUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [delegate textFieldShouldEndEditing:textField];
    }
    // return default value just in case
    return YES;
}
+ (void)textFieldDidBeginEditing:(UITextField *)textField
{
   BPUITextFieldVoidBlock block = textField.bp_didBeginEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BPUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (void)textFieldDidEndEditing:(UITextField *)textField
{
    BPUITextFieldVoidBlock block = textField.bp_didEndEditingBlock;
    if (block) {
        block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BPUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [delegate textFieldDidBeginEditing:textField];
    }
}
+ (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BPUITextFieldCharacterChangeBlock block = textField.bp_shouldChangeCharactersInRangeBlock;
    if (block) {
        return block(textField,range,string);
    }
    id delegate = objc_getAssociatedObject(self, BPUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}
+ (BOOL)textFieldShouldClear:(UITextField *)textField
{
    BPUITextFieldReturnBlock block = textField.bp_shouldClearBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BPUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [delegate textFieldShouldClear:textField];
    }
    return YES;
}
+ (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BPUITextFieldReturnBlock block = textField.bp_shouldReturnBlock;
    if (block) {
        return block(textField);
    }
    id delegate = objc_getAssociatedObject(self, BPUITextFieldDelegateKey);
    if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [delegate textFieldShouldReturn:textField];
    }
    return YES;
}
#pragma mark Block setting/getting methods
- (BOOL (^)(UITextField *))bp_shouldBegindEditingBlock
{
    return objc_getAssociatedObject(self, BPUITextFieldShouldBeginEditingKey);
}
- (void)setBp_shouldBegindEditingBlock:(BOOL (^)(UITextField *))shouldBegindEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BPUITextFieldShouldBeginEditingKey, shouldBegindEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bp_shouldEndEditingBlock
{
    return objc_getAssociatedObject(self, BPUITextFieldShouldEndEditingKey);
}
- (void)setBp_shouldEndEditingBlock:(BOOL (^)(UITextField *))shouldEndEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BPUITextFieldShouldEndEditingKey, shouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))bp_didBeginEditingBlock
{
    return objc_getAssociatedObject(self, BPUITextFieldDidBeginEditingKey);
}
- (void)setBp_didBeginEditingBlock:(void (^)(UITextField *))didBeginEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BPUITextFieldDidBeginEditingKey, didBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (void (^)(UITextField *))bp_didEndEditingBlock
{
    return objc_getAssociatedObject(self, BPUITextFieldDidEndEditingKey);
}
- (void)setBp_didEndEditingBlock:(void (^)(UITextField *))didEndEditingBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BPUITextFieldDidEndEditingKey, didEndEditingBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *, NSRange, NSString *))bp_shouldChangeCharactersInRangeBlock
{
    return objc_getAssociatedObject(self, BPUITextFieldShouldChangeCharactersInRangeKey);
}
- (void)setBp_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *, NSRange, NSString *))shouldChangeCharactersInRangeBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BPUITextFieldShouldChangeCharactersInRangeKey, shouldChangeCharactersInRangeBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bp_shouldReturnBlock
{
    return objc_getAssociatedObject(self, BPUITextFieldShouldReturnKey);
}
- (void)setBp_shouldReturnBlock:(BOOL (^)(UITextField *))shouldReturnBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BPUITextFieldShouldReturnKey, shouldReturnBlock, OBJC_ASSOCIATION_COPY);
}
- (BOOL (^)(UITextField *))bp_shouldClearBlock
{
    return objc_getAssociatedObject(self, BPUITextFieldShouldClearKey);
}
- (void)setBp_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock
{
    [self bp_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, BPUITextFieldShouldClearKey, shouldClearBlock, OBJC_ASSOCIATION_COPY);
}
#pragma mark control method
/*
 Setting itself as delegate if no other delegate has been set. This ensures the UITextField will use blocks if no delegate is set.
 */
- (void)bp_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UITextFieldDelegate>)[self class]) {
        objc_setAssociatedObject(self, BPUITextFieldDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITextFieldDelegate>)[self class];
    }
}
@end
