//
//  BPIncludeTableSelfSizeHeadCell.h
//  BaseProject
//
//  Created by Ryan on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMultiLevelCatalogueModel.h"

@interface BPIncludeTableSelfSizeHeadCell : UITableViewCell
@property (weak, nonatomic)  UITableView *tableView;

- (void)setModel:(BPMultiLevelCatalogueModel2nd *)model indexPath:(NSIndexPath *)indexPath showAll:(BOOL)showAll;
@end
