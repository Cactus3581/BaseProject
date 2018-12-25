//
//  BPFlowCategoryView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFlowCategoryView;

@protocol BPFlowCategoryViewDelegate <NSObject>

@required
/** 获取view*/
- (UIViewController *)flowCategoryView:(BPFlowCategoryView *)flowCategoryView cellForItemAtIndexPath:(NSInteger)row;

@optional
/** 点击*/
- (void)flowCategoryView:(BPFlowCategoryView *)flowCategoryView didSelectItemAtIndex:(NSInteger)row;

/** 滑动中*/
- (void)flowCategoryViewDidScroll:(BPFlowCategoryView *)flowCategoryView;

/** 即将结束滑动*/
- (void)flowCategoryViewDidEndDecelerating:(BPFlowCategoryView *)flowCategoryView;

@end


@interface BPFlowCategoryView : UIView

/**vc缓存*/
@property (nonatomic, strong,readonly) NSMutableDictionary *vcCacheDic;
/**代理*/
@property (nonatomic, weak) id<BPFlowCategoryViewDelegate>delegate;
/**顶部高度*/
@property (nonatomic, assign) CGFloat tagViewHeight;

#pragma mark - basic

/**数据源titles，必须设置*/
@property (nonatomic, copy) NSArray *titles;
/**点击item后各个控件（底部线条和椭圆）动画的时间，默认0.3秒，可设置为0*/
@property (nonatomic, assign) NSTimeInterval clickedAnimationDuration;
/**当点击item滚动传入的scrollView时，是否使用动画，默认YES*/
@property (nonatomic, assign) BOOL scrollWithAnimaitonWhenClicked;
/**设置初始化默认选中的index，默认0*/
@property (nonatomic, assign) NSUInteger defaultIndex;

@property (nonatomic, strong) UIColor *flowTagViewColor;

#pragma mark - item
/**item间距，默认10，如果计算出的item排布的总宽度小于控件宽度，会自动修改item让item均布*/
@property (nonatomic, assign) CGFloat itemSpacing;
/**左右边缘间距，默认20*/
@property (nonatomic, assign) CGFloat edgeSpacing;
/**item字体，默认15*/
@property (nonatomic, strong) UIFont *titleFont;
/**选中的item字体，默认15*/
@property (nonatomic, strong) UIFont *titleSelectFont;

#pragma mark - titleColor
/**是否开启文字颜色变化效果，默认YES*/
@property (nonatomic, assign) BOOL titleColorChangeEable;
/**是否开启文字颜色变化渐变，默认NO，如果设置该效果YES需要先保证titleColorChangeEable为YES*/
@property (nonatomic, assign) BOOL titleColorChangeGradually;
/**item字体颜色，默认白色*/
@property (nonatomic, strong) UIColor *titleColor;
/**选中的item字体颜色，默认红色*/
@property (nonatomic, strong) UIColor *titleSelectColor;

#pragma mark - scale
/**是否开启缩放， 默认NO*/
@property (nonatomic, assign) BOOL scaleEnable;
/**缩放比例， 默认1.1*/
@property (nonatomic, assign) CGFloat scaleRatio;

#pragma mark - bottomLine
/**是否开启下方横线，默认NO*/
@property (nonatomic, assign) BOOL bottomLineEable;
/**下方横线颜色，默认红色*/
@property (nonatomic, strong) UIColor *bottomLineColor;
/**下方横线高度，默认2.0f*/
@property (nonatomic, assign) CGFloat bottomLineHeight;
/**下方横线宽度，默认跟字符串一样宽*/
@property (nonatomic, assign) CGFloat bottomLineWidth;
/**下方横线,是否需要圆角，如果为YES，圆角为高度的一半*/
@property (nonatomic, assign) BOOL bottomLineCornerRadius;
/**下方横线距离item底部的距离，默认10.0f*/
@property (nonatomic, assign) CGFloat bottomLineSpacingFromTitleBottom;

#pragma mark - bottomLine：长条。非动画条
/**是否开启下方横线，默认NO*/
@property (nonatomic, assign,getter=isLineHidden) BOOL lineHidden;
@property (nonatomic, strong) UIColor *lineColor;

#pragma mark - backEllipse
/**是否开启背后的椭圆，默认NO*/
@property (nonatomic, assign) BOOL backEllipseEable;
/**椭圆颜色，默认黄色*/
@property (nonatomic, strong) UIColor *backEllipseColor;
/**椭圆大小，默认CGSizeZero，表示椭圆大小随文字内容而定*/
@property (nonatomic, assign) CGSize backEllipseSize;

#pragma mark - update
/**刷新后是否保持在原来的index上，默认NO，表示刷新后回到第0个item*/
@property (nonatomic, assign) BOOL holdLastIndexAfterUpdate;

/**重新设置titles数据源后调用该方法刷新控件*/
- (void)bp_realoadData;
- (void)bp_realoadDataForTag;
- (void)bp_realoadDataForContentView;

/**旋转问题*/
- (void)performBatchUpdates;

@end
