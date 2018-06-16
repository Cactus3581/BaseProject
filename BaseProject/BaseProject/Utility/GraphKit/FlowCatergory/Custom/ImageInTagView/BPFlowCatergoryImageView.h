//
//  BPFlowCatergoryImageView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFlowCatergoryImageView;

@protocol BPFlowCatergoryImageViewDelegate <NSObject>
@optional
- (UIViewController *)flowCatergoryView:(BPFlowCatergoryImageView *)flowCatergoryView cellForItemAtIndexPath:(NSInteger)row;
- (void)flowCatergoryViewDidScroll:(BPFlowCatergoryImageView *)flowCatergoryView;
- (void)flowCatergoryViewDidEndDecelerating:(BPFlowCatergoryImageView *)flowCatergoryView;
@end

@interface BPFlowCatergoryImageView : UIView
@property (nonatomic, strong,readonly) NSMutableDictionary *vcCacheDic;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<BPFlowCatergoryImageViewDelegate>delegate;
@property (nonatomic, assign) CGFloat tagViewHeight;

- (void)reloadData;

@end
