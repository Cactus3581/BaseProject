//
//  BPFlowCategoryImageTagCell.m
//  BaseProject
//
//  Created by Ryan on 2018/6/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPFlowCategoryImageTagCell.h"
#import "BPFlowCategoryViewCellModel.h"
#import "BPFlowCategoryViewProperty.h"
#import "UIColor+BPAdd.h"
#import "UIImageView+WebCache.h"
#import "UIView+BPRoundedCorner.h"

@interface BPFlowCategoryImageTagCell ()
@property (nonatomic, weak) UIImageView *coverImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *colorLabel;
@property (nonatomic, weak) CAShapeLayer *titlemaskLayer;
@property (nonatomic, weak) CAShapeLayer *colormaskLayer;
@end

@implementation BPFlowCategoryImageTagCell

#pragma mark - initialize methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self bp_initializeUI];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _coverImageView.frame = CGRectMake((self.width-50)/2.0, 15, 50, 50);
    _titleLabel.frame = _colorLabel.frame = CGRectMake(0, CGRectGetMaxY(_coverImageView.frame)+12, self.width, self.height-(CGRectGetMaxY(_coverImageView.frame)+12));
}

- (void)bp_initializeUI{
    self.contentView.backgroundColor = kRandomColor;
    UIImageView *coverImageView = [[UIImageView alloc] init];
    _coverImageView = coverImageView;
    coverImageView.backgroundColor = kWhiteColor;
    [coverImageView bp_roundedCornerWithRadius:25 cornerColor:kWhiteColor];
    coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    coverImageView.clipsToBounds = YES;
    [self.contentView addSubview:coverImageView];

    UILabel *titleLabel = [UILabel new];
    _titleLabel = titleLabel;
    _titleLabel.backgroundColor = kWhiteColor;
    titleLabel.textAlignment = 1;
    [self.contentView addSubview:titleLabel];
    UILabel *colorLabel = [UILabel new];
    colorLabel.textColor = kBlackColor;
    _colorLabel = colorLabel;
    colorLabel.textAlignment = 1;
    [self.contentView addSubview:colorLabel];
    CAShapeLayer *titlemaskLayer = [CAShapeLayer new];
    _titlemaskLayer = titlemaskLayer;
    titleLabel.layer.mask = titlemaskLayer;
    CAShapeLayer *colormaskLayer = [CAShapeLayer new];
    _colormaskLayer = colormaskLayer;
    colorLabel.layer.mask = colormaskLayer;
}

#pragma mark - setter methods

- (void)setProperty:(BPFlowCategoryViewProperty *)property {
    _property = property;
    _colorLabel.font = _titleLabel.font = property.titleFont;
    _colorLabel.textColor = _property.titleSelectColor;
    _titleLabel.textColor = _property.titleColor;
}

- (void)setData:(BPFlowCategoryViewCellModel *)data {
    _data = data;
    _colorLabel.text = _titleLabel.text = data.title;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"cactus_theme"]];
    [self bp_updateCell];
}

#pragma mark - private methods

- (void)bp_interpolationColor {
    CGRect titleMaskRect = CGRectZero;
    CGRect colorMaskRect = CGRectZero;
    if (_property.titleColorChangeEable) {
        if (_property.titleColorChangeGradually) {
            _colorLabel.hidden = NO;
            if (_data.ratio >= _data.index) {
                titleMaskRect = CGRectMake(0, 0, self.width * (1 - _data.valueRatio), self.height);
                colorMaskRect = CGRectMake(self.width * (1 - _data.valueRatio), 0, self.width * _data.valueRatio, self.height);
            }else{
                titleMaskRect = CGRectMake(self.width * _data.valueRatio, 0, self.width * (1 - _data.valueRatio), self.height);
                colorMaskRect = CGRectMake(0, 0, self.width * _data.valueRatio, self.height);
            }
            _titlemaskLayer.path = [UIBezierPath bezierPathWithRect:titleMaskRect].CGPath;
            _colormaskLayer.path = [UIBezierPath bezierPathWithRect:colorMaskRect].CGPath;
            
        }else {
            _colorLabel.hidden = YES;
            _titleLabel.layer.mask = nil;
            //渐变色
            _titleLabel.textColor = [UIColor bp_colorWithInterpolationFromValue:_property.titleColor toValue:_property.titleSelectColor ratio:_data.valueRatio];
            //改变选中的字体
            if (_property.titleSelectFont) {
                _colorLabel.font = _titleLabel.font = _property.titleFont;
            }
            if (_data.valueRatio == 1) {
                [self bp_interpolationFont];
            }
        }
    }else{
        _colorLabel.hidden = YES;
        _titleLabel.layer.mask = nil;
    }
}

- (void)bp_interpolationScale {
    CGFloat scale = [self bp_interpolationFromValue:1 toValue:_property.scaleRatio ratio:_data.valueRatio];
    //不能单单对titleLabel进行transform变换，因为有可能变化后超出cell大小文字显示不全；
    self.transform  = CGAffineTransformMakeScale(scale, scale);
}

- (void)bp_interpolationFont {
    if (_property.titleSelectFont) {
        _colorLabel.font = _titleLabel.font = _property.titleSelectFont;
    }
}

/**
 *  插值公式
 */
- (CGFloat)bp_interpolationFromValue:(CGFloat)from toValue:(CGFloat)to ratio:(CGFloat)ratio{
    return from + (to - from) * ratio;
}

#pragma mark - public methods

- (void)bp_updateCell{
    //插值titleColor
    [self bp_interpolationColor];
    //插值scale
    [self bp_interpolationScale];
}

@end

