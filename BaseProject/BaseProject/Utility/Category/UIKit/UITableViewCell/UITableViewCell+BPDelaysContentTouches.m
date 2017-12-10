//
//  UITableViewCell+TS_delaysContentTouches.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UITableViewCell+BPDelaysContentTouches.h"

@implementation UITableViewCell (BPDelaysContentTouches)

- (UIScrollView*) bp_scrollView
{
    id sv = self.contentView.superview;
    while ( ![sv isKindOfClass: [UIScrollView class]] && sv != self )
    {
        sv = [sv superview];
    }
    
    return sv == self ? nil : sv;
}

- (void) setBp_delaysContentTouches:(BOOL)delaysContentTouches
{
    [self willChangeValueForKey: @"bp_delaysContentTouches"];
    
    [[self bp_scrollView] setDelaysContentTouches: delaysContentTouches];
    
    [self didChangeValueForKey: @"bp_delaysContentTouches"];
}

- (BOOL) bp_delaysContentTouches
{
    return [[self bp_scrollView] delaysContentTouches];
}



@end
