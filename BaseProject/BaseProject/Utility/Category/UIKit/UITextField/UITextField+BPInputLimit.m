//
//  UITextField+BPInputLimit.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UITextField+BPInputLimit.h"
#import <objc/runtime.h>

static const void *BPTextFieldInputLimitMaxLength = &BPTextFieldInputLimitMaxLength;
@implementation UITextField (BPInputLimit)

- (NSInteger)bp_maxLength {
    return [objc_getAssociatedObject(self, BPTextFieldInputLimitMaxLength) integerValue];
}
- (void)setBp_maxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, BPTextFieldInputLimitMaxLength, @(maxLength), OBJC_ASSOCIATION_ASSIGN);
    [self addTarget:self action:@selector(bp_textFieldTextDidChange) forControlEvents:UIControlEventEditingChanged];
}
- (void)bp_textFieldTextDidChange {
    NSString *toBeString = self.text;
    //获取高亮部分
    UITextRange *selectedRange = [self markedTextRange];
    UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
    
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    //在iOS7下,position对象总是不为nil
    if ( (!position ||!selectedRange) && (self.bp_maxLength > 0 && toBeString.length > self.bp_maxLength))
    {
        NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:self.bp_maxLength];
        if (rangeIndex.length == 1)
        {
            self.text = [toBeString substringToIndex:self.bp_maxLength];
        }
        else
        {
            NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, self.bp_maxLength)];
            NSInteger tmpLength;
            if (rangeRange.length > self.bp_maxLength) {
                tmpLength = rangeRange.length - rangeIndex.length;
            }else{
                tmpLength = rangeRange.length;
            }
            self.text = [toBeString substringWithRange:NSMakeRange(0, tmpLength)];
        }
    }
}
@end
