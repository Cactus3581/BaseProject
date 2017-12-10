//
//  UIFont+BPAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>
#import "BPCGUtilities.h"

@interface UIFont (BPAdd)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - check font type

@property (nonatomic, readonly) BOOL isBold NS_AVAILABLE_IOS(7_0); ///< Whether the font is bold.
@property (nonatomic, readonly) BOOL isItalic NS_AVAILABLE_IOS(7_0); ///< Whether the font is italic.
@property (nonatomic, readonly) BOOL isMonoSpace NS_AVAILABLE_IOS(7_0); ///< Whether the font is mono space.
@property (nonatomic, readonly) BOOL isColorGlyphs NS_AVAILABLE_IOS(7_0); ///< Whether the font is color glyphs (such as Emoji).
@property (nonatomic, readonly) CGFloat fontWeight NS_AVAILABLE_IOS(7_0); ///< Font weight from -1.0 to 1.0. Regular weight

#pragma mark - font type change

@property (nullable, nonatomic, readonly) UIFont *boldFont;
@property (nullable, nonatomic, readonly) UIFont *italicFont;
@property (nullable, nonatomic, readonly) UIFont *boldItalicFont;
@property (nullable, nonatomic, readonly) UIFont *normalFont;

#pragma mark - create font

+ (nullable UIFont *)bp_fontWithCTFont:(CTFontRef)CTFont;
+ (nullable UIFont *)bp_fontWithCGFont:(CGFontRef)CGFont size:(CGFloat)size;


@property (nullable, nonatomic, readonly) CTFontRef ctFontRef CF_RETURNS_RETAINED;
@property (nullable, nonatomic, readonly) CGFontRef cgFontRef CF_RETURNS_RETAINED;

#pragma mark - Load and unload font

+ (BOOL)bp_loadFontFromPath:(NSString *)path;
+ (void)bp_unloadFontFromPath:(NSString *)path;
+ (nullable UIFont *)bp_loadFontFromData:(NSData *)data;
+ (BOOL)bp_unloadFontFromData:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
