//
//  BPMainPageSpeakNormalHeader.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMainPageSpeakNormalHeader.h"

@interface BPMainPageSpeakNormalHeader()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation BPMainPageSpeakNormalHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor greenColor];
    self.titleLabel.backgroundColor = [UIColor yellowColor];
}

@end
