//
//  BPBaseViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"
#import "UIBarButtonItem+BPCreate.h"
#import "UIButton+BPImagePosition.h"

@interface BPBaseViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong) UIButton *leftBarButton;
@property(nonatomic,strong) UIButton *rightBarButton;
@end

static CGFloat barButtonItemWidth = 40.0f;
static CGFloat barButtonItemHeight = 40.0f;
static CGFloat titleInset = 20.0f;

@implementation BPBaseViewController

@synthesize leftBarButtonImage = _leftBarButtonImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self configBarButtomItem];
}

- (void)configBarButtomItem {
    if (self.navigationController && self.navigationController.viewControllers.count) {
        [self configLeftBarButtomItem];
        [self configRightBarButtomItem];
    }
}

#pragma mark - config leftBarButtonItem
- (void)configLeftBarButtomItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBarButton];
}

#pragma mark - setter methods: left barButton
- (void)setLeftBarButtonImage:(UIImage *)leftBarButtonImage {
    _leftBarButtonImage = [leftBarButtonImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.leftBarButton setImage:_leftBarButtonImage forState:UIControlStateNormal];
    [self.leftBarButton sizeToFit];
    CGFloat width = self.leftBarButton.bounds.size.width > barButtonItemWidth ? self.leftBarButton.bounds.size.width:barButtonItemWidth;
    self.leftBarButton.bounds = CGRectMake(0, 0,width, barButtonItemHeight);
    [self.leftBarButton setTintColor:kBlackColor];
}

- (void)setLeftBarButtonTitle:(NSString *)leftBarButtonTitle {
    _leftBarButtonTitle = leftBarButtonTitle;
    [self.leftBarButton setTitle:_leftBarButtonTitle forState:UIControlStateNormal];
    [self.leftBarButton setTitleColor:kBlackColor forState:UIControlStateNormal];
    [self.leftBarButton sizeToFit];

    CGFloat width = self.leftBarButton.bounds.size.width > barButtonItemWidth ? self.leftBarButton.bounds.size.width:barButtonItemWidth;
    CGFloat titleWidth = BPStringSize(_leftBarButtonTitle,BPFont(18)).width;
    if (!_leftBarButtonImage ) {
        if ((titleWidth <= barButtonItemWidth) && (titleWidth >= titleInset)) {
            width += (titleInset - (barButtonItemWidth - titleWidth)); //特殊情况
        }else if (titleWidth > barButtonItemWidth) {
            width += titleInset;
        }
    }
    self.leftBarButton.bounds = CGRectMake(0, 0,width, barButtonItemHeight);
    [self.leftBarButton setTintColor:kBlackColor];
}

- (void)leftBarButtonItemClickAction:(id)sender {
    if ((!_leftBarButtonImage || [_leftBarButtonImage isEqual:[NSNull class]]) && (!BPValidateString(_leftBarButtonTitle).length)) {
        return;
    }
    if (self.navigationController && self.navigationController.viewControllers) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - config rightBarButtonItem
- (void)configRightBarButtomItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarButton];
}

#pragma mark - setter methods: right barButton
- (void)setRightBarButtonImage:(UIImage *)rightBarButtonImage {
    _rightBarButtonImage = rightBarButtonImage;
    [self.rightBarButton setImage:rightBarButtonImage forState:UIControlStateNormal];
    [self.rightBarButton setTintColor:kBlackColor];
    CGFloat width = self.rightBarButton.bounds.size.width > barButtonItemWidth ? self.leftBarButton.bounds.size.width:barButtonItemWidth;
    self.rightBarButton.bounds = CGRectMake(0, 0,width, barButtonItemHeight);
}

- (void)setRightBarButtonTitle:(NSString *)rightBarButtonTitle {
    _rightBarButtonTitle = rightBarButtonTitle;
    [self.rightBarButton setTitle:rightBarButtonTitle forState:UIControlStateNormal];
    [self.rightBarButton setTintColor:kBlackColor];
    [self.rightBarButton sizeToFit];
    CGFloat width = self.leftBarButton.bounds.size.width > barButtonItemWidth ? self.rightBarButton.bounds.size.width:barButtonItemWidth;
    self.rightBarButton.bounds = CGRectMake(0, 0,width, barButtonItemHeight);
}

- (void)setHideRightBarButton:(BOOL)hideRightBarButton {
    self.rightBarButton.hidden = hideRightBarButton;
}

- (void)rightBarButtonItemClickAction:(id)sender {
    // 子类重写 方法
}

#pragma mark - lazy load methods
- (UIImage *)leftBarButtonImage {
    if (!_leftBarButtonImage) {
        _leftBarButtonImage = [[UIImage imageNamed:@"navi_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return _leftBarButtonImage;
}

//懒加载获取导航栏button
- (UIButton *)leftBarButton {
    if (!_leftBarButton) {
        _leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBarButton setTintColor:kBlackColor];
        [_leftBarButton setImage:self.leftBarButtonImage forState:UIControlStateNormal];
        _leftBarButton.titleLabel.font  = BPFont(18);
        [_leftBarButton addTarget:self action:@selector(leftBarButtonItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftBarButton.frame = CGRectMake(0, 0, barButtonItemWidth, barButtonItemHeight);
        //_leftBarButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _leftBarButton;
}

- (UIButton *)rightBarButton {
    if (!_rightBarButton) {
        _rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBarButton setTintColor:kBlackColor];
        [_rightBarButton setTitle:self.rightBarButtonTitle forState:UIControlStateNormal];
        _rightBarButton.titleLabel.font  = BPFont(18);
        [_rightBarButton addTarget:self action:@selector(rightBarButtonItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBarButton.frame = CGRectMake(0, 0, barButtonItemWidth, barButtonItemHeight);
        //_rightBarButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _rightBarButton;
}

#pragma mark - config theme
- (void)setTheme {
    [self.leftBarButton setTintColor:kBlackColor];
    [self.rightBarButton setTintColor:kBlackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kBlackColor,NSFontAttributeName:BPFont(18)};
    self.navigationController.navigationBar.barTintColor = kWhiteColor;
    self.navigationController.navigationBar.tintColor = kBlackColor;//影响返回按钮的颜色,因为返回按钮还是用的系统的
    self.navigationController.navigationBar.translucent = NO;
}

@end
