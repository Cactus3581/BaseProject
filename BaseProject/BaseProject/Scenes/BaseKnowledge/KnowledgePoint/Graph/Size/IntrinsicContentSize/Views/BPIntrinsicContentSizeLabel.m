//
//  BPIntrinsicContentSizeLabel.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/23.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIntrinsicContentSizeLabel.h"
@interface BPIntrinsicContentSizeLabel()
@property (nonatomic, assign) CGSize intervalSize;
@end

@implementation BPIntrinsicContentSizeLabel

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    if (self.text && [self.text length] > 0) {
        size.width+=40;
    }
    return size;
}

@end
