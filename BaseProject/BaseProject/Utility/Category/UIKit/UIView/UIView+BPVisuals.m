//
//  UIView+Visuals.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPVisuals.h"

// Degree -> Rad
#define bp_degToRad(x) (M_PI * (x) / 180.0)

@implementation UIView (BPVisuals)

- (void)bp_cornerRadius: (CGFloat)radius strokeSize: (CGFloat)size color: (UIColor *)color
{
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = size;
}

- (void)bp_setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    CGRect rect = self.bounds;
    
    // Create the path
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:corners
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the view's layer
    self.layer.mask = maskLayer;
}

- (void)bp_shadowWithColor: (UIColor *)color
                offset: (CGSize)offset 
               opacity: (CGFloat)opacity 
                radius: (CGFloat)radius
{
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

- (void)bp_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration
{
    [UIView beginAnimations: nil context: NULL];
	[UIView setAnimationBeginsFromCurrentState: YES];
	[UIView setAnimationDuration: duration];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector: @selector(removeFromSuperview)];
    self.alpha = 0.0;
	[UIView commitAnimations];	
}


- (void)bp_addSubview: (UIView *)subview withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration
{
	[UIView beginAnimations: nil context: NULL];
	[UIView setAnimationDuration: duration];
	[UIView setAnimationTransition: transition forView: self cache: YES];
	[self addSubview: subview];
	[UIView commitAnimations];
}


- (void)bp_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration
{
	[UIView beginAnimations: nil context: NULL];
	[UIView setAnimationDuration: duration];
	[UIView setAnimationTransition: transition forView: self.superview cache: YES];
	[self removeFromSuperview];
	[UIView commitAnimations];
}


- (void)bp_rotateByAngle: (CGFloat)angle
            duration: (NSTimeInterval)duration 
         autoreverse: (BOOL)autoreverse
         repeatCount: (CGFloat)repeatCount
      timingFunction: (CAMediaTimingFunction *)timingFunction
{
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath: @"transform.rotation"];
    rotation.toValue = [NSNumber numberWithFloat: bp_degToRad(angle)];
    rotation.duration = duration;
    rotation.repeatCount = repeatCount;
    rotation.autoreverses = autoreverse;
    rotation.removedOnCompletion = NO;
	rotation.fillMode = kCAFillModeBoth;
	rotation.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation: rotation forKey: @"rotationAnimation"];
}


- (void)bp_moveToPoint: (CGPoint)newPoint 
          duration: (NSTimeInterval)duration 
       autoreverse: (BOOL)autoreverse
       repeatCount: (CGFloat)repeatCount
    timingFunction: (CAMediaTimingFunction *)timingFunction
{
    CABasicAnimation *move = [CABasicAnimation animationWithKeyPath: @"position"];
    move.toValue = [NSValue valueWithCGPoint: newPoint];
    move.duration = duration;
    move.removedOnCompletion = NO;
    move.repeatCount = repeatCount;
    move.autoreverses = autoreverse;
	move.fillMode = kCAFillModeBoth;
	move.timingFunction = timingFunction != nil ? timingFunction : [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation: move forKey: @"positionAnimation"];
}


@end
