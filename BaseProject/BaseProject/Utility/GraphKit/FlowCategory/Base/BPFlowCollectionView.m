//
//  BPFlowCollectionView.m
//  BaseProject
//
//  Created by Ryan on 16/3/3.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import "BPFlowCollectionView.h"

@implementation BPFlowCollectionView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layer insertSublayer:self.backLayer atIndex:0];
}

@end
