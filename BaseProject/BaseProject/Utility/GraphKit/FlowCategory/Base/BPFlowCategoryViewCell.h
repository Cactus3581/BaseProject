//
//  BPFlowCategoryViewCell.h
//  BaseProject
//
//  Created by Ryan on 16/02/24.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPFlowCategoryViewCellModel;
@class BPFlowCategoryViewProperty;

@interface BPFlowCategoryViewCell : UICollectionViewCell
@property (nonatomic, copy) BPFlowCategoryViewCellModel *data;
@property (nonatomic, strong) BPFlowCategoryViewProperty *property;

/**如果使用系统的reloadData会重新prepareLayout，在这里是没必要且耗性能的，所以我们自己提供一个刷新状态的方法*/
- (void)bp_updateCell;

@end
