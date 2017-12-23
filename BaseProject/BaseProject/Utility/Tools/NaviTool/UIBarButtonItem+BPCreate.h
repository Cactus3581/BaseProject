//
//  UIBarButtonItem+BPCreate.h
//  UINavigation-BPFixSpace
//
//  Created by xiaruzhen on 2017/9/8.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 
 此类主要是方便创建button。不是主要类；
 在iOS11下改变margin边距的主要类不是这个，而是"UINavigation+BPFixSpace"。该类的作用是通过 hook layoutsubviews，将navibar的margins置为0.

 */

@interface UIBarButtonItem (BPCreate)

/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image image
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image;
/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image image
 @param imageEdgeInsets 图片偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;

/**
 根据图片生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param nomalImage nomalImage
 @param higeLightedImage higeLightedImage
 @param imageEdgeInsets 图片偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                        nomalImage:(UIImage *)nomalImage
                  higeLightedImage:(UIImage *)higeLightedImage
                   imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;


/**
 根据文字生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title title
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

/**
 根据文字生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param title title
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;

/**
 根据文字生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title title
 @param font font
 @param titleColor 字体颜色
 @param highlightedColor 高亮颜色
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highlightedColor:(UIColor *)highlightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;


/**
 用作修正位置的UIBarButtonItem

 @param width 修正宽度
 @return 修正位置的UIBarButtonItem
 */
+(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width;

@end
