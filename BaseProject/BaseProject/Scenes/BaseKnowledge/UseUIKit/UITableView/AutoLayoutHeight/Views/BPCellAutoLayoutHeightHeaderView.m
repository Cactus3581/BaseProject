//
//  BPCellAutoLayoutHeightHeaderView.m
//  BaseProject
//
//  Created by Ryan on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellAutoLayoutHeightHeaderView.h"

@interface BPCellAutoLayoutHeightHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *headerButton;
@end

@implementation BPCellAutoLayoutHeightHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kRedColor;
}

- (IBAction)headerAction:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(headerViewAction:)]) {
        [_delegate headerViewAction:self];
    }
}

@end
