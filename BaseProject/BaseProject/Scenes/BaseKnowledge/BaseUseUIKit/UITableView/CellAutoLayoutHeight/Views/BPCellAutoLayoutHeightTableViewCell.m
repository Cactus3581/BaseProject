//
//  BPCellAutoLayoutHeightTableViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellAutoLayoutHeightTableViewCell.h"

@interface BPCellAutoLayoutHeightTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *chatHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineBottomConstraint;
@end

@implementation BPCellAutoLayoutHeightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor =  kWhiteColor;
    self.backgroundView = view;
    self.lineView.backgroundColor = kLightGrayColor;
    self.lineBottomConstraint.constant = kOnePixel;
    CGFloat preferredWidth = kScreenWidth - (15+20+15) - (15);
//    _nameLabel.preferredMaxLayoutWidth = preferredWidth;
//    _titleLabel.preferredMaxLayoutWidth = preferredWidth;
}

//iOS8计算高度
- (void)set1stModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath {
    _chatHeadImageView.image = [UIImage imageNamed:model.headImage];
    _titleLabel.text = model.text;
    _nameLabel.text = model.name;
    _photoImageView.image = [UIImage imageNamed:model.photoImage];
    _chatHeadImageView.layer.masksToBounds = YES;
    _photoImageView.layer.masksToBounds = YES;
}

//iOS6计算高度
- (void)set2ndModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath {
    //必须设置label的最大宽度，不然系统无法计算label的最大高度
    CGFloat preferredWidth = kScreenWidth - (15+20+15) - (15);
    _nameLabel.preferredMaxLayoutWidth = preferredWidth;
    _titleLabel.preferredMaxLayoutWidth = preferredWidth;
    _chatHeadImageView.image = [UIImage imageNamed:model.headImage];
    _titleLabel.text = model.text;
    _nameLabel.text = model.name;
    _photoImageView.image = [UIImage imageNamed:model.photoImage];
    _chatHeadImageView.layer.masksToBounds = YES;
    _photoImageView.layer.masksToBounds = YES;
}

//手算 在model里计算
- (void)set3rdModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath {
    _chatHeadImageView.image = [UIImage imageNamed:model.headImage];
    _titleLabel.text = model.text;
    _nameLabel.text = model.name;
    _photoImageView.image = [UIImage imageNamed:model.photoImage];
    _chatHeadImageView.layer.masksToBounds = YES;
    _photoImageView.layer.masksToBounds = YES;
}

//手算-2 在cell里计算
+ (CGFloat)height3rdWithModel:(BPCellAutoLayoutHeightModel *)model {
    if (!model.cell3rdHeight) {
        // 文字的最大尺寸(设置内容label的最大size，这样才可以计算label的实际高度，需要设置最大宽度，但是最大高度不需要设置，只需要设置为最大浮点值即可)，53为内容label到cell左边的距离
        CGSize maxSize = CGSizeMake(kScreenWidth - (15+20+15+15), MAXFLOAT);
        // 计算内容label的高度
        CGFloat nameTextH = [BPCellAutoLayoutHeightTableViewCell getHeightWithString:model.name font:[UIFont systemFontOfSize:17] width:maxSize.width lineSpace:0 kern:0];
        CGFloat textTextH = [BPCellAutoLayoutHeightTableViewCell getHeightWithString:model.text font:[UIFont systemFontOfSize:17] width:maxSize.width lineSpace:0 kern:0];
        UIImage *image = [UIImage imageNamed:model.photoImage];
        CGFloat imageH = image.size.height;
        model.cell3rdHeight = 10 + nameTextH + 10 + textTextH + 10 + imageH + 1;
    }
    return model.cell3rdHeight;
}

//手算-3 : 在cell里计算，利用layoutIfNeeded获取高度，弊端太多了，高度没有缓存，因为没利用好model的height
+ (CGFloat)height3rdWithModel1:(BPCellAutoLayoutHeightModel *)model {
    BPCellAutoLayoutHeightTableViewCell *cell = [[BPCellAutoLayoutHeightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BPCellAutoLayoutHeightTableViewCell"];
    [cell set3rdModel:model indexPath:nil];
    [cell layoutIfNeeded];
    CGRect frame = cell.contentView.frame;
    return frame.size.height;
}

+ (CGFloat )getHeightWithString:(NSString *)string font:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace kern:(CGFloat)kern {
    if (!BPValidateString(string).length) {
        return 0;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;//设置行间距
    NSDictionary *attriDict = @{
                                NSParagraphStyleAttributeName:paragraphStyle,
                                //NSKernAttributeName:@(kern),//字间距
                                NSFontAttributeName:font
                                };
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attriDict context:nil].size;
    return ceilf(size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
