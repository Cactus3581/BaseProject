//
//  BPTableViewSectionHeaderView.m
//  BaseProject
//
//  Created by Ryan on 2019/8/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPTableViewSectionHeaderView.h"

@implementation BPTableViewSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] initWithFrame:self.contentView.bounds];
    view.backgroundColor = kWhiteColor;
    self.backgroundView = view;
}

@end
