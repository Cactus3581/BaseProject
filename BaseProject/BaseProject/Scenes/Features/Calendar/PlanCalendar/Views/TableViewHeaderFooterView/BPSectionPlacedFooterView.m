//
//  BPSectionPlacedFooterView.m
//  BaseProject
//
//  Created by Ryan on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPSectionPlacedFooterView.h"

@implementation BPSectionPlacedFooterView

- (instancetype)init {
   self = [super init];
    if (self) {
        self.contentView.backgroundColor = kLightGrayColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kLightGrayColor;
}

@end
