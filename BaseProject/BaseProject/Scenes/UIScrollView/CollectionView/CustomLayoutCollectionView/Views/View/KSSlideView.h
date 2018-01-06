//
//  KSSlideView.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/5/19.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSSlideView : UIView
@property(nonatomic,strong) NSArray *goodsArray;
@property (nonatomic,assign) NSInteger selectedColor;
@property (nonatomic,assign) NSInteger unselectedColor;
@property (nonatomic,assign) NSInteger cornus;
@property (nonatomic,assign) NSInteger labelFont;
@property (nonatomic,assign) CGFloat tagEdge;

- (instancetype)initWithSelectedColor:(NSInteger)selectedColor UnselectedColor:(NSInteger)unselectedColor Cornus:(NSInteger)cornus LabelFont:(NSInteger)labelFont TagEdge:(CGFloat)tagEdge;

@end
