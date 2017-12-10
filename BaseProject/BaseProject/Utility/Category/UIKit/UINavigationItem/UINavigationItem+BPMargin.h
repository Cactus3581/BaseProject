//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT double UINavigationItem_MarginVersionNumber;
FOUNDATION_EXPORT const unsigned char UINavigationItem_MarginVersionString[];

@interface UINavigationItem (BPMargin)

@property (nonatomic, assign) CGFloat bp_leftMargin;
@property (nonatomic, assign) CGFloat bp_rightMargin;

+ (CGFloat)bp_systemMargin;

@end
