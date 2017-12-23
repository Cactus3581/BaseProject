//
//  UILabel+KSInterval.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//
#import "UILabel+KSInterval.h"

@implementation UILabel (KSInterval)

/**
 *  改变行间距
 */
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing <= CGFLOAT_MIN || !BPValidateString(text).length) {
        self.text = kPlacedString;
        return;
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, [text length])];

    self.attributedText = attributedString;
}


/**
 *  改变字间距
 */
- (void)setText:(NSString*)text kernSpacing:(CGFloat)kernSpacing {
    if (kernSpacing <= CGFLOAT_MIN || !BPValidateString(text).length) {
        self.text = kPlacedString;
        return;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSKernAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSKernAttributeName value:@(kernSpacing) range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

/**
 *  改变行间距和字间距
 */
- (void)setText:(NSString*)text ineSpacing:(CGFloat)lineSpacing kernSpacing:(CGFloat)kernSpacing {
    if (kernSpacing <= CGFLOAT_MIN ||lineSpacing <= CGFLOAT_MIN || !BPValidateString(text).length) {
        self.text = kPlacedString;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:kernSpacing];
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    //NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f};
    //NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:dic];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSKernAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSKernAttributeName value:@(kernSpacing) range:NSMakeRange(0, [text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

@end
