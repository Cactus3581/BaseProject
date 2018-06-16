//
//  UIBarButtonItem+Badge.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
//
#import <objc/runtime.h>
#import "UIButton+BPBadge.h"

NSString const *bp_UIButton_badgeKey = @"bp_UIButton_badgeKey";

NSString const *bp_UIButton_badgeBGColorKey = @"bp_UIButton_badgeBGColorKey";
NSString const *bp_UIButton_badgeTextColorKey = @"bp_UIButton_badgeTextColorKey";
NSString const *bp_UIButton_badgeFontKey = @"bp_UIButton_badgeFontKey";
NSString const *bp_UIButton_badgePaddingKey = @"bp_UIButton_badgePaddingKey";
NSString const *bp_UIButton_badgeMinSizeKey = @"bp_UIButton_badgeMinSizeKey";
NSString const *bp_UIButton_badgeOriginXKey = @"bp_UIButton_badgeOriginXKey";
NSString const *bp_UIButton_badgeOriginYKey = @"bp_UIButton_badgeOriginYKey";
NSString const *bp_UIButton_shouldHideBadgeAtZeroKey = @"bp_UIButton_shouldHideBadgeAtZeroKey";
NSString const *bp_UIButton_shouldAnimateBadgeKey = @"bp_UIButton_shouldAnimateBadgeKey";
NSString const *bp_UIButton_badgeValueKey = @"bp_UIButton_badgeValueKey";

@implementation UIButton (BPBadge)

@dynamic bp_badgeValue, bp_badgeBGColor, bp_badgeTextColor, bp_badgeFont;
@dynamic bp_badgePadding, bp_badgeMinSize, bp_badgeOriginX, bp_badgeOriginY;
@dynamic bp_shouldHideBadgeAtZero, bp_shouldAnimateBadge;

- (void)bp_badgeInit
{
    // Default design initialization
    self.bp_badgeBGColor   = [UIColor redColor];
    self.bp_badgeTextColor = [UIColor whiteColor];
    self.bp_badgeFont      = [UIFont systemFontOfSize:12.0];
    self.bp_badgePadding   = 6;
    self.bp_badgeMinSize   = 8;
    self.bp_badgeOriginX   = self.frame.size.width - self.bp_badge.frame.size.width/2;
    self.bp_badgeOriginY   = -4;
    self.bp_shouldHideBadgeAtZero = YES;
    self.bp_shouldAnimateBadge = YES;
    // Avoids badge to be clipped when animating its scale
    self.clipsToBounds = NO;
}

#pragma mark - Utility methods

// Handle badge display when its properties have been changed (color, font, ...)
- (void)bp_refreshBadge
{
    // Change new attributes
    self.bp_badge.textColor        = self.bp_badgeTextColor;
    self.bp_badge.backgroundColor  = self.bp_badgeBGColor;
    self.bp_badge.font             = self.bp_badgeFont;
}

- (CGSize) bp_badgeExpectedSize
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
    self.bp_badge.frame = CGRectMake(self.bp_badgeOriginX, self.bp_badgeOriginY, minWidth + padding, minHeight + padding);
    self.bp_badge.layer.cornerRadius = (minHeight + padding) / 2;
    self.bp_badge.layer.masksToBounds = YES;
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
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self bp_updateBadgeFrame];
    }];
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
    return objc_getAssociatedObject(self, &bp_UIButton_badgeKey);
}
- (void)setBp_badge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &bp_UIButton_badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge value to be display
- (NSString *)bp_badgeValue {
    return objc_getAssociatedObject(self, &bp_UIButton_badgeValueKey);
}
- (void) setBp_badgeValue:(NSString *)badgeValue
{
    objc_setAssociatedObject(self, &bp_UIButton_badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // When changing the badge value check if we need to remove the badge
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.bp_shouldHideBadgeAtZero)) {
        [self bp_removeBadge];
    } else if (!self.bp_badge) {
        // Create a new badge because not existing
        self.bp_badge                      = [[UILabel alloc] initWithFrame:CGRectMake(self.bp_badgeOriginX, self.bp_badgeOriginY, 20, 20)];
        self.bp_badge.textColor            = self.bp_badgeTextColor;
        self.bp_badge.backgroundColor      = self.bp_badgeBGColor;
        self.bp_badge.font                 = self.bp_badgeFont;
        self.bp_badge.textAlignment        = NSTextAlignmentCenter;
        [self bp_badgeInit];
        [self addSubview:self.bp_badge];
        [self bp_updateBadgeValueAnimated:NO];
    } else {
        [self bp_updateBadgeValueAnimated:YES];
    }
}

// Badge background color
- (UIColor *)bp_badgeBGColor {
    return objc_getAssociatedObject(self, &bp_UIButton_badgeBGColorKey);
}
- (void)setBp_badgeBGColor:(UIColor *)badgeBGColor
{
    objc_setAssociatedObject(self, &bp_UIButton_badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_refreshBadge];
    }
}

// Badge text color
- (UIColor *)bp_badgeTextColor {
    return objc_getAssociatedObject(self, &bp_UIButton_badgeTextColorKey);
}
- (void)setBp_badgeTextColor:(UIColor *)badgeTextColor
{
    objc_setAssociatedObject(self, &bp_UIButton_badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_refreshBadge];
    }
}

// Badge font
- (UIFont *)bp_badgeFont {
    return objc_getAssociatedObject(self, &bp_UIButton_badgeFontKey);
}
- (void)setBp_badgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, &bp_UIButton_badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_refreshBadge];
    }
}

// Padding value for the badge
- (CGFloat) bp_badgePadding {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIButton_badgePaddingKey);
    return number.floatValue;
}
- (void) setBp_badgePadding:(CGFloat)badgePadding
{
    NSNumber *number = [NSNumber numberWithDouble:badgePadding];
    objc_setAssociatedObject(self, &bp_UIButton_badgePaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

// Minimum size badge to small
- (CGFloat) bp_badgeMinSize {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIButton_badgeMinSizeKey);
    return number.floatValue;
}
- (void) setBp_badgeMinSize:(CGFloat)badgeMinSize
{
    NSNumber *number = [NSNumber numberWithDouble:badgeMinSize];
    objc_setAssociatedObject(self, &bp_UIButton_badgeMinSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

// Values for offseting the badge over the BarButtonItem you picked
- (CGFloat) bp_badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIButton_badgeOriginXKey);
    return number.floatValue;
}
- (void) setBp_badgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &bp_UIButton_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

- (CGFloat) bp_badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIButton_badgeOriginYKey);
    return number.floatValue;
}
- (void) setBp_badgeOriginY:(CGFloat)badgeOriginY
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &bp_UIButton_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.bp_badge) {
        [self bp_updateBadgeFrame];
    }
}

// In case of numbers, remove the badge when reaching zero
- (BOOL) bp_shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIButton_shouldHideBadgeAtZeroKey);
    return number.boolValue;
}
- (void)setBp_shouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero
{
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &bp_UIButton_shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// Badge has a bounce animation when value changes
- (BOOL) bp_shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &bp_UIButton_shouldAnimateBadgeKey);
    return number.boolValue;
}
- (void)setBp_shouldAnimateBadge:(BOOL)shouldAnimateBadge
{
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &bp_UIButton_shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
