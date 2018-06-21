//
//  BPCardPageFlowViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/13.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 可以根据自己的需要继承BPCardPageFlowViewCell
*/

@interface BPCardPageFlowViewCell : UIView

/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, copy) void (^didSelectCellBlock)(NSInteger tag, BPCardPageFlowViewCell *cell);

/**
 设置子控件frame,继承后要重写
 
 @param superViewBounds superViewBounds
 */
- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds;

@end
