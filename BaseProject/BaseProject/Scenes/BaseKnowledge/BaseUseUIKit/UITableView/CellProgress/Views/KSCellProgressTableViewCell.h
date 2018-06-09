//
//  KSCellProgressTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSCellProgressModel.h"

@interface KSCellProgressTableViewCell : UITableViewCell

@property (nonatomic, strong)   KSCellProgressModel *model;

- (void)setLabelIndex:(NSUInteger)index model:(KSCellProgressModel *)model;

@end
