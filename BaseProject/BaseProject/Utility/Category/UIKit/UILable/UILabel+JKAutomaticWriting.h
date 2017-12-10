//
//  UILabel+AutomaticWriting.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for UILabel-AutomaticWriting.
FOUNDATION_EXPORT double UILabelAutomaticWritingVersionNumber;

//! Project version string for UILabel-AutomaticWriting.
FOUNDATION_EXPORT const unsigned char UILabelAutomaticWritingVersionString[];

extern NSTimeInterval const UILabelAWDefaultDuration;

extern unichar const UILabelAWDefaultCharacter;

typedef NS_ENUM(NSInteger, UILabelJKlinkingMode)
{
    UILabelJKlinkingModeNone,
    UILabelJKlinkingModeUntilFinish,
    UILabelJKlinkingModeUntilFinishKeeping,
    UILabelJKlinkingModeWhenFinish,
    UILabelJKlinkingModeWhenFinishShowing,
    UILabelJKlinkingModeAlways
};

@interface UILabel (JKAutomaticWriting)

@property (strong, nonatomic) NSOperationQueue *bp_automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets bp_edgeInsets;

- (void)bp_setTextWithAutomaticWritingAnimation:(NSString *)text;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelJKlinkingMode)blinkingMode;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelJKlinkingMode)blinkingMode;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelJKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelJKlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;

@end
