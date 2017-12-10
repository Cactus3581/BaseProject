//
//  UIView+Animation.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

float bp_radiansForDegrees(int degrees);

@interface UIView (BPAnimation)

// Moves
- (void)bp_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)bp_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)bp_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)bp_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)bp_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)bp_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)bp_spinClockwise:(float)secs;
- (void)bp_spinCounterClockwise:(float)secs;

// Transitions
- (void)bp_curlDown:(float)secs;
- (void)bp_curlUpAndAway:(float)secs;
- (void)bp_drainAway:(float)secs;

// Effects
- (void)bp_changeAlpha:(float)newAlpha secs:(float)secs;
- (void)bp_pulse:(float)secs continuously:(BOOL)continuously;

//add subview
- (void)bp_addSubviewWithFadeAnimation:(UIView *)subview;

@end
