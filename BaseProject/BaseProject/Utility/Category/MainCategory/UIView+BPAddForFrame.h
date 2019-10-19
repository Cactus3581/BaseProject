//
//  UIView+BPAddForFrame.h
//  BaseProject
//
//  Created by Ryan on 16/5/25.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BPAddForFrame)


#pragma mark - fast property

@property (nonatomic, assign) CGFloat bp_left;
@property (nonatomic, assign) CGFloat bp_top;
@property (nonatomic, assign) CGFloat bp_right;
@property (nonatomic, assign) CGFloat bp_bottom;
@property (nonatomic, assign) CGFloat bp_width;
@property (nonatomic, assign) CGFloat bp_height;
@property (nonatomic, assign) CGFloat bp_centerX;
@property (nonatomic, assign) CGFloat bp_centerY;

@property (nonatomic, assign) CGPoint bp_origin;
@property (nonatomic, assign) CGPoint  bp_center;
@property (nonatomic, assign) CGSize  bp_size;
@property (nonatomic, assign) CGRect bp_frame;

@end
