//
//  UIView+BPAdd.m
//  RedEnvelopes
//
//  Created by xiaruzhen on 16/3/9.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import "UIView+BPAdd.h"
#import "CALayer+BPAdd.h"
#import "NSObject+BPAdd.h"
#import "UIView+BPAddForFrame.h"
#import <objc/runtime.h>
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UIView_BPAdd)

@implementation UIView (BPAdd)

+ (void)load{
    [self bp_swizzleInstanceMethod:@selector(layoutSublayersOfLayer:) with:@selector(_bp_layoutSublayersOfLayer:)];
//    [self bp_swizzleInstanceMethod:@selector(hitTest:withEvent:) with:@selector(_bp_hitTest:withEvent:)];
    [self bp_swizzleInstanceMethod:@selector(pointInside:withEvent:) with:@selector(_bp_pointInside:withEvent:)];
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)rightFromSuperView{
    if (!self.superview) return 0;
    return self.superview.width - self.right;
}

- (void)setRightFromSuperView:(CGFloat)rightFromSuperView{
    if (!self.superview) return;
    self.y = self.superview.width - self.width - rightFromSuperView;
}

- (CGFloat)bottomFromSuperView{
    if (!self.superview) return 0;
    return self.superview.height - self.bottom;
}

- (void)setBottomFromSuperView:(CGFloat)bottomFromSuperView{
    if (!self.superview) return;
    self.y = self.superview.height - self.height - bottomFromSuperView;
}

- (void)setEndEditingBeforTouch:(BOOL)bp_endEditingBeforTouch{
    [self bp_setAssociateValue:@(bp_endEditingBeforTouch) withKey:"bp_endEditingBeforTouch"];
}

- (void)setTouchBlock:(dispatch_block_t)touchBlock{
    [self bp_setAssociateCopyValue:touchBlock withKey:"bp_touchBlock"];
}

- (BOOL)endEditingBeforTouch{
    return [[self bp_getAssociatedValueForKey:"bp_endEditingBeforTouch"] boolValue];
}

- (dispatch_block_t)touchBlock{
    return [self bp_getAssociatedValueForKey:"bp_touchBlock"];
}

+ (instancetype)bp_tempViewForFrameWithBlock:(BPAddViewBlock)block{
    UIView *view = [self new];
    [view bp_setAssociateValue:block withKey:"BPAddViewBlock"];
    return view;
}

- (void)setExternalTouchInset:(UIEdgeInsets)externalTouchInset{
    [self bp_setAssociateValue:[NSValue valueWithUIEdgeInsets:externalTouchInset] withKey:"bp_externalTouchInset"];
}

- (UIEdgeInsets)externalTouchInset{
    return [[self bp_getAssociatedValueForKey:"bp_externalTouchInset"] UIEdgeInsetsValue];
}

- (NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)bp_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates{
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (void)bp_shadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius {
    [self.layer bp_shadowWithColor:color offset:offset radius:radius];
}

- (void)bp_anchorPointChangedToPoint:(CGPoint)point {
    [self.layer bp_anchorPointChangedToPoint:point];
}

- (void)bp_removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}



#pragma mark - exchanged methods

- (void)_bp_layoutSublayersOfLayer:(CALayer *)layer{
    [self _bp_layoutSublayersOfLayer:layer];
    BPAddViewBlock block = [layer bp_getAssociatedValueForKey:"BPAddViewBlock"];
    if (block) {
        block(self.frame);
        block = nil;
        objc_removeAssociatedObjects(layer);
        [self removeFromSuperview];
    }
}

- (BOOL)_bp_pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    if (UIEdgeInsetsEqualToEdgeInsets(self.externalTouchInset, UIEdgeInsetsZero)) {
        return [self _bp_pointInside:point withEvent:event];
    }
    CGRect externalFrame = CGRectMake(-self.externalTouchInset.left, -self.externalTouchInset.top, self.bp_width + (self.externalTouchInset.left + self.externalTouchInset.right), self.bp_height + self.externalTouchInset.top + self.externalTouchInset.bottom);
    return CGRectContainsPoint(externalFrame, point);
    
}

//- (UIView *)_bp_hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if ([self isKindOfClass:NSClassFromString(@"BPSearchView")]) {
//        NSLog(@"1");
//    }
//    
//    UIView *view = [self _bp_hitTest:point withEvent:event];
//    if ([view isKindOfClass:NSClassFromString(@"BPSearchView")]) {
//        NSLog(@"2");
//    }
//    doBlock(self.touchBlock);
//    if (self.endEditingBeforTouch) {
//        if ([view isKindOfClass:[UITextField class]] || [view isKindOfClass:[UITextView class]] || [view isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")]) {
//            return view;
//        }else{
//            [self endEditing:YES];
//            return view;
//        }
//    }else{
//        return view;
//    }
//}

@end
