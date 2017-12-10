//
//  UIButton+Submitting.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIButton+JKSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *bp_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *bp_spinnerView;
@property(nonatomic, strong) UILabel *bp_spinnerTitleLabel;

@end

@implementation UIButton (JKSubmitting)

- (void)bp_beginSubmitting:(NSString *)title {
    [self bp_endSubmitting];
    
    self.bp_submitting = @YES;
    self.hidden = YES;
    
    self.bp_modalView = [[UIView alloc] initWithFrame:self.frame];
    self.bp_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.bp_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.bp_modalView.layer.borderWidth = self.layer.borderWidth;
    self.bp_modalView.layer.borderColor = self.layer.borderColor;
    
    CGRect viewBounds = self.bp_modalView.bounds;
    self.bp_spinnerView = [[UIActivityIndicatorView alloc]
                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.bp_spinnerView.tintColor = self.titleLabel.textColor;
    
    CGRect spinnerViewBounds = self.bp_spinnerView.bounds;
    self.bp_spinnerView.frame = CGRectMake(
                                        15, viewBounds.size.height / 2 - spinnerViewBounds.size.height / 2,
                                        spinnerViewBounds.size.width, spinnerViewBounds.size.height);
    self.bp_spinnerTitleLabel = [[UILabel alloc] initWithFrame:viewBounds];
    self.bp_spinnerTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.bp_spinnerTitleLabel.text = title;
    self.bp_spinnerTitleLabel.font = self.titleLabel.font;
    self.bp_spinnerTitleLabel.textColor = self.titleLabel.textColor;
    [self.bp_modalView addSubview:self.bp_spinnerView];
    [self.bp_modalView addSubview:self.bp_spinnerTitleLabel];
    [self.superview addSubview:self.bp_modalView];
    [self.bp_spinnerView startAnimating];
}

- (void)bp_endSubmitting {
    if (!self.isJKSubmitting.boolValue) {
        return;
    }
    
    self.bp_submitting = @NO;
    self.hidden = NO;
    
    [self.bp_modalView removeFromSuperview];
    self.bp_modalView = nil;
    self.bp_spinnerView = nil;
    self.bp_spinnerTitleLabel = nil;
}

- (NSNumber *)isJKSubmitting {
    return objc_getAssociatedObject(self, @selector(setBp_submitting:));
}

- (void)setBp_submitting:(NSNumber *)submitting {
    objc_setAssociatedObject(self, @selector(setBp_submitting:), submitting, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (UIActivityIndicatorView *)bp_spinnerView {
    return objc_getAssociatedObject(self, @selector(setBp_spinnerView:));
}

- (void)setBp_spinnerView:(UIActivityIndicatorView *)spinnerView {
    objc_setAssociatedObject(self, @selector(setBp_spinnerView:), spinnerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)bp_modalView {
    return objc_getAssociatedObject(self, @selector(setBp_modalView:));

}

- (void)setBp_modalView:(UIView *)modalView {
    objc_setAssociatedObject(self, @selector(setBp_modalView:), modalView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)bp_spinnerTitleLabel {
    return objc_getAssociatedObject(self, @selector(setBp_spinnerTitleLabel:));
}

- (void)setBp_spinnerTitleLabel:(UILabel *)spinnerTitleLabel {
    objc_setAssociatedObject(self, @selector(setBp_spinnerTitleLabel:), spinnerTitleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
