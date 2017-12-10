//
//  UIFont+WDCustomLoader.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 You can use `UIFont+WDCustomLoader` category to load custom fonts for your
 application without worring about plist or real font names.
 */
@interface UIFont (JKCustomLoader)

/// @name Implicit registration and font loading

/**
 Get `UIFont` object for the selected font file.
 
 This method calls `+customFontWithURL:size`.
 
 @deprecated
 @see +customFontWithURL:size: method
 @param size Font size
 @param name Font filename without extension
 @param extension Font filename extension (@"ttf" and @"otf" are supported)
 @return `UIFont` object or `nil` on errors
 */
+ (UIFont *)bp_customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension  __attribute__ ((deprecated));

/**
 Get `UIFont` object for the selected font file (*.ttf or *.otf files).
 
 The first call of this method will register the font using 
 `+registerFontFromURL:` method.
 
 @see +registerFontFromURL: method
 @param fontURL Font file absolute url
 @param size Font size
 @return `UIFont` object or `nil` on errors
 */
+ (UIFont *)bp_customFontWithURL:(NSURL *)fontURL size:(CGFloat)size;

/// @name Explicit registration

/**
 Allow custom fonts registration.
 
 With this method you can load all supported font file: ttf, otf, ttc and otc.
 Font that are already registered, with this library or by system, will not be 
 registered and you will see a warning log.
 
 @param fontURL Font file absolute url
 @return An array of postscript name which represent the file's font(s) or `nil`
 on errors. (With iOS < 7 as target you will see an empty array for collections)
 */
+ (NSArray *)bp_registerFontFromURL:(NSURL *)fontURL;



@end
