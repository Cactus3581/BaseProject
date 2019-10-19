//
//  UITextField+Blocks.h
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BPBlocks)

@property (copy, nonatomic) BOOL (^bp_shouldBegindEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^bp_shouldEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^bp_didBeginEditingBlock)(UITextField *textField);
@property (copy, nonatomic) void (^bp_didEndEditingBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^bp_shouldChangeCharactersInRangeBlock)(UITextField *textField, NSRange range, NSString *replacementString);
@property (copy, nonatomic) BOOL (^bp_shouldReturnBlock)(UITextField *textField);
@property (copy, nonatomic) BOOL (^bp_shouldClearBlock)(UITextField *textField);

- (void)setBp_shouldBegindEditingBlock:(BOOL (^)(UITextField *textField))shouldBegindEditingBlock;
- (void)setBp_shouldEndEditingBlock:(BOOL (^)(UITextField *textField))shouldEndEditingBlock;
- (void)setBp_didBeginEditingBlock:(void (^)(UITextField *textField))didBeginEditingBlock;
- (void)setBp_didEndEditingBlock:(void (^)(UITextField *textField))didEndEditingBlock;
- (void)setBp_shouldChangeCharactersInRangeBlock:(BOOL (^)(UITextField *textField, NSRange range, NSString *string))shouldChangeCharactersInRangeBlock;
- (void)setBp_shouldClearBlock:(BOOL (^)(UITextField *textField))shouldClearBlock;
- (void)setBp_shouldReturnBlock:(BOOL (^)(UITextField *textField))shouldReturnBlock;

@end
