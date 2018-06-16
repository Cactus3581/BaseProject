//
//  BPFlowCatergoryView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPFlowCatergoryView;

@protocol BPFlowCatergoryViewDelegate <NSObject>
@optional
- (UIViewController *)flowCatergoryView:(BPFlowCatergoryView *)flowCatergoryView cellForItemAtIndexPath:(NSInteger)row;
- (void)flowCatergoryViewDidScroll:(BPFlowCatergoryView *)flowCatergoryView;
- (void)flowCatergoryViewDidEndDecelerating:(BPFlowCatergoryView *)flowCatergoryView;


@end


@interface BPFlowCatergoryView : UIView
@property (nonatomic, strong,readonly) NSMutableDictionary *vcCacheDic;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<BPFlowCatergoryViewDelegate>delegate;
@property (nonatomic, assign) CGFloat tagViewHeight;
- (void)reloadData;
@end
