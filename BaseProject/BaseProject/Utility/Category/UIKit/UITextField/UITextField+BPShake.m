//
//  UITextField+Shake.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UITextField+BPShake.h"

@implementation UITextField (BPShake)

- (void)bp_shake {
    [self bp_shake:10 withDelta:5 completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta {
    [self bp_shake:times withDelta:delta completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta completion:(void(^)(void))handler {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:0.03 shakeDirection:BPShakedDirectionHorizontal completion:handler];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval {
    [self bp_shake:times withDelta:delta speed:interval completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval completion:(void(^)(void))handler {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:BPShakedDirectionHorizontal completion:handler];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(BPShakedDirection)shakeDirection {
    [self bp_shake:times withDelta:delta speed:interval shakeDirection:shakeDirection completion:nil];
}

- (void)bp_shake:(int)times withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(BPShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [self _bp_shake:times direction:1 currentTimes:0 withDelta:delta speed:interval shakeDirection:shakeDirection completion:handler];
}

- (void)_bp_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta speed:(NSTimeInterval)interval shakeDirection:(BPShakedDirection)shakeDirection completion:(void(^)(void))handler {
    [UIView animateWithDuration:interval animations:^{
        self.transform = (shakeDirection == BPShakedDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (handler) {
                    handler();
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
          completion:handler];
    }];
}

@end
