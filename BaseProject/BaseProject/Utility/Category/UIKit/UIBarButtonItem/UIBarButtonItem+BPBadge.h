//
//  UIBarButtonItem+Badge.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BPBadge)

@property (strong, atomic) UILabel *bp_badge;

// Badge value to be display
@property (nonatomic) NSString *bp_badgeValue;
// Badge background color
@property (nonatomic) UIColor *bp_badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *bp_badgeTextColor;
// Badge font
@property (nonatomic) UIFont *bp_badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat bp_badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat bp_badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat bp_badgeOriginX;
@property (nonatomic) CGFloat bp_badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL bp_shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL bp_shouldAnimateBadge;

@end
