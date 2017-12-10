//
//  BPSimpleTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPSimpleTableViewCell.h"
#import "BPSimpleModel.h"
static NSString *cellIdentifier = @"BPSimpleTableViewCell";

@implementation BPSimpleTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BPSimpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[BPSimpleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

+ (instancetype)xib_cellWithTableView:(UITableView *)tableView {
    BPSimpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}


- (void)setModel:(BPSimpleModel *)model {
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

