//
//  BPFlowCategoryViewProperty.m
//  BaseProject
//
//  Created by xiaruzhen on 16/02/24.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import "BPFlowCategoryViewProperty.h"

@implementation BPFlowCategoryViewProperty

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleFont = [UIFont systemFontOfSize:15];
        _titleColorChangeEable = YES;
        _titleColor = kWhiteColor;
        _titleSelectColor = kRedColor;
        _itemSpacing = 10;
        _edgeSpacing = 20;
        _scaleRatio = 1.1;
    }
    return self;
}

- (CGFloat)scaleRatio{
    return _scaleEnable ? _scaleRatio : 1.0f;
}

@end
