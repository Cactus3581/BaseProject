//
//  KSPhraseCardHeaderView.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSPhraseCardHeaderView.h"

@interface KSPhraseCardHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *textHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstaint;
@end

@implementation KSPhraseCardHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = kLevelColor4;
        self.backgroundView = backView;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kLevelColor4;
    self.backgroundView = backView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setModel:(KSDictionarySubItemPhrase *)model section:(NSInteger)section {
    NSString *cizu_name = BPValidateString(model.cizu_name);
    NSString *number = [NSString stringWithFormat:@"%ld.",(long)section+1];

    NSMutableAttributedString *cizu_name_attributedString = [[NSMutableAttributedString alloc] initWithString:cizu_name];
    NSMutableAttributedString *number_name_attributedString = [[NSMutableAttributedString alloc] initWithString:number];

    [cizu_name_attributedString addAttribute:NSForegroundColorAttributeName value:kBlackColor range:NSMakeRange(0, cizu_name.length)];
    [number_name_attributedString addAttribute:NSForegroundColorAttributeName value:kGrayColor range:NSMakeRange(0, number.length)];
    UIFont *textFont = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    [cizu_name_attributedString addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, cizu_name.length)];
    [number_name_attributedString addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, number.length)];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;//设置行间距
    [cizu_name_attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, cizu_name.length)];
    [number_name_attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, number.length)];
    _numberLabel.attributedText = number_name_attributedString;
    _numberLabel.adjustsFontSizeToFitWidth = YES;
    _textHeaderLabel.attributedText = cizu_name_attributedString;
    if (section == 0) {
        _topConstaint.constant = 0.f;
        _numberConstraint.constant = 0.f;
    }else {
        _topConstaint.constant = 25.f;
        _numberConstraint.constant = 25.f;
    }
}

@end
