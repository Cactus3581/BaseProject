//
//  BPPaddingButton.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPaddingButton.h"
@interface BPPaddingButton()
@property (nonatomic,weak) UIView *redPointView;
@end

@implementation BPPaddingButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kThemeColor;
        [self addRedPoint];
    }
    return self;
}


//在原来的内容size上，增加或者减少size，跟自身frame没有关系，只跟内容有关系
//- (CGSize)intrinsicContentSize {
//    CGSize size = [super intrinsicContentSize];
//    return CGSizeMake(size.width+20, size.height);
//}

//在原来的大小上，增加或者减少size
- (UIEdgeInsets)alignmentRectInsets {
    return UIEdgeInsetsMake(.0, .0, 30.0, -10);
}

//- (CGRect)alignmentRectForFrame:(CGRect)frame {
//
//}

//
//- (CGRect)frameForAlignmentRect:(CGRect)alignmentRectc {
//
//}

- (void)addRedPoint {
    UIView *redPointView = [[UIView alloc] init];
    _redPointView = redPointView;
    [self addSubview:redPointView];
    redPointView.backgroundColor = kGreenColor;
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.top.equalTo(self).mas_offset(-10);
        make.trailing.equalTo(self);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
