//
//  BPFlowMainCatergoryView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPFlowMainCatergoryView;

@protocol BPFlowMainCatergoryViewDelegate <NSObject>
@optional
- (UIViewController *)flowMainCatergoryView:(BPFlowMainCatergoryView *)flowMainCatergoryView cellForItemAtIndexPath:(NSInteger)row;
@end


@interface BPFlowMainCatergoryView : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<BPFlowMainCatergoryViewDelegate>delegate;
- (void)reloadData;
@end
