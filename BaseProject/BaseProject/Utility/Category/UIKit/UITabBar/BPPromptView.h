//
//  BPPromptView.h
//  BaseProject
//
//  Created by Ryan on 2018/10/9.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *kPromptViewTitle = @"这里有新东西";
static CGFloat viewH = 34;
static CGFloat imageW = 13;
static CGFloat imageH = 7;
static CGFloat labelPadding = 10;
static CGFloat viewPadding = 15;
static CGFloat viewBottomPadding = 10;
static CGFloat labelFont = 12;

@interface BPPromptView : UIView
@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UILabel *label;
@end

NS_ASSUME_NONNULL_END
