//
//  UIImageView+BPAdd.m
//  BaseProject
//
//  Created by Ryan on 16/4/14.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import "UIImageView+BPAdd.h"
#import "NSObject+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UIImageView_BPAdd)

@implementation UIImageView (BPAdd)

+ (void)load{
    [self bp_swizzleInstanceMethod:@selector(setImage:) with:@selector(_bp_setImage:)];
}

- (BOOL)imageChangeWithAnimaiton{
    return [[self bp_getAssociatedValueForKey:"bp_imageAnimation"] boolValue];
}

- (void)setImageChangeWithAnimaiton:(BOOL)imageChangeWithAnimaiton{
    [self bp_setAssociateValue: @(imageChangeWithAnimaiton) withKey:"bp_imageAnimation"];
}

- (void)_bp_setImage:(NSString *)image{
    if (self.imageChangeWithAnimaiton) {
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self _bp_setImage:image];
        } completion:nil];
    }else{
        [self _bp_setImage:image];
    }
}

@end
