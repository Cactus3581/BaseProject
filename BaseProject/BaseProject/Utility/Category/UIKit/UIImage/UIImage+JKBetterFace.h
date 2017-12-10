//
//  UIImage+BetterFace.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JKAccuracy) {
    JKAccuracyLow = 0,
    JKAccuracyHigh,
};

@interface UIImage (JKBetterFace)

- (UIImage *)bp_betterFaceImageForSize:(CGSize)size
                           accuracy:(JKAccuracy)accurary;

@end
