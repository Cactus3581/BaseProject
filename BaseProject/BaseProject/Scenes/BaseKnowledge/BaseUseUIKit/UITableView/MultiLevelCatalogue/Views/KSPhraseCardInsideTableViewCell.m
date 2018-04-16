//
//  KSPhraseCardInsideTableViewCell.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSPhraseCardInsideTableViewCell.h"

@interface KSPhraseCardInsideTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *numbertagLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@end

@implementation KSPhraseCardInsideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kWhiteColor;
//    backView.backgroundColor = kBlueColor;
    
    self.backgroundView = backView;
    _englishLabel.backgroundColor = kPurpleColor;
    _chineseLabel.backgroundColor = kOrangeColor;
    _numbertagLabel.layer.cornerRadius = 7.5;
    _numbertagLabel.layer.masksToBounds = YES;
    _numbertagLabel.layer.borderColor = [kLightGrayColor CGColor];
    _numbertagLabel.layer.borderWidth = kOnePixel;
    _numbertagLabel.textColor = kLightGrayColor;
}

- (void)setModel:(KSMultiLevelCatalogueModel3rd *)model indexPath:(NSIndexPath *)indexPath {
    NSString *title = BPValidateString(model.title_3rd);
    NSString *lj_ls = BPValidateString(model.brief_3rd);
    if (title.length && lj_ls.length) {
        _numbertagLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        _englishLabel.attributedText = [self configAttributedText:title lineSpace:1 textColor:kBlackColor];
        _chineseLabel.attributedText = [self configAttributedText:lj_ls lineSpace:4 textColor:kLightGrayColor];
    }
}

- (NSMutableAttributedString *)configAttributedText:(NSString *)text lineSpace:(CGFloat)lineSpace textColor:(UIColor *)textColor{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    //设置指定范围内的 字体大小
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str.length)];
    //设置指定范围内 字体颜色
    [str addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, str.length)];
    //设置字体所在区域的背景颜色
//    [str addAttribute:NSBackgroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, str.length)];
    //填充部分颜色，不是字体颜色，取值为 UIColor 对象
//    [str addAttribute:NSStrokeColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, str.length)];
    //设置文本段落排版格式，取值为 NSParagraphStyle 对象
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpace;//设置行间距
    paragraph.alignment = NSTextAlignmentLeft;//设置对齐方式
    //paragraph.lineBreakMode = NSLineBreakByCharWrapping;//换行方式
    [str addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, str.length)];//段落
    //[self handleString:text str1:str];
    return str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
