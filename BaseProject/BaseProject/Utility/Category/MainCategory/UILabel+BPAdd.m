//
//  UILabel+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UILabel+BPAdd.h"
#import "NSObject+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UILabel_BPAdd)

@implementation UILabel (BPAdd)

+ (void)load{
    [self bp_swizzleInstanceMethod:@selector(setText:) with:@selector(_bp_setText:)];
}

- (BOOL)textChangeWithAnimaiton{
    return [[self bp_getAssociatedValueForKey:"bp_textAnimation"] boolValue];
}

- (void)setTextChangeWithAnimaiton:(BOOL)textChangeWithAnimaiton{
    [self bp_setAssociateValue: @(textChangeWithAnimaiton) withKey:"bp_textAnimation"];
}

- (void)_bp_setText:(NSString *)text{
    if (self.textChangeWithAnimaiton) {
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self _bp_setText:text];
        } completion:nil];
    }else{
        [self _bp_setText:text];
    }
}

@end
