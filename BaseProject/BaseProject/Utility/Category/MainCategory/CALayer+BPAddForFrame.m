
//
//  CALayer+BPAddForFrame.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "CALayer+BPAddForFrame.h"
#import "NSObject+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(CALayer_BPAddForFrame)


@implementation CALayer (BPAddForFrame)

- (CGFloat)bp_left {
    return self.frame.origin.x;
}

- (void)setBp_left:(CGFloat)bp_left {
    if (self.bp_left == bp_left) return;
    [self bp_setAssociateValue:@(bp_left) withKey:@"bp_left"];
    NSNumber *bp_right = [self bp_getAssociatedValueForKey:@"bp_right"];
    NSNumber *bp_width = [self bp_getAssociatedValueForKey:@"bp_width"];
    NSNumber *bp_centerX = [self bp_getAssociatedValueForKey:@"bp_centerX"];
    CGRect frame = self.frame;
    if (bp_right && !bp_width && !bp_centerX) {
        frame.size.width = bp_right.floatValue - bp_left;
    }else if (bp_centerX && !bp_width && !bp_right){
        frame.size.width = (bp_centerX.floatValue - bp_left) * 2.0f;
    }
    frame.origin.x = bp_left;
    self.frame = frame;
}

- (CGFloat)bp_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBp_right:(CGFloat)bp_right {
    if (self.bp_right == bp_right) return;
    [self bp_setAssociateValue:@(bp_right) withKey:@"bp_right"];
    NSNumber *bp_left = [self bp_getAssociatedValueForKey:@"bp_left"];
    NSNumber *bp_width = [self bp_getAssociatedValueForKey:@"bp_width"];
    NSNumber *bp_centerX = [self bp_getAssociatedValueForKey:@"bp_centerX"];
    CGRect frame = self.frame;
    if (bp_centerX && !bp_width && !bp_left){
        frame.size.width = (bp_right - bp_centerX.floatValue) * 2.0f;
    }else if (bp_left && !bp_width && !bp_centerX){
        frame.size.width = bp_right - bp_left.floatValue;
    }
    frame.origin.x = bp_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bp_width {
    return self.frame.size.width;
}

- (void)setBp_width:(CGFloat)bp_width {
    if (self.bp_width == bp_width) return;
    [self bp_setAssociateValue:@(bp_width) withKey:@"bp_width"];
    NSNumber *bp_left = [self bp_getAssociatedValueForKey:@"bp_left"];
    NSNumber *bp_right = [self bp_getAssociatedValueForKey:@"bp_right"];
    NSNumber *bp_centerX = [self bp_getAssociatedValueForKey:@"bp_centerX"];
    CGRect frame = self.frame;
    if (!bp_left && !bp_right && bp_centerX) {
        frame.origin.x = bp_centerX.floatValue - bp_width / 2.0f;
    }else if (!bp_left && !bp_centerX && bp_right){
        frame.origin.x = bp_right.floatValue - bp_width;
    }
    frame.size.width = bp_width;
    self.frame = frame;
}

- (CGFloat)bp_centerX {
    return self.position.x;
}

- (void)setBp_centerX:(CGFloat)bp_centerX {
    if (self.bp_centerX == bp_centerX) return;
    [self bp_setAssociateValue:@(bp_centerX) withKey:@"bp_centerX"];
    NSNumber *bp_left = [self bp_getAssociatedValueForKey:@"bp_left"];
    NSNumber *bp_right = [self bp_getAssociatedValueForKey:@"bp_right"];
    NSNumber *bp_width = [self bp_getAssociatedValueForKey:@"bp_width"];
    CGRect frame = self.frame;
    if (bp_right && !bp_left && !bp_width) {
        frame.size.width = (bp_right.floatValue - bp_centerX) * 2.0f;
    }else if (bp_left && !bp_right && !bp_width){
        frame.size.width = (bp_centerX - bp_left.floatValue) * 2.0f;
    }
    self.frame = frame;
    self.position = CGPointMake(bp_centerX, self.position.y);
    
}

- (CGFloat)bp_top {
    return self.frame.origin.y;
}

- (void)setBp_top:(CGFloat)bp_top {
    if (self.bp_top == bp_top) return;
    [self bp_setAssociateValue:@(bp_top) withKey:@"bp_top"];
    NSNumber *bp_bottom = [self bp_getAssociatedValueForKey:@"bp_bottom"];
    NSNumber *bp_height = [self bp_getAssociatedValueForKey:@"bp_height"];
    NSNumber *bp_centerY = [self bp_getAssociatedValueForKey:@"bp_centerY"];
    CGRect frame = self.frame;
    if (bp_bottom && !bp_height && !bp_centerY) {
        frame.size.height = bp_bottom.floatValue - bp_top;
    }else if (bp_centerY && !bp_height && !bp_bottom){
        frame.size.height = (bp_centerY.floatValue - bp_top) * 2.0f;
    }
    frame.origin.y = bp_top;
    self.frame = frame;
}

- (CGFloat)bp_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBp_bottom:(CGFloat)bp_bottom {
    if (self.bp_bottom == bp_bottom) return;
    [self bp_setAssociateValue:@(bp_bottom) withKey:@"bp_bottom"];
    NSNumber *bp_top = [self bp_getAssociatedValueForKey:@"bp_top"];
    NSNumber *bp_height = [self bp_getAssociatedValueForKey:@"bp_height"];
    NSNumber *bp_centerY = [self bp_getAssociatedValueForKey:@"bp_centerY"];
    CGRect frame = self.frame;
    if (bp_centerY && !bp_height && !bp_top){
        frame.size.height = (bp_bottom - bp_centerY.floatValue) * 2.0f;
    }else if (bp_top && !bp_height && !bp_centerY){
        frame.size.height = bp_bottom - bp_top.floatValue;
    }
    frame.origin.y = bp_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bp_height {
    return self.frame.size.height;
}

- (void)setBp_height:(CGFloat)bp_height {
    if (self.bp_height == bp_height) return;
    [self bp_setAssociateValue:@(bp_height) withKey:@"bp_height"];
    NSNumber *bp_top = [self bp_getAssociatedValueForKey:@"bp_top"];
    NSNumber *bp_bottom = [self bp_getAssociatedValueForKey:@"bp_bottom"];
    NSNumber *bp_centerY = [self bp_getAssociatedValueForKey:@"bp_centerY"];
    CGRect frame = self.frame;
    if (!bp_top && !bp_bottom && bp_centerY) {
        frame.origin.y = bp_centerY.floatValue - bp_height / 2.0f;
    }else if (!bp_top && !bp_centerY && bp_bottom){
        frame.origin.y = bp_bottom.floatValue - bp_height;
    }
    frame.size.height = bp_height;
    self.frame = frame;
}

- (CGFloat)bp_centerY {
    return self.position.y;
}

- (void)setBp_centerY:(CGFloat)bp_centerY {
    if (self.bp_centerY == bp_centerY) return;
    [self bp_setAssociateValue:@(bp_centerY) withKey:@"bp_centerY"];
    NSNumber *bp_top = [self bp_getAssociatedValueForKey:@"bp_top"];
    NSNumber *bp_bottom = [self bp_getAssociatedValueForKey:@"bp_bottom"];
    NSNumber *bp_height = [self bp_getAssociatedValueForKey:@"bp_height"];
    CGRect frame = self.frame;
    if (bp_bottom && !bp_top && !bp_height) {
        frame.size.height = (bp_bottom.floatValue - bp_centerY) * 2.0f;
    }else if (bp_top && !bp_bottom && !bp_height){
        frame.size.height = (bp_centerY - bp_top.floatValue) * 2.0f;
    }
    self.frame = frame;
    self.position = CGPointMake(self.position.x, bp_centerY);
}

- (CGPoint)bp_origin {
    return self.frame.origin;
}

- (void)setBp_origin:(CGPoint)origin {
    [self setBp_left:origin.x];
    [self setBp_top:origin.y];
}

- (CGSize)bp_size {
    return self.frame.size;
}

- (void)setBp_size:(CGSize)size {
    [self setBp_width:size.width];
    [self setBp_height:size.height];
}

- (CGPoint)bp_center{
    return self.position;
}

- (void)setBp_center:(CGPoint)bp_center{
    [self setBp_centerX:bp_center.x];
    [self setBp_centerY:bp_center.y];
}

- (CGRect)bp_frame{
    return self.frame;
}

- (void)setBp_frame:(CGRect)bp_frame{
    [self setBp_left:bp_frame.origin.x];
    [self setBp_top:bp_frame.origin.y];
    [self setBp_width:bp_frame.size.width];
    [self setBp_height:bp_frame.size.height];
}

@end
