//
//  UIView+JKConstraints.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+JKConstraints.h"

@implementation UIView (JKConstraints)
-(NSLayoutConstraint *)bp_constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (NSLayoutConstraint *)bp_leftConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeLeft];
}

- (NSLayoutConstraint *)bp_rightConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeRight];
}

- (NSLayoutConstraint *)bp_topConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)bp_bottomConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)bp_leadingConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)bp_trailingConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)bp_widthConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)bp_heightConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)bp_centerXConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)bp_centerYConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)bp_baseLineConstraint {
    return [self bp_constraintForAttribute:NSLayoutAttributeBaseline];
}
@end
