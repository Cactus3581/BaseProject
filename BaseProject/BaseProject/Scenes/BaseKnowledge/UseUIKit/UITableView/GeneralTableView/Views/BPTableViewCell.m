//
//  BPTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTableViewCell.h"
#import "UIResponder+BPMsgSend.h"

@interface BPTableViewCell()

@end


@implementation BPTableViewCell

// code 下的初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 选中状态方法
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 辅助视图
    self.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    self.textLabel.text = text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"Sub");
    [self bp_routerEventWithName:@"" userInfo:nil];
}

@end
