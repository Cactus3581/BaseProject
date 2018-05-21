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
@property (nonatomic,weak) UIView *backView;
@end

@implementation BPTagLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultPropertyValue];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDefaultPropertyValue];
}

- (void)setTitlesArray:(NSArray<NSString *> *)titlesArray {
    _titlesArray = titlesArray;
    [self initSubViews];
}

- (void)setDefaultPropertyValue {
    self.font = [UIFont systemFontOfSize:14];
    self.itemHeight = 30;
    self.contentInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    self.horizontalSpacing = 10;
    self.verticalSpacing = 10;
    self.interval = 15;
    self.textColor = kPurpleColor;
    self.itemBackgroundColor = kGreenColor;
}

- (void)initSubViews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.buttonArray removeAllObjects];
    self.height = 0;
    __block CGFloat height = 0.f;
    [self.titlesArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenHighlighted = NO;
        button.highlighted = NO;
        button.showsTouchWhenHighlighted = NO;
        [self.backView addSubview:button];
        button.backgroundColor = self.itemBackgroundColor;
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
            
            if (idx == self.titlesArray.count-1) {// 高度自适应用的
                [button mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.backView);
                }];
            }
        }
    }];
}

- (void)updateConstraints {
    [super updateConstraints];
}

#pragma mark - reloadData action methods
- (void)reloadData {
    
}

#pragma mark - item status methods
- (void)removeStatus {
    
}

- (UIButton *)viewAtIndex:(NSInteger)index {
    return BPValidateArrayObjAtIdx(self.buttonArray, index);
}

- (NSInteger)indexOfObject:(UIButton *)button {
    if ([self.buttonArray containsObject:button]) {
        return [self.buttonArray indexOfObject:button];
    }
    return -1;
}

#pragma mark - didSelect action methods
- (void)didSelectItemAtIndexPathWithButton:(UIButton *)button {
    self.index = -1;
    if ([self.buttonArray containsObject:button]) {
        self.index = [self.buttonArray indexOfObject:button];
        if (_delegate && [_delegate respondsToSelector:@selector(tagLabelView:didSelectRowAtIndex:)]) {
            [_delegate tagLabelView:self didSelectRowAtIndex:self.index];
        }
    }
}

#pragma mark - lazy load methods
-  (UIView *)backView {
    if (!_backView) {
        UIView *backView = [[UIView alloc] init];
        _backView = backView;
        [self addSubview:backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(self.contentInsets.top);
            make.leading.equalTo(self).offset(self.contentInsets.left);
            make.bottom.equalTo(self).offset(-self.contentInsets.bottom);
            make.trailing.equalTo(self).offset(-self.contentInsets.right);
        }];
    }
    return _backView;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

@end
