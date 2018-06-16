//
//  UIControl+BPBlock.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIControl+BPBlock.h"
#import <objc/runtime.h>


// UIControlEventTouchDown           = 1 <<  0,      // on all touch downs
// UIControlEventTouchDownRepeat     = 1 <<  1,      // on multiple touchdowns
// (tap count > 1)
// UIControlEventTouchDragInside     = 1 <<  2,
// UIControlEventTouchDragOutside    = 1 <<  3,
// UIControlEventTouchDragEnter      = 1 <<  4,
// UIControlEventTouchDragExit       = 1 <<  5,
// UIControlEventTouchUpInside       = 1 <<  6,
// UIControlEventTouchUpOutside      = 1 <<  7,
// UIControlEventTouchCancel         = 1 <<  8,
//
// UIControlEventValueChanged        = 1 << 12,     // sliders, etc.
//
// UIControlEventEditingDidBegin     = 1 << 16,     // UITextField
// UIControlEventEditingChanged      = 1 << 17,
// UIControlEventEditingDidEnd       = 1 << 18,
// UIControlEventEditingDidEndOnExit = 1 << 19,     // 'return key' ending
// editing
//
// UIControlEventAllTouchEvents      = 0x00000FFF,  // for touch events
// UIControlEventAllEditingEvents    = 0x000F0000,  // for UITextField
// UIControlEventApplicationReserved = 0x0F000000,  // range available for
// application use
// UIControlEventSystemReserved      = 0xF0000000,  // range reserved for
// internal framework use
// UIControlEventAllEvents           = 0xFFFFFFFF

#define BP_UICONTROL_EVENT(methodName, eventName)                                \
- (void)methodName : (void (^)(void))eventBlock {                              \
    objc_setAssociatedObject(self, @selector(methodName:), eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);\
    [self addTarget:self                                                        \
    action:@selector(methodName##Action:)                                       \
    forControlEvents:UIControlEvent##eventName];                                \
}                                                                               \
- (void)methodName##Action:(id)sender {                                        \
    void (^block)(void) = objc_getAssociatedObject(self, @selector(methodName:));  \
    if (block) {                                                                \
        block();                                                                \
    }                                                                           \
}

@interface UIControl ()

@end

@implementation UIControl (BPBlock)

BP_UICONTROL_EVENT(bp_touchDown, TouchDown)
BP_UICONTROL_EVENT(bp_touchDownRepeat, TouchDownRepeat)
BP_UICONTROL_EVENT(bp_touchDragInside, TouchDragInside)
BP_UICONTROL_EVENT(bp_touchDragOutside, TouchDragOutside)
BP_UICONTROL_EVENT(bp_touchDragEnter, TouchDragEnter)
BP_UICONTROL_EVENT(bp_touchDragExit, TouchDragExit)
BP_UICONTROL_EVENT(bp_touchUpInside, TouchUpInside)
BP_UICONTROL_EVENT(bp_touchUpOutside, TouchUpOutside)
BP_UICONTROL_EVENT(bp_touchCancel, TouchCancel)
BP_UICONTROL_EVENT(bp_valueChanged, ValueChanged)
BP_UICONTROL_EVENT(bp_editingDidBegin, EditingDidBegin)
BP_UICONTROL_EVENT(bp_editingChanged, EditingChanged)
BP_UICONTROL_EVENT(bp_editingDidEnd, EditingDidEnd)
BP_UICONTROL_EVENT(bp_editingDidEndOnExit, EditingDidEndOnExit)

//- (void)touchUpInside:(void (^)(void))eventBlock {
//   objc_setAssociatedObject(self, @selector(touchUpInside:, eventBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
//  [self addTarget:self action:@selector(touchUpInsideAction:)
//  forControlEvents:UIControlEventTouchUpInside];
//}
//- (void)touchUpInsideAction:(id)sender {
//  void (^block)() = objc_getAssociatedObject(self, @selector(touchUpInsideAction:));
//  if (block) {
//    block();
//  }
//}

@end
