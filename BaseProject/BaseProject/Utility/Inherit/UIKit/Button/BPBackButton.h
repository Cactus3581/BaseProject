//
//  BPBackButton.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/15.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BPBackButtonType) {
    BPBackButtonImage,
    BPBackButtonImageText
};

@interface BPBackButton : UIButton

@property (nonatomic,assign) BPBackButtonType backButtonType;

@property (nonatomic,assign) CGFloat respondSpace;

@property (nonatomic,assign) CGFloat imageTextSpace;

@property (nonatomic,strong) UIColor *imageColor;

@property (nonatomic,strong) UIColor *textColor;

@end
