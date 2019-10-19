//
//  BPPaddingButton.m
//  BaseProject
//
//  Created by Ryan on 2018/6/8.
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
//        self.clipsToBounds = YES;
//        self.layer.masksToBounds = YES;
        [self addRedPoint];
    }
    return self;
}

//在原来的内容size上，增加或者减少size，跟自身frame没有关系，只跟内容有关系
//- (CGSize)intrinsicContentSize {
//    CGSize size = [super intrinsicContentSize];
//    return CGSizeMake(size.width, size.height+20);
//}

//在原来的大小上，增加或者减少size,但是内容区域的size不变
//- (UIEdgeInsets)alignmentRectInsets {
//    return UIEdgeInsetsMake(-10, .0, 0.0, -10);
//}

//- (CGRect)alignmentRectForFrame:(CGRect)frame {
//
//}

//
//- (CGRect)frameForAlignmentRect:(CGRect)alignmentRectc {
//
//}

- (void)addRedPoint {
    UILabel *redPointView = [[UILabel alloc] init];
    _redPointView = redPointView;
    redPointView.text = @"1";
    redPointView.textAlignment = NSTextAlignmentCenter;
    [self addSubview:redPointView];
    redPointView.backgroundColor = kRedColor;
    redPointView.textColor = kWhiteColor;
    redPointView.font = [UIFont systemFontOfSize:12];
    redPointView.layer.cornerRadius = 10;
    redPointView.layer.masksToBounds = YES;
    [self.redPointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.top.equalTo(self).mas_offset(0);
        make.trailing.equalTo(self);
    }];
}

@end
