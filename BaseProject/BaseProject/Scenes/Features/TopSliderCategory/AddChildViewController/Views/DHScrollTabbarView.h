//
//  DHScrollTabbarView.h
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/14.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DHSlideTabbarProtocol.h"

@interface DHScrollTabbarItem : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) BOOL countOfMessage;

+ (DHScrollTabbarItem *)itemWithTitle:(NSString *)title width:(CGFloat)width;

@end

@interface DHScrollTabbarView : UIView<DHSlideTabbarProtocol>

@property (nonatomic, strong) UIView *backgroundView;
/**
 *tabbar属性
 */
@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, assign) CGFloat tabItemNormalFontSize;
@property(nonatomic, strong) UIColor *trackColor;
@property(nonatomic, strong) NSArray *tabbarItems;
@property(nonatomic, assign) CGFloat trackViewHeight;//滑动线条高度
@property (nonatomic,assign) CGFloat trackViewBottomSpace;//滑动线条距底部的距离
@property (nonatomic,assign) CGFloat trackViewWidth;//滑动线条宽度
@property(nonatomic, assign) BOOL trackViewWidthEqualToTextLength;//滑动线条宽度是否跟文字长度相同 否则跟显示文字的区域宽度相同
@property (nonatomic, assign) BOOL shouldHideTrackView;
@property (nonatomic, assign) BOOL shouldChangeBackViewColor;
@property (nonatomic, assign) BOOL shouldShowBottomSeparateLine;
@property (nonatomic, strong) NSMutableArray *coverImageArray;
@property (nonatomic, assign) CGFloat trackViewCornerRadius;//滑动线条圆角
@property (nonatomic, assign) BOOL shouldChangeFontWhenSelected;
@property (nonatomic, assign) BOOL shouldTrackViewAutoScroll;
@property (nonatomic, assign) BOOL shouldBackViewAutoScroll;
@property (nonatomic, assign) BOOL isSimpleThemePage;
@property (nonatomic, assign) BOOL itemsLabelNeedBold;//标题是否需要加粗

@property (nonatomic, strong) NSArray *subTitleArray;//第二行副标题数组

- (void)resetTheme;

- (void)resetThemeForSimpleTheme;

- (void)setScrollViewBackgroundColor:(UIColor *)color;
/**
 *DHSlideTabbarProtocol
 */
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, readonly) NSInteger tabbarCount;
@property(nonatomic, getter=isDivideEqually) BOOL divideEqually;
@property(nonatomic, weak) id<DHSlideTabbarDelegate> delegate;

@property (nonatomic, strong) UIView *bottomSeparateView;

- (void)switchFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex percent:(float)percent;

@end
