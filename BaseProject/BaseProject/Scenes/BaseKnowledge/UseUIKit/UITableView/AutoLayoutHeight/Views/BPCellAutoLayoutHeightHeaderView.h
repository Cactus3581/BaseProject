//
//  BPCellAutoLayoutHeightHeaderView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPCellAutoLayoutHeightHeaderView;

@protocol BPCellAutoLayoutHeightHeaderViewDelegate<NSObject>
@optional
- (void)headerViewAction:(BPCellAutoLayoutHeightHeaderView *)view;
@end

@interface BPCellAutoLayoutHeightHeaderView : UITableViewHeaderFooterView
@property (nonatomic,weak) id <BPCellAutoLayoutHeightHeaderViewDelegate>delegate;
@end
