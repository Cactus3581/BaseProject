//
//  UITabBar+BPPrompt.m
//  BaseProject
//
//  Created by Ryan on 2018/10/10.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "UITabBar+BPPrompt.h"
#import "BPPromptView.h"
#import <objc/runtime.h>
#import "BPAppDelegate.h"

@interface UITabBar ()
@property (nonatomic, strong) BPPromptView *courseReminderView;
@property (nonatomic, assign) NSInteger index;
@end

@implementation UITabBar (BPPrompt)

- (void)showPromptViewOnItemIndex:(NSInteger)index {
    self.index = index;
    [self removePromptViewOnItemIndex:index];
    CGSize size = [kPromptViewTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:labelFont]}];
    CGFloat width = size.width + 2*labelPadding;

    BPPromptView *courseReminderView = [[BPPromptView alloc] initWithFrame:CGRectMake(0, 0, width, viewH)];
    self.courseReminderView = courseReminderView;
    
    CGRect tabBarButtonFrame = [self getRectWithTabbarIndex:index];
    if(!CGRectEqualToRect(tabBarButtonFrame, CGRectZero)) {
        [self addSubview:courseReminderView];
        [self bringSubviewToFront:courseReminderView];
        CGFloat x = .0f;
        if (tabBarButtonFrame.origin.x + tabBarButtonFrame.size.width/2.0 + width/2.0 + viewPadding <= self.width) {
            x = ceilf(tabBarButtonFrame.origin.x +tabBarButtonFrame.size.width/2.0- width/2.0 );
            courseReminderView.imageView.frame = CGRectMake(width/2.0 - imageW/2.0, viewH-imageH, imageW, imageH);
        } else {
            x = ceilf(self.width - viewPadding - width);
            CGRect imageRect = courseReminderView.imageView.frame;
            CGFloat offset = tabBarButtonFrame.origin.x+tabBarButtonFrame.size.width/2.0 - x - imageRect.size.width/2.0;
            courseReminderView.imageView.frame = CGRectMake(offset, imageRect.origin.y, imageW, imageH);
        }
        CGFloat y = ceilf(-(viewH+viewBottomPadding));
        courseReminderView.frame = CGRectMake(x, y, width, viewH);
    }
    [courseReminderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
}

- (UIView *)getViewWithTabbarIndex:(NSInteger)index {
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableArray *tabBarButtons = [NSMutableArray array];
    if (index != -1) {
        for (UIView *view in delegate.rootTabbarViewController.tabBar.subviews) {
            if (![NSStringFromClass([view class]) isEqualToString:@"UITabBarButton"]) {
                continue;
            }
            [tabBarButtons addObject:view];
        }
    }
    
    [tabBarButtons sortUsingComparator:^NSComparisonResult(UIView *obj1, UIView *obj2) {
        return obj1.frame.origin.x > obj2.frame.origin.x;
    }];
    
    if(tabBarButtons.count == delegate.rootTabbarViewController.viewControllers.count) {
        if(index >= 0 && index < tabBarButtons.count) {
            UIView *tabbarButtonView = tabBarButtons[index];
            return tabbarButtonView;
        }
    }
    return nil;
}

- (CGRect)getRectWithTabbarIndex:(NSInteger)index {
    UIView *tabbarButtonView = [self getViewWithTabbarIndex:index];
    if (tabbarButtonView) {
        return tabbarButtonView.frame;
    }
    return CGRectZero;
}

//移除控件
- (void)removePromptViewOnItemIndex:(NSInteger)index {
    [self.courseReminderView removeFromSuperview];
    self.courseReminderView = nil;
}

- (BPPromptView *)courseReminderView {
    return objc_getAssociatedObject(self, @selector(setCourseReminderView:));
}

- (void)setCourseReminderView:(BPPromptView *)courseReminderView {
    objc_setAssociatedObject(self, @selector(setCourseReminderView:), courseReminderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIndex:(BOOL)index {
    objc_setAssociatedObject(self, "index", @(index), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)index {
    return [objc_getAssociatedObject(self, "index") intValue];
}

@end
