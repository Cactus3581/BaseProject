//
//  UIBezierPath+BPBasicShapes.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (BPBasicShapes)

+ (UIBezierPath *)bp_heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)bp_userShape:(CGRect)originalFrame;
+ (UIBezierPath *)bp_martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)bp_beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)bp_starShape:(CGRect)originalFrame;
+ (UIBezierPath *)bp_stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end
