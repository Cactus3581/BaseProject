//
//  BPFlowCategoryImageView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFlowCategoryImageView;

@protocol BPFlowCategoryImageViewDelegate <NSObject>
@optional
- (UIViewController *)flowCategoryView:(BPFlowCategoryImageView *)flowCategoryView cellForItemAtIndexPath:(NSInteger)row;
- (void)flowCategoryViewDidScroll:(BPFlowCategoryImageView *)flowCategoryView;
- (void)flowCategoryViewDidEndDecelerating:(BPFlowCategoryImageView *)flowCategoryView;
@end

@interface BPFlowCategoryImageView : UIView
@property (nonatomic, strong,readonly) NSMutableDictionary *vcCacheDic;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<BPFlowCategoryImageViewDelegate>delegate;
@property (nonatomic, assign) CGFloat tagViewHeight;

- (void)reloadData;

@end
