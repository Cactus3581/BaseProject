//
//  BPWeChatRootViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPWeChatRootViewController.h"
#import "BPAppDelegate.h"
#import "BPChatListViewController.h"
#import "BPFriendsCircleViewController.h"
#import "BPRootNavigationController.h"
#import "UIView+BPAdd.h"

@interface BPWeChatRootViewController ()
@property (strong, nonatomic) UITabBarController *rootTabbarViewController;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIWindow *window;
@end

@implementation BPWeChatRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNewRootViewController];
    [self initSubViews];
}

#pragma mark - newRootViewController
- (void)configNewRootViewController {
    self.rootTabbarViewController = [[UITabBarController alloc]init];
    [self configChildViewController];
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;//可能是alert的window
    self.window = window;
    [self restoreRootViewController:self.rootTabbarViewController];
}

// 登陆后淡入淡出更换rootViewController
- (void)restoreRootViewController:(UIViewController *)rootViewController {
    typedef void (^Animation)(void);
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        self.window.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:self.window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

/**
 *  添加所有子控制器方法
 */
- (void)configChildViewController{
    BPChatListViewController *weChatVC = [[BPChatListViewController alloc]init];
    [self setUpChildViewController:weChatVC image:[UIImage imageNamed:@""] title:@"微信"];
    
    UIViewController *improvingTipVC = [[UIViewController alloc]init];
    [self setUpChildViewController:improvingTipVC image:[UIImage imageNamed:@""] title:@"通讯录"];
    
    BPFriendsCircleViewController *friendsCircleVC = [[BPFriendsCircleViewController alloc]init];
    [self setUpChildViewController:friendsCircleVC image:[UIImage imageNamed:@""] title:@"朋友圈"];
    
    UIViewController *mineVC = [[UIViewController alloc]init];
    [self setUpChildViewController:mineVC image:[UIImage imageNamed:@""] title:@"我"];
}

/**
 *  添加一个子控制器的方法
 */
- (void)setUpChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title {
    viewController.view.backgroundColor = kWhiteColor;
    BPRootNavigationController *navC = [[BPRootNavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
    //[navC.navigationBar setBackgroundImage:[UIImage imageNamed:@"commentary_num_bg"] forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.title = title;
    [self.rootTabbarViewController addChildViewController:navC];
}

#pragma mark - backButton
- (void)initSubViews {
    [self.window bringSubviewToFront:self.backButton];
    [self.window layoutIfNeeded];
    [self.backButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.backButton.width+30);
    }];
    [self.window layoutIfNeeded];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.backButton.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.backButton.bounds;
    maskLayer.path = maskPath.CGPath;
    self.backButton.layer.mask = maskLayer;
}

- (UIButton *)backButton {
    if (!_backButton) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton = backButton;
        _backButton.backgroundColor = kThemeColor;
        [_backButton setTitle:@"back" forState:UIControlStateNormal];
        _backButton.titleLabel.font  = BPFont(16);
        [_backButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonItemClickAction) forControlEvents:UIControlEventTouchUpInside];
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self.window addSubview:_backButton];
        [self.window bringSubviewToFront:_backButton];
        [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.window);
            make.bottom.equalTo(self.window.mas_bottom).offset(-60);
            make.height.mas_equalTo(30);
        }];
    }
    [self.window bringSubviewToFront:_backButton];
    return _backButton;
}

- (void)backButtonItemClickAction {
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = delegate.window;
    UIViewController *vc = window.rootViewController;
    [vc removeFromParentViewController];
    window.rootViewController = delegate.rootTabbarViewController;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)dealloc {
    [_backButton removeFromSuperview];
    _backButton = nil;
    [_rootTabbarViewController removeFromParentViewController];
    _rootTabbarViewController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
