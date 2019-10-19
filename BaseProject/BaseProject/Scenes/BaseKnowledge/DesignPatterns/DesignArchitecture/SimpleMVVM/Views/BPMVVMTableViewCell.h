//
//  BPMVVMTableViewCell.h
//  BaseProject
//
//  Created by Ryan on 2019/1/16.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPMVVMModel;

NS_ASSUME_NONNULL_BEGIN

@interface BPMVVMTableViewCell : UITableViewCell

@property (nonatomic,strong) BPMVVMModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setModel:(BPMVVMModel *)model indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
