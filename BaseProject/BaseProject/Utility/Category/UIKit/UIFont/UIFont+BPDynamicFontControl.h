//
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (BPDynamicFontControl)

+ (UIFont *)bp_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName scale:(CGFloat)scale;

+ (UIFont *)bp_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName;

- (UIFont *)bp_adjustFontForTextStyle:(NSString *)style;

- (UIFont *)bp_adjustFontForTextStyle:(NSString *)style scale:(CGFloat)scale;

@end
