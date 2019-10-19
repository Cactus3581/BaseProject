//
//  BPCellProgressTableViewCell.h
//  BaseProject
//
//  Created by Ryan on 2018/3/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPCellProgressModel.h"

@interface BPCellProgressTableViewCell : UITableViewCell

@property (nonatomic, strong)   BPCellProgressModel *model;

- (void)setLabelIndex:(NSUInteger)index model:(BPCellProgressModel *)model;

@end
