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
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] init];
//        backView.backgroundColor = kYellowColor;
        backView.backgroundColor = kWhiteColor;

        self.backgroundView = backView;
    }
    return self;
}

- (void)setModel:(KSMultiLevelCatalogueModel2nd *)model section:(NSInteger)section {
    NSString *str = BPValidateString(model.title_2nd);
    if (str.length) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
        [string addAttribute:NSForegroundColorAttributeName value:kLightGrayColor range:NSMakeRange(0, str.length)];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, str.length)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;
        [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        _textSectionLabel.attributedText = string;
    }
}

@end
