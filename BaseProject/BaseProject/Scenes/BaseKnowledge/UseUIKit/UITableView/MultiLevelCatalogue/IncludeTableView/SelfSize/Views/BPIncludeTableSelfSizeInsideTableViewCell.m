//
//  BPIncludeTableSelfSizeInsideTableViewCell.m
//  BaseProject
//
//  Created by Ryan on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIncludeTableSelfSizeInsideTableViewCell.h"

@interface BPIncludeTableSelfSizeInsideTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *numbertagLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@property (strong, nonatomic) BPMultiLevelCatalogueModel3rd *model;
@end

@implementation BPIncludeTableSelfSizeInsideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kLevelColor2;
    self.backgroundView = backView;
    _numbertagLabel.layer.cornerRadius = 7.5;
    _numbertagLabel.layer.masksToBounds = YES;
    _numbertagLabel.layer.borderColor = [kGrayColor CGColor];
    _numbertagLabel.layer.borderWidth = kOnePixel;
    _numbertagLabel.textColor = kGrayColor;
    _englishLabel.backgroundColor = kLevelColor1;
    _chineseLabel.backgroundColor = kLevelColor1;
    _chineseLabel.preferredMaxLayoutWidth = kScreenWidth-65;
    _englishLabel.preferredMaxLayoutWidth = kScreenWidth-65;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _chineseLabel.preferredMaxLayoutWidth = self.width-65;
    _englishLabel.preferredMaxLayoutWidth = self.width-65;
}

- (void)setModel:(BPMultiLevelCatalogueModel3rd *)model indexPath:(NSIndexPath *)indexPath {
//    if (_model != model) {
        _model = model;
        NSString *title_3rd = BPValidateString(model.title_3rd);
        NSString *brief_3rd = BPValidateString(model.brief_3rd);
        _numbertagLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row + 1];
        _numbertagLabel.adjustsFontSizeToFitWidth = YES;
        _englishLabel.attributedText = [self configAttributedText:title_3rd lineSpace:1 textColor:kGrayColor];
        _chineseLabel.attributedText = [self configAttributedText:brief_3rd lineSpace:4 textColor:kGrayColor];
        [self.chineseLabel sizeToFit];
        //BPLog(@"englishLabel = %.2f,= %.2f",self.englishLabel.height,[self.englishLabel sizeThatFits:CGSizeMake(310, MAXFLOAT)].height);
        //BPLog(@"chineseLabel = %.2f,= %.2f",self.chineseLabel.height,[self.chineseLabel sizeThatFits:CGSizeMake(310, MAXFLOAT)].height);
//    }
}

- (NSMutableAttributedString *)configAttributedText:(NSString *)text lineSpace:(CGFloat)lineSpace textColor:(UIColor *)textColor{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str.length)];
    [str addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, str.length)];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpace;
    paragraph.alignment = NSTextAlignmentLeft;
    [str addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, str.length)];
    return str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
