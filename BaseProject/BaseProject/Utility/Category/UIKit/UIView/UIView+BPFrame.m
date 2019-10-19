//
//  UIView+BPFrame.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPFrame.h"

@implementation UIView (BPFrame)
#pragma mark - Shortcuts for the coords

- (CGFloat)bp_top
{
    return self.frame.origin.y;
}

- (void)setBp_top:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bp_right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setBp_right:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)bp_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBp_bottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)bp_left
{
    return self.frame.origin.x;
}

- (void)setBp_left:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)bp_width
{
    return self.frame.size.width;
}

- (void)setBp_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)bp_height
{
    return self.frame.size.height;
}

- (void)setBp_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

#pragma mark - Shortcuts for frame properties

- (CGPoint)bp_origin {
    return self.frame.origin;
}

- (void)setBp_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)bp_size {
    return self.frame.size;
}

- (void)setBp_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
#pragma mark - Shortcuts for positions

- (CGFloat)bp_centerX {
    return self.center.x;
}

- (void)setBp_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)bp_centerY {
    return self.center.y;
}

- (void)setBp_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

@end
