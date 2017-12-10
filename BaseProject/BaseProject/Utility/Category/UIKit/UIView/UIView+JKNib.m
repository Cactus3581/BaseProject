//
//  UIView+Nib.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+JKNib.h"

@implementation UIView (JKNib)
#pragma mark - Nibs
+ (UINib *)bp_loadNib
{
    return [self bp_loadNibNamed:NSStringFromClass([self class])];
}
+ (UINib *)bp_loadNibNamed:(NSString*)nibName
{
    return [self bp_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}
+ (UINib *)bp_loadNibNamed:(NSString*)nibName bundle:(NSBundle *)bundle
{
    return [UINib nibWithNibName:nibName bundle:bundle];
}
+ (instancetype)bp_loadInstanceFromNib
{
    return [self bp_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}
+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName
{
    return [self bp_loadInstanceFromNibWithName:nibName owner:nil];
}
+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner
{
    return [self bp_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}
+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}

@end
