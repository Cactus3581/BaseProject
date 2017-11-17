//
//  BPXRZTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPXRZTableViewCell.h"
#import "BPMasterCatalogueModel.h"
static NSString *cellIdentifier = @"BPXRZTableViewCell";

@implementation BPXRZTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BPXRZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPXRZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

+ (instancetype)xib_cellWithTableView:(UITableView *)tableView {
    BPXRZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}


- (void)setModel:(BPMasterCatalogueModel *)model {
    self.textLabel.text = model.title;
    self.detailTextLabel.text = model.briefIntro;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
