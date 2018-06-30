//
//  BPAlignmentRectInsetsLabel.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAlignmentRectInsetsLabel.h"
@interface BPAlignmentRectInsetsLabel()
@property (nonatomic, assign) CGSize intervalSize;
@end

@implementation BPAlignmentRectInsetsLabel

- (void)layoutSubviews {
    [super layoutSubviews];
    BPLog(@"%@",NSStringFromCGRect(self.frame));
}

//UIView 提供了方法，由 frame 得到 alignment rect：
//- (CGRect)alignmentRectForFrame:(CGRect)frame {
//    
//}

//它得可逆，也就是说得能从 alignment rect 反过来得到 frame：
//- (CGRect)frameForAlignmentRect:(CGRect)alignmentRect {
//
//}

//考虑到每次重写这两个方法比较烦，系统也提供了一个简便方法，由 inset 来指定 frame 与 aligment rect 的关系：
- (UIEdgeInsets)alignmentRectInsets {
    return UIEdgeInsetsMake(-10.0, -10.0, -10.0, -10.0);
}

@end
