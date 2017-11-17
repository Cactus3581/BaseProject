//
//  BPXRZTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseTableViewCell.h"
@class BPMasterCatalogueModel;

@interface BPXRZTableViewCell : BPBaseTableViewCell

@property (nonatomic,strong) BPMasterCatalogueModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
