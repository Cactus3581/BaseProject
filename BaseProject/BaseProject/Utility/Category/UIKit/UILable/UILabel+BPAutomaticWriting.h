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

typedef NS_ENUM(NSInteger, UILabelBPlinkingMode)
{
    UILabelBPlinkingModeNone,
    UILabelBPlinkingModeUntilFinish,
    UILabelBPlinkingModeUntilFinishKeeping,
    UILabelBPlinkingModeWhenFinish,
    UILabelBPlinkingModeWhenFinishShowing,
    UILabelBPlinkingModeAlways
};

@interface UILabel (BPAutomaticWriting)

@property (strong, nonatomic) NSOperationQueue *bp_automaticWritingOperationQueue;
@property (assign, nonatomic) UIEdgeInsets bp_edgeInsets;

- (void)bp_setTextWithAutomaticWritingAnimation:(NSString *)text;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelBPlinkingMode)blinkingMode;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelBPlinkingMode)blinkingMode;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelBPlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter;

- (void)bp_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelBPlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion;

@end
