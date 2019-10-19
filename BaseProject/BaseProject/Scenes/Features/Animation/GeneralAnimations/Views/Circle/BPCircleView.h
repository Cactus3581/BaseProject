//
//  BPCircleView.h
//  BaseProject
//
//  Created by Ryan on 2017/8/5.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BPCircleView : UIView
@property (nonatomic,strong) CAShapeLayer *backShapeLayer;
@property (nonatomic,strong) CAShapeLayer *maskShapeLayer;
@property (nonatomic,strong) CALayer *backLayer;

@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@property (nonatomic,strong) CAGradientLayer *gradientLayer1;

@property (nonatomic,strong) UIBezierPath *path;
@property (nonatomic,strong) CABasicAnimation *animation;
- (void)setTotlaScore:(NSInteger)totalScore score:(NSInteger)score;

@end
