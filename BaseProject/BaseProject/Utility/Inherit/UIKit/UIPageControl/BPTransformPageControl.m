//
//  BPTransformPageControl.m
//  BaseProject
//
//  Created by Ryan on 2018/6/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTransformPageControl.h"

@implementation BPTransformPageControl

//重写setCurrentPage方法，可设置圆点大小

//设置每个圆点大小
- (void)setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 5;
        size.width = 5;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}

// 如果只改变当前选中的点的大小，前面加个判断就可以了
/*
- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    for(NSUInteger index = 0; index < self.subviews.count; index++){
        if (index == currentPage) {
            UIImageView *subview = [self.subviews objectAtIndex:index];
            CGSize size = CGSizeMake(40, 20);
            [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y, size.width, size.height)];
        }
    }
}
*/
 
@end
