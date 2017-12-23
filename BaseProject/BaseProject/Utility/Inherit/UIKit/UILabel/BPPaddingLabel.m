//
//  BPPaddingLabel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/4.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPPaddingLabel.h"

@implementation BPPaddingLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
