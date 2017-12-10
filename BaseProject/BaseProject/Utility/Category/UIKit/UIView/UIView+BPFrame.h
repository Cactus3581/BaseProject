//
//  UIView+BPFrame.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BPFrame)
// shortcuts for frame properties
@property (nonatomic, assign) CGPoint bp_origin;
@property (nonatomic, assign) CGSize bp_size;

// shortcuts for positions
@property (nonatomic) CGFloat bp_centerX;
@property (nonatomic) CGFloat bp_centerY;


@property (nonatomic) CGFloat bp_top;
@property (nonatomic) CGFloat bp_bottom;
@property (nonatomic) CGFloat bp_right;
@property (nonatomic) CGFloat bp_left;

@property (nonatomic) CGFloat bp_width;
@property (nonatomic) CGFloat bp_height;
@end
