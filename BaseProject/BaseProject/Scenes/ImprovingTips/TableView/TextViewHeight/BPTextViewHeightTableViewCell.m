//
//  BPTextViewHeightTableViewCell.m
//  BaseProject
//
//  Created by Ryan on 2020/4/8.
//  Copyright © 2020 cactus. All rights reserved.
//

#import "BPTextViewHeightTableViewCell.h"

@implementation BPTextViewHeightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _textView.backgroundColor = kRedColor;
    //内容缩进为0（去除左右边距）
    self.textView.textContainer.lineFragmentPadding = 0;
    //文本边距设为0（去除上下边距）
    self.textView.textContainerInset = UIEdgeInsetsZero;

//    self.textView.scrollEnabled = false;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
