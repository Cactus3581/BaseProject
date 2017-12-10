//
//  UIControl+JKBlock.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIControl (JKBlock)

- (void)bp_touchDown:(void (^)(void))eventBlock;
- (void)bp_touchDownRepeat:(void (^)(void))eventBlock;
- (void)bp_touchDragInside:(void (^)(void))eventBlock;
- (void)bp_touchDragOutside:(void (^)(void))eventBlock;
- (void)bp_touchDragEnter:(void (^)(void))eventBlock;
- (void)bp_touchDragExit:(void (^)(void))eventBlock;
- (void)bp_touchUpInside:(void (^)(void))eventBlock;
- (void)bp_touchUpOutside:(void (^)(void))eventBlock;
- (void)bp_touchCancel:(void (^)(void))eventBlock;
- (void)bp_valueChanged:(void (^)(void))eventBlock;
- (void)bp_editingDidBegin:(void (^)(void))eventBlock;
- (void)bp_editingChanged:(void (^)(void))eventBlock;
- (void)bp_editingDidEnd:(void (^)(void))eventBlock;
- (void)bp_editingDidEndOnExit:(void (^)(void))eventBlock;

@end
