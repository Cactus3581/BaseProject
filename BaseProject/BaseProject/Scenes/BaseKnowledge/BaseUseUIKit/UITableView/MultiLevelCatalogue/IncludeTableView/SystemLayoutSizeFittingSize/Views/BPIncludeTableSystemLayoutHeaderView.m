//
//  BPIncludeTableSystemLayoutHeaderView.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "BPIncludeTableSystemLayoutHeaderView.h"

@interface BPIncludeTableSystemLayoutHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *textHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstaint;
@end

@implementation BPIncludeTableSystemLayoutHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = kLevelColor4;
        self.backgroundView = backView;
        _textHeaderLabel.preferredMaxLayoutWidth = self.width-40;
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

- (void)setModel:(BPMultiLevelCatalogueModel1st *)model section:(NSInteger)section {
    NSString *title_1st = BPValidateString(model.title_1st);
    NSString *number = [NSString stringWithFormat:@"%ld.",(long)section+1];

    NSMutableAttributedString *title_1st_attributedString = [[NSMutableAttributedString alloc] initWithString:title_1st];
    NSMutableAttributedString *number_name_attributedString = [[NSMutableAttributedString alloc] initWithString:number];

    [title_1st_attributedString addAttribute:NSForegroundColorAttributeName value:kBlackColor range:NSMakeRange(0, title_1st.length)];
    [number_name_attributedString addAttribute:NSForegroundColorAttributeName value:kGrayColor range:NSMakeRange(0, number.length)];
    UIFont *textFont = [UIFont fontOfSize:15 weight:UIFontWeightMedium];
    [title_1st_attributedString addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, title_1st.length)];
    [number_name_attributedString addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, number.length)];

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;//设置行间距
    [title_1st_attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, title_1st.length)];
    [number_name_attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, number.length)];
    _numberLabel.attributedText = number_name_attributedString;
    _numberLabel.adjustsFontSizeToFitWidth = YES;
    _textHeaderLabel.attributedText = title_1st_attributedString;
    if (section == 0) {
        _topConstaint.constant = 0.f;
        _numberConstraint.constant = 0.f;
    }else {
        _topConstaint.constant = 25.f;
        _numberConstraint.constant = 25.f;
    }
}

@end
