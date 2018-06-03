//
//  BPIntrinsicContentSizeLabel.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIntrinsicContentSizeLabel.h"

@implementation BPIntrinsicContentSizeLabel

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += 20;
    size.height += 20;
    return size;
}

@end
