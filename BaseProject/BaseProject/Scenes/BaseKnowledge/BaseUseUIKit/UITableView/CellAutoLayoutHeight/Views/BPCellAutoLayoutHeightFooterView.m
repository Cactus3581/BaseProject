//
//  BPCellAutoLayoutHeightFooterView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellAutoLayoutHeightFooterView.h"
@interface BPCellAutoLayoutHeightFooterView()
@property (weak, nonatomic) IBOutlet UIButton *footerButton;
@end

@implementation BPCellAutoLayoutHeightFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kRedColor;
}

- (IBAction)footerAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(footerViewAction:)]) {
        [_delegate footerViewAction:self];
    }
}

@end
