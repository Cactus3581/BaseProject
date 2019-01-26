//
//  BPSimpleTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPSimpleModel;

@interface BPSimpleTableViewCell : UITableViewCell

@property (nonatomic,strong) BPSimpleModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setModel:(BPSimpleModel *)model indexPath:(NSIndexPath *)indexPath;
@end
