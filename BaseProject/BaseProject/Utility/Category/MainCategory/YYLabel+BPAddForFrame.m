//
//  YYLabel+BPAddForFrame.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "YYLabel+BPAddForFrame.h"
#import "UIView+BPAddForFrame.h"
#import "NSString+BPAdd.h"

@implementation YYLabel (BPAddForFrame)

- (CGSize)bp_contentSize{
    return [self.text  bp_sizeWithfont:self.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

@end
