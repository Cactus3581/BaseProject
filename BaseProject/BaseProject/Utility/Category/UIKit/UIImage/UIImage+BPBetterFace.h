//
//  UIImage+BetterFace.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BPAccuracy) {
    BPAccuracyLow = 0,
    BPAccuracyHigh,
};

@interface UIImage (BPBetterFace)

- (UIImage *)bp_betterFaceImageForSize:(CGSize)size
                           accuracy:(BPAccuracy)accurary;

@end
