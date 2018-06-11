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

- (UIEdgeInsets)alignmentRectInsets {
    return UIEdgeInsetsMake(-10.0, .0, -10.0, .0);
}

//- (CGSize)intrinsicContentSize {
//    CGSize size = [super intrinsicContentSize];
//    if (self.text && [self.text length] > 0) {
////        size.width += self.intervalSize.width;
////        size.height += self.intervalSize.height;
//        size.height+=20;
//    }
//    return size;
//}

@end
