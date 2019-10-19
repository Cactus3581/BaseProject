//
//  UIBarButtonItem+Badge.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIBarButtonItem+BPBadge.h"
#import <objc/runtime.h>

NSString const *bp_UIBarButtonItem_badgeKey = @"bp_UIBarButtonItem_badgeKey";

NSString const *bp_UIBarButtonItem_badgeBGColorKey = @"bp_UIBarButtonItem_badgeBGColorKey";
NSString const *bp_UIBarButtonItem_badgeTextColorKey = @"bp_UIBarButtonItem_badgeTextColorKey";
NSString const *bp_UIBarButtonItem_badgeFontKey = @"bp_UIBarButtonItem_badgeFontKey";
NSString const *bp_UIBarButtonItem_badgePaddingKey = @"bp_UIBarButtonItem_badgePaddingKey";
NSString const *bp_UIBarButtonItem_badgeMinSizeKey = @"bp_UIBarButtonItem_badgeMinSizeKey";
NSString const *bp_UIBarButtonItem_badgeOriginXKey = @"bp_UIBarButtonItem_badgeOriginXKey";
NSString const *bp_UIBarButtonItem_badgeOriginYKey = @"bp_UIBarButtonItem_badgeOriginYKey";
NSString const *bp_UIBarButtonItem_shouldHideBadgeAtZeroKey = @"bp_UIBarButtonItem_shouldHideBadgeAtZeroKey";
NSString const *bp_UIBarButtonItem_shouldAnimateBadgeKey = @"bp_UIBarButtonItem_shouldAnimateBadgeKey";
NSString const *bp_UIBarButtonItem_badgeValueKey = @"bp_UIBarButtonItem_badgeValueKey";

@implementation UIBarButtonItem (BPBadge)

@dynamic bp_badgeValue, bp_badgeBGColor, bp_badgeTextColor, bp_badgeFont;
@dynamic bp_badgePadding, bp_badgeMinSize, bp_badgeOriginX, bp_badgeOriginY;
@dynamic bp_shouldHideBadgeAtZero, bp_shouldAnimateBadge;

- (void)bp_badgeInit
{
    UIView *superview = nil;
    CGFloat defaultOriginX = 0;
    if (self.customView) {
        superview = self.customView;
        defaultOriginX = superview.frame.size.width - self.bp_badge.frame.size.width/2;
        // Avoids badge to be clipped when animating its scale
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
        defaultOriginX = superview.frame.size.width - self.bp_badge.frame.size.width;
    }
    [superview addSubview:self.bp_badge];
    
    // Default design initialization
    self.bp_badgeBGColor   = [UIColor redColor];
    self.bp_badgeTextColor = [UIColor whiteColor];
    self.bp_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.bp_badgePadding   = 6;
    self.bp_badgeMinSize   = 8;
    self.bp_badgeOriginX   = defaultOriginX;
    self.bp_badgeOriginY   = -4;
    self.bp_shouldHideBadgeAtZero = YES;
    self.bp_shouldAnimateBadge = YES;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)bp_refreshBadge
{
    // Change new attributes
    self.bp_badge.textColor        = self.bp_badgeTextColor;
    self.bp_badge.backgroundColor  = self.bp_badgeBGColor;
    self.bp_badge.font             = self.bp_badgeFont;
    
    if (!self.bp_badgeValue || [self.bp_badgeValue isEqualToString:@""] || ([self.bp_badgeValue isEqualToString:@"0"] && self.bp_shouldHideBadgeAtZero)) {
        self.bp_badge.hidden = YES;
    } else {
        self.bp_badge.hidden = NO;
        [self bp_updateBadgeValueAnimated:YES];
    }

}

- (CGSize)bp_badgeExpectedSize
{
    // When the value changes the badge could need to get bigger
    // Calculate expected size to fit new value
    // Use an intermediate label to get expected size thanks to sizeToFit
    // We don't call sizeToFit on the true label to avoid bad display
    UILabel *frameLabel = [self bp_duplicateLabel:self.bp_badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}

- (void)bp_updateBadgeFrame
{

    CGSize expectedLabelSize = [self bp_badgeExpectedSize];
    
    // Make sure that for small value, the badge will be big enough
    CGFloat minHeight = expectedLabelSize.height;
    
    // Using a const we make sure the badge respect the minimum size
    minHeight = (minHeight < self.bp_badgeMinSize) ? self.bp_badgeMinSize : expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    CGFloat padding = self.bp_badgePadding;
    
    // Using const we make sure the badge doesn't get too smal
    minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width;
    self.bp_badge.layer.masksToBounds = YES;
    self.bp_badge.frame = CGRectMake(self.bp_badgeOriginX, self.bp_badgeOriginY, minWidth + padding, minHeight + padding);
    self.bp_badge.layer.cornerRadius = (minHeight + padding) / 2;
}

// Handle the badge changing value
- (void)bp_updateBadgeValueAnimated:(BOOL)animated
{
    // Bounce animation on badge if value changed and if animation authorized
    if (animated && self.bp_shouldAnimateBadge && ![self.bp_badge.text isEqualToString:self.bp_badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.bp_badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    
    // Set the new value
    self.bp_badge.text = self.bp_badgeValue;
    
    // Animate the size modification if needed
    if (animated && self.bp_shouldAnimateBadge) {
        [UIView animateWithDuration:0.2 animations:^{
            [self bp_updateBadgeFrame];
        }];
    } else {
        [self bp_updateBadgeFrame];
    }
}

- (UILabel *)bp_duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    
    return duplicateLabel;
}

- (void)bp_removeBadge
{
    // Animate badge removal
    [UIView animateWithDuration:0.2 animations:^{
        self.bp_badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.bp_badge removeFromSuperview];
        self.bp_badge = nil;
    }];
}

#pragma mark - getters/setters
- (UILabel*)bp_badge {
    UILabel* lbl = objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeKey);
    if(lbl==nil) {
        lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.bp_badgeOriginX, self.bp_badgeOriginY, 20, 20)];
        [self setBp_badge:lbl];
        [self bp_badgeInit];
        [self.customView addSubview:lbl];
        lbl.textAlignment = NSTextAlignmentCenter;
    }
    return lbl;
}
- (void)setBp_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
- (NSString *)bp_badgeValue {
    return objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeValueKey);
}
- (void)setBp_vadgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    [self bp_updateBadgeValueAnimated:YES];
    [self bp_refreshBadge];
}

// Badge background color
- (UIColor *)badgeBGColor {
    return objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeBGColorKey);
}
- (void)setBadgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_refreshBadge];
    }
}

// Badge text color
- (UIColor *)badgeTextColor {
    return objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeTextColorKey);
}
- (void)setBadgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_refreshBadge];
    }
}

// Badge font
- (UIFont *)badgeFont {
    return objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeFontKey);
}
- (void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_refreshBadge];
    }
}

// Padding value for the badge
- (CGFloat) badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgePaddingKey);
    return number.floatValue;
}
- (void) setBadgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

// Minimum size badge to small
- (CGFloat)bp_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeMinSizeKey);
    return number.floatValue;
}
- (void) setBp_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
- (CGFloat)bp_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}
- (void) setBp_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

- (CGFloat)bp_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}
- (void) setBp_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
- (BOOL) shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIBarButtonItem_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.bp_badge) {
        [self bp_refreshBadge];
    }
}

// Badge has a bounce animation when value changes
- (BOOL) bp_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIBarButtonItem_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setBp_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &bp_UIBarButtonItem_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.bp_badge) {
        [self bp_refreshBadge];
    }
}


@end
