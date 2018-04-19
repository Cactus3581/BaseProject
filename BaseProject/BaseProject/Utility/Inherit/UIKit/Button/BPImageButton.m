//
//  BPImageButton.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/8/8.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPImageButton.h"

@implementation BPImageButton

//返回图片的rect
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat inteval = CGRectGetHeight(contentRect)/8.0;
    //设置图片的宽高为button高度的3/4;
    CGFloat imageH = CGRectGetHeight(contentRect) - 2 * inteval;
    CGRect rect = CGRectMake(CGRectGetWidth(contentRect) - imageH - inteval, inteval, imageH, imageH);
    return rect;
}

//返回文字的的rect
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat inteval = CGRectGetHeight(contentRect)/8.0;
    //设置文字的宽高为button高度的3/4;
    CGFloat titleH = CGRectGetHeight(contentRect) - 2 * inteval;
    CGRect rect = CGRectMake(inteval, inteval, CGRectGetWidth(contentRect) - titleH - 2*inteval, CGRectGetHeight(contentRect) - 2*inteval);
    return rect;
}

@end
