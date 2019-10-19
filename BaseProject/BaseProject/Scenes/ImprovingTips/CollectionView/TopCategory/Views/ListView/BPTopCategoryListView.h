//
//  BPTopCategoryListView.h
//  BaseProject
//
//  Created by Ryan on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPTopCategoryModel.h"

@protocol BPTopCategoryListViewDelegate<NSObject>
@optional
// 点击cell回调
- (void)didSelectWithModel:(BPTopCategoryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
@end

@interface BPTopCategoryListView : UIView
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSArray *array;
@property(nonatomic,weak) id<BPTopCategoryListViewDelegate> delegate;
@end
