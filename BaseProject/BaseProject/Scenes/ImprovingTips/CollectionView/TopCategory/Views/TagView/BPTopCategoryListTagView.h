//
//  BPTopCategoryListTagView.h
//  BaseProject
//
//  Created by Ryan on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPTopCategoryModel.h"

@protocol BPTopCategoryListTagViewDelegate<NSObject>
@optional
- (void)didSelectWithModel:(BPTopCategorySecondCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
- (void)getHeight:(CGFloat)height;
@end

@interface BPTopCategoryListTagView : UIView

@property (nonatomic,assign,readonly,getter = getHeight) CGFloat cardHeight;

@property (nonatomic,strong) BPTopCategoryFirstCategoryModel *model;
@property(nonatomic,weak) id<BPTopCategoryListTagViewDelegate> delegate;
@end
