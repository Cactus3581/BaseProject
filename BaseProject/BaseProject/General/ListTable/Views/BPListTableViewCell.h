//
//  BPListTableViewCell.h
//  BaseProject
//
//  Created by Ryan on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPListModel;

@interface BPListTableViewCell : UITableViewCell

@property (nonatomic,strong) BPListModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setModel:(BPListModel *)model indexPath:(NSIndexPath *)indexPath;

@end
