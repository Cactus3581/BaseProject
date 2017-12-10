//
//  UIView+Visuals.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface UIView (BPVisuals)

/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)bp_cornerRadius: (CGFloat)radius
         strokeSize: (CGFloat)size 
              color: (UIColor *)color;
/*
 *  Sets a corners
 */
-(void)bp_setRoundedCorners:(UIRectCorner)corners
                  radius:(CGFloat)radius;

/*
 *  Draws shadow with properties
 */
-(void)bp_shadowWithColor: (UIColor *)color
                offset: (CGSize)offset 
               opacity: (CGFloat)opacity 
                radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)bp_removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)bp_addSubview: (UIView *)view withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
-(void)bp_removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)bp_rotateByAngle: (CGFloat)angle
            duration: (NSTimeInterval)duration 
         autoreverse: (BOOL)autoreverse
         repeatCount: (CGFloat)repeatCount
      timingFunction: (CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)bp_moveToPoint: (CGPoint)newPoint 
          duration: (NSTimeInterval)duration 
       autoreverse: (BOOL)autoreverse
       repeatCount: (CGFloat)repeatCount
    timingFunction: (CAMediaTimingFunction *)timingFunction;

@end
