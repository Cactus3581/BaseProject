//
//  BPTagLabelView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/18.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagLabelView.h"
#import "UIView+BPAdd.h"

@interface BPTagLabelView()
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,strong) UIView *backView;

@end

@implementation BPTagLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultPropertyValue];
        [self initSubViews];
    }
    return self;
}

- (void)setDefaultPropertyValue {
    self.font = [UIFont systemFontOfSize:14];
    self.itemHeight = 30;
    self.contentInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    self.horizontalSpacing = 10;
    self.verticalSpacing = 10;
    self.interval = 15;
    self.textColor = kWhiteColor;
    self.backgroundColor = kGreenColor;
}

- (void)initSubViews {
    self.height = 0;
    UIView *backView = [[UIView alloc] init];
    self.backView = backView;
    [self addSubview:backView];
    backView.backgroundColor = kWhiteColor;
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.contentInsets.top);
        make.leading.equalTo(self).offset(self.contentInsets.left);
        make.bottom.equalTo(self).offset(-self.contentInsets.bottom);
        make.trailing.equalTo(self).offset(-self.contentInsets.right);
    }];
    __block CGFloat height = 0.f;
    self.titlesArray = @[@"我爱你",@"可是你并不知道",@"你是不是傻逼",@"嗯",@"别说话",@"滚犊子",@"我去哈哈的，再见～"];
    [self.titlesArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO;
        button.highlighted = NO;
        button.showsTouchWhenHighlighted = NO;
        [backView addSubview:button];
        button.backgroundColor = self.backgroundColor;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:self.textColor forState:UIControlStateNormal];
        button.titleLabel.font = self.font;
        if (idx == 0) {
            height += (self.itemHeight+self.contentInsets.top);

        }else {
            height += (self.itemHeight+self.verticalSpacing);
        }
        [button addTarget:self action:@selector(didSelectItemAtIndexPathWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonArray addObject:button];
    }];
    if (height) {
        self.height = height+self.contentInsets.bottom;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titlesArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = self.buttonArray[idx];
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:self.font}];
        if (idx == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.backView);
                make.height.mas_equalTo(self.itemHeight);
                make.top.equalTo(self.backView);
                make.width.mas_equalTo(self.interval+size.width + self.interval);
            }];
        }else {
            UIButton *lastButton = self.buttonArray[idx-1];
            [self layoutIfNeeded];
            if (lastButton.x + lastButton.width + self.horizontalSpacing + size.width > self.width-self.contentInsets.left-self.contentInsets.right) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(self.backView);
                    make.height.mas_equalTo(self.itemHeight);
                    make.top.equalTo(lastButton.mas_bottom).offset(self.verticalSpacing);
                    make.width.mas_equalTo(self.interval+size.width + self.interval);
                }];
            }else {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.equalTo(lastButton.mas_trailing).offset(self.horizontalSpacing);
                    make.height.mas_equalTo(self.itemHeight);
                    make.top.equalTo(lastButton);
                    make.width.mas_equalTo(self.interval+size.width + self.interval);
                }];
            }
        }
    }];
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)reloadData {
    
}

- (void)removeStatus {
    
}

- (void)didSelectItemAtIndexPathWithButton:(UIButton *)button {
    self.index = -1;
    if ([self.buttonArray containsObject:button]) {
        self.index = [self.buttonArray indexOfObject:button];
        if (_delegate && [_delegate respondsToSelector:@selector(tagLabelView:didSelectRowAtIndex:)]) {
            [_delegate tagLabelView:self didSelectRowAtIndex:self.index];
        }
    }
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
