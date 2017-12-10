//
//  UIButton+MiddleAligning.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 A category on UIButton that provides a simple yet powerful interface to middle aligning imageView and titleLabel
 */
@interface UIButton (BPMiddleAligning)

/**
 @param spacing The middle spacing between imageView and titleLabel.
 @discussion The middle aligning method for imageView and titleLabel.
 */
- (void)bp_middleAlignButtonWithSpacing:(CGFloat)spacing;

@end
