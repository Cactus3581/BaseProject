//
//  BPBaseNavigationController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseNavigationController.h"
#import "UIImage+BPAdd.h"
#import "UIImage+BPColor.h"

@interface BPBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation BPBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.forbiddenInteractivePopGestureRecognizer = NO;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //修复navigationController侧滑关闭失效的问题
        self.interactivePopGestureRecognizer.delegate = self;
    }
    [self configDefaulyNavigationBarStyle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark - config UINavigationBar
- (void)configDefaulyNavigationBarStyle {

    //设置风格
    self.navigationBar.barStyle = UIBarStyleBlack;
    
    //translucent:半透明开关，当为NO时:ViewController上的View的原点坐标会以navigationBar以下的坐标为原点，并且设置NO后，导航栏背景色肯定是不透明的,无论设置某种系统风格还是背景图、背景颜色；当为YES时:ViewController上的View的原点坐标会以屏幕左上角为原点
    self.navigationBar.translucent = YES;
    
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
     [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     [self.navigationBar setShadowImage:[UIImage bp_imageWithColor:kRedColor]];
    
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

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated){
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    if (!self.shouldIgnorePushingViewControllers) {
//        [super pushViewController:viewController animated:animated];
//    }
//    self.shouldIgnorePushingViewControllers = YES;
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (viewController == navigationController.viewControllers.firstObject) {
//        navigationController.interactivePopGestureRecognizer.enabled = NO;
//    } else {
//        if(self.forbiddenInteractivePopGestureRecognizer) {
//            navigationController.interactivePopGestureRecognizer.enabled = NO;
//        } else {
//            navigationController.interactivePopGestureRecognizer.enabled = YES;
//        }
//    }
//    self.shouldIgnorePushingViewControllers = NO;
//}
//
//- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return [super popToViewController:viewController animated:animated];
//}
//
//- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
//    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated) {
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    return [super popToRootViewControllerAnimated:animated];
//}

#pragma mark - 控制屏幕旋转方法
- (BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

#pragma mark - statusBar
- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self.viewControllers lastObject];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self.viewControllers lastObject];
}

- (BOOL)prefersStatusBarHidden {
    return [[self.viewControllers lastObject] prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [[self.viewControllers lastObject] preferredStatusBarStyle];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return [[self.viewControllers lastObject] preferredStatusBarUpdateAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
