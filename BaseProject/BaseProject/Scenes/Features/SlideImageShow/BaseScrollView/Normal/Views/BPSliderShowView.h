//
//  BPSliderShowView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/10.
//  Copyright © 2018年 xiaruzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPSliderShowView;
@protocol BPSliderShowViewDelegate <NSObject>
@optional

//点击的是是第几张图片/也可以理解显示的第几张图片
- (void)sliderShowView:(BPSliderShowView *)sliderShowView didSelectItemAtIndex:(NSInteger)index;
//将要显示第几张图片
- (void)sliderShowView:(BPSliderShowView *)sliderShowView willDisplayItemAtIndex:(NSInteger)index;
//已经完全显示第几张图片
- (void)sliderShowView:(BPSliderShowView *)sliderShowView didEndDisplayingItemAtIndex:(NSInteger)index;
@end

@interface BPSliderShowView : UIView

/** 数据源 */
@property (nonatomic,strong) NSArray *imageArray;

/** 点击中间图片的回调 */
@property (nonatomic, copy) void (^clickImageBlock)(NSInteger currentIndex);

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;

/** 当前小圆点颜色 */
@property(nonatomic,retain)UIColor *curPageControlColor;

/** 其余小圆点颜色  */
@property(nonatomic,retain)UIColor *otherPageControlColor;

/** 占位图*/
@property (nonatomic,strong) UIImage  *placeHolderImage;

/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic) BOOL hideWhenSinglePage;

/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 圆角 */
- (void)setRadius:(CGFloat)radius cornerColor:(UIColor *)color;

@property (nonatomic,weak) id<BPSliderShowViewDelegate> delegate;

// 当此view不在视野范围内时，计时器工作的时候直接返回
@property (nonatomic, weak) UIViewController *viewControllerInSide;

@end
