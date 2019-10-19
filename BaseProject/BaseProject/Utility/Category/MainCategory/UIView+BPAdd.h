//
//  UIView+BPAdd.h
//  BaseProject
//
//  Created by Ryan on 16/3/9.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BPAddViewBlock)(CGRect frame);

@interface UIView (BPAdd)

#pragma mark - fast property

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;
@property (nonatomic) CGFloat bottomFromSuperView;
@property (nonatomic) CGFloat rightFromSuperView;

#pragma mark - snapshot (截图相关)

@property (nullable, nonatomic, readonly) UIImage *snapshotImage;
@property (nullable, nonatomic, readonly) NSData *snapshotPDF;

/**此方法截图比snapshotImage属性更快，但可能导致屏幕刷新，update：是否刷新屏幕后再截图*/
- (nullable UIImage *)bp_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

#pragma mark- shadow(阴影相关)

- (void)bp_shadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

#pragma mark - anchorPoint(锚点相关)

- (void)bp_anchorPointChangedToPoint:(CGPoint)point;

#pragma mark - other

- (void)bp_removeAllSubviews;

/**返回管理着该视图的控制器(包括管理该视图父视图级别的控制器)，可为nil*/
@property (nullable, nonatomic, readonly) UIViewController *viewController;

/**可视透明度，值由自身hidden和alpha以及父视图的hidden和alpha决定*/
@property (nonatomic, readonly) CGFloat visibleAlpha;

/**触摸屏幕时先结束编辑*/
//@property (nonatomic, assign) BOOL endEditingBeforTouch;
/**触摸时回调的block*/
//@property (nonatomic, copy) dispatch_block_t touchBlock;
/**扩大View的可点击区域，比如设置（10，10，10，10）则该view周围10的范围内依然可判定为view可以响应的点击区域*/
@property (nonatomic, assign) UIEdgeInsets externalTouchInset;

/**返回一个临时视图，一般用于辅助layer的布局，因为layer无法使用自动布局*/
+ (instancetype)bp_tempViewForFrameWithBlock:(BPAddViewBlock)block;

- (void)bp_setAnchorPointTo:(CGPoint)point;

// 判断此view是否正在屏幕上显示
- (BOOL)bp_isDisplayedInScreen;

- (UIViewController* )bp_currentViewController;

@end

NS_ASSUME_NONNULL_END
