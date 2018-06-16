//
//  UIFont+DynamicFontControl.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "UIFont+BPDynamicFontControl.h"

@implementation UIFont (BPDynamicFontControl)

+ (UIFont *)bp_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName{
    return [UIFont bp_preferredFontForTextStyle:style withFontName:fontName scale:1.0f];
}

+ (UIFont *)bp_preferredFontForTextStyle:(NSString *)style withFontName:(NSString *)fontName scale:(CGFloat)scale{
    
    
    UIFont * font = nil;
    if([[UIFont class] resolveClassMethod:@selector(preferredFontForTextStyle:)]){
        font = [UIFont preferredFontForTextStyle:fontName];
    }else{
        font = [UIFont fontWithName:fontName size:14 * scale];
    }
    
    
    return [font bp_adjustFontForTextStyle:style];

}

- (UIFont *)bp_adjustFontForTextStyle:(NSString *)style{
    return [self bp_adjustFontForTextStyle:style scale:1.0f];
}

- (UIFont *)bp_adjustFontForTextStyle:(NSString *)style scale:(CGFloat)scale{
    
    UIFontDescriptor * fontDescriptor = nil;
    
    if([[UIFont class] resolveClassMethod:@selector(preferredFontForTextStyle:)]){
        
        fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:style];
        
    }else{
        
        fontDescriptor = self.fontDescriptor;
        
    }
    
    float dynamicSize = [fontDescriptor pointSize] * scale + 3;
    
    return [UIFont fontWithName:self.fontName size:dynamicSize];
    
}

@end
