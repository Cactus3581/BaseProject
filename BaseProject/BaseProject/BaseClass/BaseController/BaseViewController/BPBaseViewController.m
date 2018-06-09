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
#import "YYFPSLabel.h"

@interface BPBaseViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong) UIButton *leftBarButton;
@property(nonatomic,strong) UIButton *rightBarButton;
@end

static CGFloat titleInset = 20.0f;

@implementation BPBaseViewController

@synthesize leftBarButtonImage = _leftBarButtonImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self configBarButtomItem];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self naviBarHidden:NO animated:animated];
}

- (void)configBarButtomItem {
    if (self.navigationController && self.navigationController.viewControllers.count) {
        [self configBarDefaulyStyle];
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
    CGFloat width = MAX(self.leftBarButton.bounds.size.width , bp_naviItem_width);
    self.leftBarButton.bounds = CGRectMake(0, 0,width, bp_naviItem_height);
}

- (void)setLeftBarButtonTitle:(NSString *)leftBarButtonTitle {
    _leftBarButtonTitle = leftBarButtonTitle;
    [self.leftBarButton setTitle:_leftBarButtonTitle forState:UIControlStateNormal];
    [self.leftBarButton sizeToFit];

    CGFloat width = MAX(self.leftBarButton.bounds.size.width , bp_naviItem_width);
    CGFloat titleWidth = BPStringSize(_leftBarButtonTitle,BPFont(16)).width;
    if (!_leftBarButtonImage ) {//特殊处理：没有返回图片，只有文字的情况
        if ((titleWidth <= bp_naviItem_width) && (titleWidth >= titleInset)) {
            width += (titleInset - (bp_naviItem_width - titleWidth));
        }else if (titleWidth > bp_naviItem_width) {
            width += titleInset;
        }
    }
    self.leftBarButton.bounds = CGRectMake(0, 0,width, bp_naviItem_height);
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
    [self.rightBarButton sizeToFit];
    CGFloat width = MAX(self.rightBarButton.bounds.size.width , bp_naviItem_width);
    self.rightBarButton.bounds = CGRectMake(0, 0,width, bp_naviItem_height);
}

- (void)setRightBarButtonTitle:(NSString *)rightBarButtonTitle {
    _rightBarButtonTitle = rightBarButtonTitle;
    [self.rightBarButton setTitle:rightBarButtonTitle forState:UIControlStateNormal];
    [self.rightBarButton sizeToFit];
    CGFloat width = MAX(self.rightBarButton.bounds.size.width , bp_naviItem_width);
    CGFloat titleWidth = BPStringSize(_rightBarButtonTitle,BPFont(16)).width;
    if (!_rightBarButtonImage) {//特殊处理：没有返回图片，只有文字的情况
        if ((titleWidth <= bp_naviItem_width) && (titleWidth >= titleInset)) {
            width += (titleInset - (bp_naviItem_width - titleWidth));
        }else if (titleWidth > bp_naviItem_width) {
            width += titleInset;
        }
    }
    self.rightBarButton.bounds = CGRectMake(0, 0,width, bp_naviItem_height);
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
        _leftBarButtonImage = [[UIImage imageNamed:bp_naviItem_backImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return _leftBarButtonImage;
}

//懒加载获取导航栏button
- (UIButton *)leftBarButton {
    if (!_leftBarButton) {
        _leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBarButton setTintColor:kWhiteColor];
        [_leftBarButton setImage:self.leftBarButtonImage forState:UIControlStateNormal];
        _leftBarButton.titleLabel.font  = BPFont(16);
        [_leftBarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_leftBarButton addTarget:self action:@selector(leftBarButtonItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _leftBarButton.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
        _leftBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        /*
        _leftBarButton.backgroundColor = [UIColor redColor];
        _leftBarButton.imageView.backgroundColor = [UIColor greenColor];
        _leftBarButton.titleLabel.backgroundColor = [UIColor blueColor];
        _leftBarButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _leftBarButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
         */
    }
    return _leftBarButton;
}

- (UIButton *)rightBarButton {
    if (!_rightBarButton) {
        _rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBarButton setTintColor:kWhiteColor];
        [_rightBarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_rightBarButton setTitle:self.rightBarButtonTitle forState:UIControlStateNormal];
        _rightBarButton.titleLabel.font  = BPFont(16);
        [_rightBarButton addTarget:self action:@selector(rightBarButtonItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBarButton.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    }
    return _rightBarButton;
}

#pragma mark - config theme
- (void)setTheme {
    /*
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.navigationController.navigationBar.translucent = NO;
     */
}

- (void)configBarDefaulyStyle {
    /*
    [self.leftBarButton setTintColor:kWhiteColor];
    [self.rightBarButton setTintColor:kWhiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kWhiteColor,NSFontAttributeName:BPFont(16)};
    self.navigationController.navigationBar.barTintColor = kWhiteColor;
    self.navigationController.navigationBar.tintColor = kWhiteColor;//影响返回按钮的颜色,因为返回按钮还是用的系统的
     */
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
}



#pragma mark - 恢复默认样式
- (void)recoverStyle {
    
}

//#pragma mark - 屏幕旋转
//// 不自动旋转
//- (BOOL)shouldAutorotate {
//    return NO;
//}
//
//// 竖屏显示
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
//    return UIInterfaceOrientationPortrait;
//}
//
//#pragma mark - 隐藏statusbar及恢复默认样式
//-(BOOL)prefersStatusBarHidden {
//    return YES;
//}

#pragma mark - 隐藏navibar及恢复默认样式
- (void)naviBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:hidden animated:animated];//无法提供手势滑动pop效果，但是有系统自动的动画效果。
//    [self.navigationController.navigationBar setHidden:YES];//区别
}

- (void)addFPSLabel {
    [YYFPSLabel bp_addFPSLableOnWidnow];
}

- (void)removeFPSLabel {
    [YYFPSLabel bp_removeFPSLableOnWidnow];
}

- (void)dealloc {
    [self removeFPSLabel];
    BPLog(@"i am vc 释放了");
}

@end
