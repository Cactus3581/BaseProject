//
//  BPOptimizeTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/31.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPOptimizeTableViewCell.h"
#import "UIView+BPRoundedCorner.h"
#import "YYWebImage.h"

@implementation BPOptimizeTableViewCell {
    __weak UITableView *_tableView;
    UIView *_headerView;
    UIView *_nameLabel;
    UILabel *_aLabel;
    UIColor *_backColor;
    NSMutableArray<UIView *> *_circles;
}

+ (BPOptimizeTableViewCell *)bp_cellWithTableView:(UITableView *__weak)tableView imageURL:(NSString *)imageURL{
    static NSString *identifier = @"BPOptimizeTableViewCellIdentifier";
    BPOptimizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BPOptimizeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell->_tableView = tableView;
        [cell _bp_initializeUI];
    }
    [cell _bp_updateWithURL:imageURL];
    return cell;
}

- (void)_bp_initializeUI{
    UIColor *backColor = kWhiteColor;
    _backColor = backColor;
    self.contentView.backgroundColor = kYellowColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.layer.opaque = YES;
    _headerView = ({
        UIView *headerView = [UIView new];
        headerView.layer.opaque = YES;
        headerView.backgroundColor = kLightGrayColor;
        headerView.bounds = BPRectMake(0, 0, 100, 100);
        headerView.center = BPPointMake(55, 60);
        headerView.layer.contentsGravity = kCAGravityResizeAspectFill;
        headerView.layer.masksToBounds = YES;
//        [headerView bp_roundedCornerWithCornerRadii:BPSizeMake(50, 50) cornerColor:kGreenColor corners:UIRectCornerAllCorners borderColor:kRedColor borderWidth:widthRatio(2)];
        [self.contentView addSubview:headerView];
        headerView;
    });
    
    _nameLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:widthRatio(9)];
        label.text = @"我是测试";
        label.backgroundColor = kBlackColor;
        label.textColor = kGreenColor;
        label.textAlignment = 1;
        label.layer.opaque = YES;
        label.layer.masksToBounds = YES;
        label.bounds = BPRectMake(0, 0, 180, 20);
        label.center = BPPointMake(50, 90);
        [_headerView addSubview:label];
        label;
    });
    _aLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:widthRatio(14)];
        label.text = @"这是测试文字";
        label.backgroundColor = kRedColor;
        label.textColor = kBlackColor;
        label.textAlignment = 1;
        label.layer.masksToBounds = YES;
        label.layer.opaque = YES;
        label.bounds = BPRectMake(0, 0, 150, 30);
        label.center = BPPointMake(200, 60);
        [label bp_roundedCornerWithRadius:widthRatio(15) cornerColor:kGreenColor corners:UIRectCornerTopLeft | UIRectCornerBottomRight];
        [self.contentView addSubview:label];
        label;
    });
    
    _circles = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i ++) {
        UIView *littleCircle = [UIView new];
        littleCircle.layer.opaque = YES;
        littleCircle.backgroundColor = kBlueColor;
        littleCircle.bounds = BPRectMake(0, 0, 15, 15);
        littleCircle.center = BPPointMake(110 + 7.5 + 20 * i, 30);
        [littleCircle bp_roundedCornerWithRadius:widthRatio(7.5) cornerColor:backColor];
        [self.contentView addSubview:littleCircle];
        [_circles addObject:littleCircle];
    }
}

- (void)_bp_updateWithURL:(NSString *)imageURL{
    [_headerView.layer yy_setImageWithURL:[NSURL URLWithString:imageURL] options:YYWebImageOptionSetImageWithFadeAnimation];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.selected == selected) return;
    [self _bp_colorWithSelectedorHighlighted:selected];
    [super setSelected:selected animated:animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    if (self.selected) return;
    if (self.highlighted == highlighted) return;
    [self _bp_colorWithSelectedorHighlighted:highlighted];
    [super setHighlighted:highlighted animated:animated];
}

- (void)_bp_colorWithSelectedorHighlighted:(BOOL)flag{
    UIColor *color = flag ? kLightGrayColor : _backColor;
    self.contentView.backgroundColor = color;
    [_headerView bp_roundedCornerWithCornerRadii:BPSizeMake(40, 40) cornerColor:color corners:UIRectCornerAllCorners borderColor:kRedColor borderWidth:widthRatio(2)];
    [_aLabel bp_roundedCornerWithRadius:widthRatio(15) cornerColor:color corners:UIRectCornerTopLeft | UIRectCornerBottomRight];
    [_circles enumerateObjectsUsingBlock:^(UIView * _Nonnull littleCircle, NSUInteger idx, BOOL * _Nonnull stop) {
        [littleCircle bp_roundedCornerWithRadius:widthRatio(7.5) cornerColor:color];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
