//
//  UIView+Shake.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPShake.h"

@implementation UIView (BPShake)

- (void)bp_shake {
    [self _bp_shake:10 direction:1 currentTimes:0 withDelta:5 speed:0.03 shakeDirection:BPShakeDirectionHorizontal completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:BPShakeDirectionHorizontal completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:BPShakeDirectionHorizontal completion:handler];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:BPShakeDirectionHorizontal completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:BPShakeDirectionHorizontal completion:handler];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(BPShakeDirection)shakeDirection {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(BPShakeDirection)shakeDirection completion:(void (^)(void))completion {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:completion];
}

- (void)_bp_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(BPShakeDirection)shakeDirection completion:(void (^)(void))completionHandler {
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == BPShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler != nil) {
                    completionHandler();
                }
            }];
            return;
        }
        [self _bp_shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
               speed:interval
      shakeDirection:shakeDirection
          completion:completionHandler];
    }];
}

@end
