//
//  BPPromptView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/10/9.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPPromptView.h"
#import "BPAppDelegate.h"

@interface BPPromptView ()
@property (nonatomic,weak) UIView *backView;
@end

@implementation BPPromptView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self setTheme];
    }
    return self;
}

- (void)tapGes {
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.rootTabbarViewController.selectedIndex = 2;
}

- (void)setTheme {
    _backView.backgroundColor = kThemeColor;
    
    _label.backgroundColor = kThemeColor;
    _label.textColor = kWhiteColor;
    
    UIImage *image = [UIImage imageNamed:@"course_prompt"];
    _imageView.image = image;
}

- (void)initializeViews {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)]];

    self.backgroundColor = kClearColor;
    
    UIView *backView = [[UIView alloc] init];
    _backView = backView;
    backView.layer.cornerRadius = 4;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = kThemeColor;
    [self addSubview:backView];
    
    UILabel *label = [[UILabel alloc] init];

    label.backgroundColor = kThemeColor;
    _label = label;
    label.textColor = kWhiteColor;
    label.font = [UIFont systemFontOfSize:12];
    label.text = kPromptViewTitle;
    [backView addSubview:label];
    
    UIImage *image = [UIImage imageNamed:@"course_prompt"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    _imageView = imageView;
    [self addSubview:imageView];
    
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:labelFont]}];

    backView.frame = CGRectMake(0, 0, size.width+labelPadding*2, viewH-imageH);
    label.frame = CGRectMake(labelPadding, 0, size.width, viewH-imageH);
    imageView.frame = CGRectMake(backView.width/2.0-imageH/2.0, viewH-imageH, imageW, imageH);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
