//
//  BPBackButton.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/15.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBackButton.h"
#import "UIButton+BPEnlargeEdge.h"
#import "UIButton+BPImagePosition.h"
#import "UIImage+BPAdd.h"
#import "UIView+BPAdd.h"

@implementation BPBackButton

- (instancetype)init {
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    self.height =  bp_naviItem_height;
    [self setImage:[[UIImage imageNamed:@"icon_back"] bp_imageByTintColor:kBlackColor] forState:UIControlStateNormal];
    [self setTintColor:kBlackColor];
}

- (void)configImage {
    self.width = bp_naviItem_width;
}

//使用前必须先设置自身大小 && 赋值title
- (void)configImageText {
    [self bp_setImagePosition:BPImagePositionRight spacing:0];
}

//设置image text模式
- (void)setBackButtonType:(BPBackButtonType)backButtonType {
    _backButtonType = backButtonType;
    switch (backButtonType) {
        case BPBackButtonImage:{
            [self configImage];
        }
            break;
            
        case BPBackButtonImageText:{
            [self configImageText];
        }
            break;
            
        default:
            break;
    }
}

//设置image text间隔
- (void)setImageTextSpace:(CGFloat)imageTextSpace {
    if (_backButtonType == BPBackButtonImageText) {
        _imageTextSpace = imageTextSpace;
        [self bp_setImagePosition:BPImagePositionRight spacing:imageTextSpace];
    }
}

//分别设置image 和图片 颜色
- (void)setImageColor:(UIColor *)imageColor {
    [self setImage:[[UIImage imageNamed:bp_naviItem_backImage] bp_imageByTintColor:imageColor] forState:UIControlStateNormal];
}

- (void)setTextColor:(UIColor *)textColor {
    if (_backButtonType == BPBackButtonImageText) {
        [self setTitleColor:textColor forState:UIControlStateNormal];
    }
}

//扩大button响应区
- (void)setRespondSpace:(CGFloat)respondSpace {
    [self bp_setEnlargeEdge:respondSpace];
}

@end
