//
//  DHSlideView.h
//  DHSlideViewDemo
//
//  Created by daixinhui on 15/10/14.
//  Copyright © 2015年 daixinhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHSlideView;
@protocol DHSlideViewDataSource <NSObject>

- (NSInteger)numberOfControllersInDHSlideView:(DHSlideView *)slideView;
- (UIViewController *)DHSlideView:(DHSlideView *)slideView viewControllerAtIndex:(NSInteger)index;

@end

@protocol DHSlideViewDelegate <NSObject>
@optional

- (void)DHSlideView:(DHSlideView *)slideView fromIndex:(NSInteger)oldIndex toIndex:(NSInteger)toIndex percent:(float)percent;
- (void)DHSlideView:(DHSlideView *)slideView didSelectIndex:(NSInteger)index;
- (void)DHSlideView:(DHSlideView *)slideView cancelIndex:(NSInteger)index;

@end

@interface DHSlideView : UIView

@property (nonatomic, assign) NSInteger selecteIndex;
@property (nonatomic, weak) UIViewController *baseViewController;
@property (nonatomic, weak) id <DHSlideViewDataSource> dataSource;
@property (nonatomic, weak) id <DHSlideViewDelegate> delegate;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

//- (void)switchToIndex:(NSInteger)index;

@end
