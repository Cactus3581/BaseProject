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
#import "UINavigationController+FDFullscreenPopGesture.h"

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
    [self configLayoutStyle];
    [self configBarButtomItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //为了不影响其他页面,在viewDidDisappear做以下设置
    [self naviBarHidden:NO animated:animated];
    [self recoverNavigationBarStyle];
    [self recoverStatusStyle];
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
         _leftBarButton.backgroundColor = kRedColor;
         _leftBarButton.imageView.backgroundColor = kGreenColor;
         _leftBarButton.titleLabel.backgroundColor = kBlueColor;
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

#pragma mark - config theme style
- (void)configLayoutStyle {
    //1. 所有view（包括scroll）坐标原点在导航栏下面,不影响导航栏的颜色及背景，即跟它没关系，只影响坐标原点；也不会设置scroll的偏移量
    self.edgesForExtendedLayout = UIRectEdgeAll;//也可以是UIRectEdgeTop
     
    //2.不让scroll产生偏移，也就是说内容y同frame的y，这样好处理，特别是在多scroll环境下
    if (kiOS11) {
        //self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        //self.automaticallyAdjustsScrollViewInsets = NO;
    }
     
    //3. 让translucent = NO的时候，坐标从（0，0）开始布局；平时用不到，因为默认就是从（0，0）开始布局，一般跟translucent一块使用
    self.extendedLayoutIncludesOpaqueBars = YES;
}

#pragma mark - 恢复默认样式
- (void)recoverNavigationBarStyle {
    [self configNavigationBarStyle];
}

#pragma mark - config UINavigationBar
- (void)configNavigationBarStyle {
    
    //设置风格
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //translucent:半透明开关，当为NO时:ViewController上的View的原点坐标会以navigationBar以下的坐标为原点，并且设置NO后，导航栏背景色肯定是不透明的,无论设置某种系统风格还是背景图、背景颜色；当为YES时:ViewController上的View的原点坐标会以屏幕左上角为原点
    self.navigationController.navigationBar.translucent = YES;
    
    /*
     //给导航栏设置背景图片(不会改变原点+tableview inset改变了+导航栏还是透明的)，但是导航栏还是高斯也就是半透明，所以一般会配合设置translucent让其不透明
     UIImage *backImage = [UIImage bp_imageWithColor:kGreenColor size:CGSizeMake(kScreenWidth, 1)];//当给我们navigationBar设置图片时，navigationBar不再透明
     [self.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
     
     //设置导航栏透明
     [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     
     //导航栏透明渐变:
     UIImageView *barImageView = self.navigationBar.subviews.firstObject;
     barImageView.alpha = 0.3;//对self.barImageView.alpha 做出改变
     
     //清除导航栏下面的细线，如果不设置则会看到一根线。
     self.navigationBar.shadowImage = [UIImage new];//方法一：
     self.navigationBar.clipsToBounds = YES;//方法二：
     
     //使底部线条颜色为红色
     // 略.
     
     //barTintColor:给导航栏设置背景色，一旦设置了即为不透明
     self.navigationBar.barTintColor = kOrangeColor;
     
     //tintColor:给导航栏的item设置渲染颜色，包括图片跟字体；不适用，因为一般都是自定义的控件，不适用系统的item
     self.navigationBar.tintColor = kPurpleColor;//按钮颜色，包括图片跟字体,前提不包括customView
     
     //titleTextAttributes:修改导航栏标题
     NSShadow *shadow = [[NSShadow alloc] init];
     shadow.shadowColor = kRGBA(0, 0, 0, 0.8);
     shadow.shadowOffset = CGSizeMake(0, 2);
     self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kRedColor,
     NSShadowAttributeName:shadow,
     NSFontAttributeName:[UIFont systemFontOfSize:15]
     };
     */
}

#pragma mark - 创建views
- (void)initializeViews {
    
}

#pragma mark -数据请求
- (void)request {
    
}

#pragma mark -数据处理
- (void)handleData {
    
}

#pragma mark - 隐藏navibar及恢复默认样式
- (void)naviBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:hidden animated:animated];//无法提供手势滑动pop效果，但是有系统自动的动画效果。
}

#pragma mark - FPS
- (void)addFPSLabel {
    [YYFPSLabel bp_addFPSLableOnWidnow];
}

- (void)removeFPSLabel {
    [YYFPSLabel bp_removeFPSLableOnWidnow];
}

#pragma mark - 动态跳转A
- (BOOL)needDynamicJump {
    self.dynamicJumpDict = BPFromJSON(self.dynamicJumpString);
    if (BPValidateDict(self.dynamicJumpDict).allKeys.count) {
        return YES;
    }
    return NO;
}

- (void)handleDynamicJumpData {
    
}

#pragma mark - 动态跳转B
- (void)loadWithData:(NSDictionary *)dict {
    //必须实现
}

#pragma mark - 手动开启关闭左滑手势
- (void)popDisabled:(BOOL)disabled {
    self.fd_interactivePopDisabled = disabled;
    self.navigationController.fd_viewControllerBasedNavigationBarAppearanceEnabled = disabled;
}

#pragma mark -  屏幕旋转操作
//强制转屏
- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        // 从2开始是因为前两个参数已经被selector和target占用
        [invocation setArgument:&orientation atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - StatusBar
- (void)configStatusBarStyle {
    
}

- (void)recoverStatusStyle {
    [self setStatusBarBackgroundColor:kClearColor];
    [self updateStatusBarAppearance];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

- (void)updateStatusBarAppearance {
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [self removeFPSLabel];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    BPLog(@"i am vc 释放了");
}

@end
