//
//  UIButton+BPSubmitting.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/6.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIButton+BPSubmitting.h"
#import  <objc/runtime.h>

@interface UIButton ()

@property(nonatomic, strong) UIView *bp_modalView;
@property(nonatomic, strong) UIActivityIndicatorView *bp_spinnerView;

@end

@implementation UIButton (BPSubmitting)

- (void)bp_beginSubmitting:(UIColor *)color {
    [self bp_endSubmitting];
    
    self.bp_submitting = @YES;
    self.hidden = YES;
    self.bp_modalView = [[UIView alloc] initWithFrame:CGRectZero];
    self.bp_modalView.backgroundColor =
    [self.backgroundColor colorWithAlphaComponent:0.6];
    self.bp_modalView.layer.cornerRadius = self.layer.cornerRadius;
    self.bp_modalView.layer.borderWidth = self.layer.borderWidth;
    self.bp_modalView.layer.borderColor = self.layer.borderColor;
    
    self.bp_spinnerView = [[UIActivityIndicatorView alloc]
                           initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //self.bp_spinnerView.color = [UIColor redColor];
    self.bp_spinnerView.tintColor = self.titleLabel.textColor;

    CGRect spinnerViewBounds = self.bp_spinnerView.bounds;
    [self.bp_modalView addSubview:self.bp_spinnerView];
    [self.superview addSubview:self.bp_modalView];
    [self.bp_modalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.bp_spinnerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.mas_equalTo(spinnerViewBounds.size.height/2.0);
    }];
    CGAffineTransform transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.bp_spinnerView.transform = transform;
    [self.bp_spinnerView startAnimating];
}

- (void)bp_endSubmitting {
    if (!self.isBPSubmitting.boolValue) {
        return;
    }
    
    self.bp_submitting = @NO;
    self.hidden = NO;
    
    [self.bp_modalView removeFromSuperview];
    self.bp_modalView = nil;
    self.bp_spinnerView = nil;
}

- (NSNumber *)isBPSubmitting {
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

@end
