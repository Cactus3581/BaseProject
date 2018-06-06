//
//  BPTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTableViewCell.h"

@interface BPTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation BPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.selectionStyle = UITableViewCellSelectionStyleNone;//取消选中状态方法
    self.backgroundColor = kYellowColor;
    self.contentView.backgroundColor = kYellowColor;
    self.backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    self.textLabel.text = text;
}

@end
