//
//  UIButton+BPImagePosition.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/9/22.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

//可参考 http://www.it610.com/article/5196532.htm

typedef NS_ENUM(NSInteger, BPImagePosition) {
    BPImagePositionLeft = 0,              //图片在左，文字在右，默认
    BPImagePositionRight = 1,             //图片在右，文字在左
    BPImagePositionTop = 2,               //图片在上，文字在下
    BPImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (BPImagePosition)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)bp_setImagePosition:(BPImagePosition)postion spacing:(CGFloat)spacing;

@end
