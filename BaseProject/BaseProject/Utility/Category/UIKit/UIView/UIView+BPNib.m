//
//  UIView+Nib.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIView+BPNib.h"

@implementation UIView (BPNib)

#pragma mark - 返回nib（注册cell的时候可以用）
+ (UINib *)bp_loadNibNamed:(NSString *)nibName bundle:(NSBundle *)bundle {
    return [UINib nibWithNibName:nibName bundle:bundle];
}

+ (UINib *)bp_loadNib {
    return [self bp_loadNibNamed:NSStringFromClass([self class])];
}

+ (UINib *)bp_loadNibNamed:(NSString *)nibName {
    return [self bp_loadNibNamed:nibName bundle:[NSBundle mainBundle]];
}

//有两种技术可以加载xib文件：NSBundle和UINib。
#pragma mark - 初始化xibView:通过NSBundle读取
+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle {
    UIView *result = nil;
    //result = [[bundle loadNibNamed:nibName owner:owner options:nil] firstObject];
    NSArray * elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements) {
        if ([object isKindOfClass:[self class]]) {
            result = object;
            break;
        }
    }
    return result;
}

+ (instancetype)bp_loadInstanceFromNib {
    return [self bp_loadInstanceFromNibWithName:NSStringFromClass([self class])];
}

+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName {
    return [self bp_loadInstanceFromNibWithName:nibName owner:nil];
}

+ (instancetype)bp_loadInstanceFromNibWithName:(NSString *)nibName owner:(id)owner {
    return [self bp_loadInstanceFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}

#pragma mark - 初始化xibView:通过UINib读取
+ (instancetype)bp_instantiateFromNib {
    UINib *xib = [self bp_loadNib];
    NSArray *xibArray = [xib instantiateWithOwner:nil options:nil];
    UIView *result = nil;
    //result = xibArray.firstObject;
    for (id object in xibArray) {
        if ([object isKindOfClass:[self class]]) {
            result = object;
            break;
        }
    }
    return result;
}

@end
