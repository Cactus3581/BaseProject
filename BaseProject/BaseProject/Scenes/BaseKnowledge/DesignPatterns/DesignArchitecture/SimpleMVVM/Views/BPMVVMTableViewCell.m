//
//  BPMVVMTableViewCell.m
//  BaseProject
//
//  Created by Ryan on 2019/1/16.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPMVVMTableViewCell.h"
#import "BPMVVMModel.h"
#import <Masonry.h>

static NSString *cellIdentifier = @"BPMVVMTableViewCell";

@implementation BPMVVMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BPMVVMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPMVVMTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = kBlackColor;
    }
    return cell;
}

- (void)setModel:(BPMVVMModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    self.textLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row+1,model.title];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

