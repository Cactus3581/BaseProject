//
//  UILabel+SuggestSize.m
//  BaseProject
//
//  Created by Ryan on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UILabel+BPSuggestSize.h"

@implementation UILabel (BPSuggestSize)

- (CGSize)bp_suggestedSizeForWidth:(CGFloat)width {
    if (self.attributedText)
        return [self bp_suggestSizeForAttributedString:self.attributedText width:width];
    
	return [self bp_suggestSizeForString:self.text width:width];
}

- (CGSize)bp_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (CGSize)bp_suggestSizeForString:(NSString *)string width:(CGFloat)width {
    if (!string) {
        return CGSizeZero;
    }
    return [self bp_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

@end
