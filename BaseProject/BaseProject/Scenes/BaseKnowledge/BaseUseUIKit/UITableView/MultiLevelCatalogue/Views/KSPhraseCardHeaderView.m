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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end

@implementation KSPhraseCardHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] init];
//        backView.backgroundColor = kRedColor;
        backView.backgroundColor = kWhiteColor;

        self.backgroundView = backView;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *backView = [[UIView alloc] init];
    //        backView.backgroundColor = kRedColor;
    backView.backgroundColor = kWhiteColor;
    self.backgroundView = backView;
}

- (void)setModel:(KSMultiLevelCatalogueModel1st *)model section:(NSInteger)section {
    NSString *title_1st = BPValidateString(model.title_1st);
    NSString *str =[NSString stringWithFormat:@"%ld. %@",(long)section+1,model.title_1st];
    NSString *str1 =[NSString stringWithFormat:@"%ld. ",(long)section+1];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:kBlackColor range:NSMakeRange(0, str.length)];
    [string addAttribute:NSForegroundColorAttributeName value:kLightGrayColor range:NSMakeRange(0, str1.length)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] range:NSMakeRange(0, str.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;//设置行间距
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    _textHeaderLabel.attributedText = string;
    if (section == 0) {
        _topConstraint.constant = 0.f;
    }else {
        _topConstraint.constant = 25.f;
    }
}

@end
