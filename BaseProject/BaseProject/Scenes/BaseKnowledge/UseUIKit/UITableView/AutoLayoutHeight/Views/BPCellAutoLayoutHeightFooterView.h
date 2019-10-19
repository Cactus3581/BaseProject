//
//  BPCellAutoLayoutHeightFooterView.h
//  BaseProject
//
//  Created by Ryan on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPCellAutoLayoutHeightFooterView;


@protocol BPCellAutoLayoutHeightFooterViewDelegate<NSObject>
@optional
- (void)footerViewAction:(BPCellAutoLayoutHeightFooterView *)view;
@end

@interface BPCellAutoLayoutHeightFooterView : UITableViewHeaderFooterView
@property (nonatomic,weak) id <BPCellAutoLayoutHeightFooterViewDelegate>delegate;
@end
