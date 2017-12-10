//
//  UILabel+SuggestSize.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BPSuggestSize)

- (CGSize)bp_suggestedSizeForWidth:(CGFloat)width;
- (CGSize)bp_suggestSizeForAttributedString:(NSAttributedString *)string width:(CGFloat)width;
- (CGSize)bp_suggestSizeForString:(NSString *)string width:(CGFloat)width;

@end
