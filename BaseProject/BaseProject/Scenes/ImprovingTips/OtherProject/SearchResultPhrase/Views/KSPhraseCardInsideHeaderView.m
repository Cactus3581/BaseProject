//
//  KSPhraseCardInsideHeaderView.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSPhraseCardInsideHeaderView.h"

@interface KSPhraseCardInsideHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *textSectionLabel;
@end

@implementation KSPhraseCardInsideHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kLevelColor1;
    self.backgroundView = backView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = kLevelColor1;
        self.backgroundView = backView;
    }
    return self;
}

- (void)setModel:(KSDictionarySubItemPhraseJx *)model section:(NSInteger)section {
    NSString *str = BPValidateString(model.jx_cn_mean);
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:kLightGrayColor range:NSMakeRange(0, str.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4;
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    _textSectionLabel.attributedText = string;
}

@end
