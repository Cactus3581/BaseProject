//
//  CircleProgressView.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/8/8.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

-(void)layout;
-(void)animateTo:(float)percentage;
@property (nonatomic,strong) CAShapeLayer *mask;
@property (nonatomic,assign) CGFloat lineWidth;
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,strong) UIColor *fromColour;
@property (nonatomic,strong) UIColor *toColour;
@property (nonatomic,strong) UIColor *baseColour;
@property (nonatomic,strong) UIView *rotateView;


@end
