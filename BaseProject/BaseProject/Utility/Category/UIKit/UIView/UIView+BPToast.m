//
//  UIView+Toast.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//


#import "UIView+BPToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat BPToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat BPToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat BPToastHorizontalPadding   = 10.0;
static const CGFloat BPToastVerticalPadding     = 10.0;
static const CGFloat BPToastCornerRadius        = 10.0;
static const CGFloat BPToastOpacity             = 0.8;
static const CGFloat BPToastFontSize            = 16.0;
static const CGFloat BPToastMaxTitleLines       = 0;
static const CGFloat BPToastMaxMessageLines     = 0;
static const NSTimeInterval BPToastFadeDuration = 0.2;

// shadow appearance
static const CGFloat BPToastShadowOpacity       = 0.8;
static const CGFloat BPToastShadowRadius        = 6.0;
static const CGSize  BPToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    BPToastDisplayShadow       = YES;

// display duration
static const NSTimeInterval BPToastDefaultDuration  = 3.0;

// image view size
static const CGFloat BPToastImageViewWidth      = 80.0;
static const CGFloat BPToastImageViewHeight     = 80.0;

// activity
static const CGFloat BPToastActivityWidth       = 100.0;
static const CGFloat BPToastActivityHeight      = 100.0;
static const NSString * BPToastActivityDefaultPosition = @"center";

// interaction
static const BOOL BPToastHidesOnTap             = YES;     // excludes activity views

// associative reference keys
static const NSString * BPToastTimerKey         = @"BPToastTimerKey";
static const NSString * BPToastActivityViewKey  = @"BPToastActivityViewKey";
static const NSString * BPToastTapCallbackKey   = @"BPToastTapCallbackKey";

// positions
NSString * const BPToastPositionTop             = @"top";
NSString * const BPToastPositionCenter          = @"center";
NSString * const BPToastPositionBottom          = @"bottom";

@interface UIView (BPToastPrivate)

- (void)bp_hideToast:(UIView *)toast;
- (void)bp_toastTimerDidFinish:(NSTimer *)timer;
- (void)bp_handleToastTapped:(UITapGestureRecognizer *)recognizer;
- (CGPoint)bp_centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)bp_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
- (CGSize)bp_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


@implementation UIView (BPToast)

#pragma mark - Toast Methods

- (void)bp_makeToast:(NSString *)message {
    [self bp_makeToast:message duration:BPToastDefaultDuration position:nil];
}

- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    UIView *toast = [self bp_viewForMessage:message title:nil image:nil];
    [self bp_showToast:toast duration:duration position:position];
}

- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
    UIView *toast = [self bp_viewForMessage:message title:title image:nil];
    [self bp_showToast:toast duration:duration position:position];
}

- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
    UIView *toast = [self bp_viewForMessage:message title:nil image:image];
    [self bp_showToast:toast duration:duration position:position];
}

- (void)bp_makeToast:(NSString *)message duration:(NSTimeInterval)duration  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self bp_viewForMessage:message title:title image:image];
    [self bp_showToast:toast duration:duration position:position];
}

- (void)bp_showToast:(UIView *)toast {
    [self bp_showToast:toast duration:BPToastDefaultDuration position:nil];
}


- (void)bp_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self bp_showToast:toast duration:duration position:position tapCallback:nil];
    
}


- (void)bp_showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
    toast.center = [self bp_centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    
    if (BPToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(bp_handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:BPToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(bp_toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &BPToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &BPToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}


- (void)bp_hideToast:(UIView *)toast {
    [UIView animateWithDuration:BPToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}

#pragma mark - Events

- (void)bp_toastTimerDidFinish:(NSTimer *)timer {
    [self bp_hideToast:(UIView *)timer.userInfo];
}

- (void)bp_handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &BPToastTimerKey);
    [timer invalidate];
    
    void (^callback)(void) = objc_getAssociatedObject(self, &BPToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self bp_hideToast:recognizer.view];
}

#pragma mark - Toast Activity Methods

- (void)bp_makeToastActivity {
    [self bp_makeToastActivity:BPToastActivityDefaultPosition];
}

- (void)bp_makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &BPToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BPToastActivityWidth, BPToastActivityHeight)];
    activityView.center = [self bp_centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:BPToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = BPToastCornerRadius;
    
    if (BPToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = BPToastShadowOpacity;
        activityView.layer.shadowRadius = BPToastShadowRadius;
        activityView.layer.shadowOffset = BPToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate the activity view with self
    objc_setAssociatedObject (self, &BPToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:BPToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)bp_hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &BPToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:BPToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &BPToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Helpers

- (CGPoint)bp_centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:BPToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + BPToastVerticalPadding);
        } else if([point caseInsensitiveCompare:BPToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - BPToastVerticalPadding);
}

- (CGSize)bp_sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}

- (UIView *)bp_viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;

    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = BPToastCornerRadius;
    
    if (BPToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = BPToastShadowOpacity;
        wrapperView.layer.shadowRadius = BPToastShadowRadius;
        wrapperView.layer.shadowOffset = BPToastShadowOffset;
    }

    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:BPToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(BPToastHorizontalPadding, BPToastVerticalPadding, BPToastImageViewWidth, BPToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = BPToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = BPToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:BPToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * BPToastMaxWidth) - imageWidth, self.bounds.size.height * BPToastMaxHeight);
        CGSize expectedSizeTitle = [self bp_sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = BPToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:BPToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * BPToastMaxWidth) - imageWidth, self.bounds.size.height * BPToastMaxHeight);
        CGSize expectedSizeMessage = [self bp_sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = BPToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + BPToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;

    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + BPToastHorizontalPadding;
        messageTop = titleTop + titleHeight + BPToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }

    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (BPToastHorizontalPadding * 2)), (longerLeft + longerWidth + BPToastHorizontalPadding));    
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + BPToastVerticalPadding), (imageHeight + (BPToastVerticalPadding * 2)));
                         
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
        
    return wrapperView;
}

@end
