//
//  UIImageView+Addition.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JKAddition)
/**
 *  @brief  根据bundle中的图片名创建imageview
 *
 *  @param imageName bundle中的图片名
 *
 *  @return imageview
 */
+ (id)bp_imageViewWithImageNamed:(NSString*)imageName;
/**
 *  @brief  根据frame创建imageview
 *
 *  @param frame imageview frame
 *
 *  @return imageview
 */
+ (id)bp_imageViewWithFrame:(CGRect)frame;

+ (id)bp_imageViewWithStretchableImage:(NSString*)imageName Frame:(CGRect)frame;
/**
 *  @brief  创建imageview动画
 *
 *  @param imageArray 图片名称数组
 *  @param duration   动画时间
 *
 *  @return imageview
 */
+ (id)bp_imageViewWithImageArray:(NSArray*)imageArray duration:(NSTimeInterval)duration;
- (void)bp_setImageWithStretchableImage:(NSString*)imageName;


// 画水印
// 图片水印
- (void)bp_setImage:(UIImage *)image withWaterMark:(UIImage *)mark inRect:(CGRect)rect;
// 文字水印
- (void)bp_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (void)bp_setImage:(UIImage *)image withStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;
@end
