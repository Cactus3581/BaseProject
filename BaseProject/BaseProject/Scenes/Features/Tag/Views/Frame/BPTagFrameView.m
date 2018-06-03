//
//  BPTagFrameView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagFrameView.h"
#import "UIView+BPAdd.h"

@interface BPTagFrameView()
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,weak) UIView *backView;
@end

@implementation BPTagFrameView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultPropertyValue];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
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
    // 设置self的宽度按照父视图的比例进行缩放，距离父视图顶部、左边距和右边距的距离不变
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
//    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
    self.backgroundColor = kYellowColor;
    // 设置backView的宽度按照父视图（self）的比例进行缩放
    self.backView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.buttonArray removeAllObjects];
    self.viewHeight = 0;
    __block CGFloat height = 0.f;
    [self.titlesArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置button的宽度按照父视图（backView）的比例进行缩放
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
        self.viewHeight = height + self.contentInsets.bottom;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backView.center = CGPointMake(self.width/2.0, self.height/2.0);
    self.backView.bounds = CGRectMake(0, 0, self.width-self.contentInsets.left-self.contentInsets.right, self.height-self.contentInsets.top-self.contentInsets.bottom);
    __block CGFloat width = 0;
    [self.titlesArray enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = self.buttonArray[idx];
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:self.font}];
        width = self.interval + size.width + self.interval;
        if (idx == 0) {
            button.frame = CGRectMake(0, 0, width<=self.backView.width ? width:self.backView.width, self.itemHeight);
        }else {
            UIButton *lastButton = self.buttonArray[idx-1];
            if (lastButton.x + lastButton.width + self.horizontalSpacing + width > self.width-self.contentInsets.left-self.contentInsets.right) {//另起一行
                button.frame = CGRectMake(0, CGRectGetMaxY(lastButton.frame)+self.verticalSpacing, width <= self.backView.width ? width:self.backView.width, self.itemHeight);
            }else {
                button.frame = CGRectMake(CGRectGetMaxX(lastButton.frame)+self.horizontalSpacing, lastButton.y, self.interval+size.width + self.interval, self.itemHeight);
            }
        }
    }];
    UIButton *button = self.buttonArray.lastObject;
    CGFloat height= 0;
    if (button) {
        height = self.contentInsets.top + CGRectGetMaxY(button.frame) + self.contentInsets.bottom;
        CGRect rect = self.frame;
        rect.size.height = height;
        self.frame = rect;
        self.backView.center = CGPointMake(self.width/2.0, self.height/2.0);
        self.backView.bounds = CGRectMake(0, 0, self.width-self.contentInsets.left-self.contentInsets.right, self.height-self.contentInsets.top-self.contentInsets.bottom);
    }
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
        backView.backgroundColor = kPurpleColor;
        [self addSubview:backView];
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
