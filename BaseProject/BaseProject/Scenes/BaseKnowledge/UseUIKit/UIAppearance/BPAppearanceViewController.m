//
//  BPAppearanceViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/24.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAppearanceViewController.h"

@interface BPAppearanceViewController ()

@end

@implementation BPAppearanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configAppearance];
}

- (void)configAppearance {
    /*
     通过UIAppearance设置一些UI的全局效果，这样就可以很方便的实现UI的自定义效果又能最简单的实现统一界面风格。
     
     注意:使用appearance设置UI效果最好采用全局的设置，在所有界面初始化前开始设置，先设置控件主题，后添加控件，否则,控件先添加，后设置主题，对以前的添加的控件不起作用了。所以一般写在appdelegate文件里面
     
     想要使用这个协议来自定义UI，类必须遵从UIAppearanceContainer协议，并且相关的属性需要有UI_APPEARANCE_SELECTOR标记。
     
     也可以自己创建可自定义外观的控件，需要在自定义类里设置UI_APPEARANCE_SELECTOR
     
     UIAppearance实现原理：
     
     在通过UIAppearance调用“UI_APPEARANCE_SELECTOR”标记的方法来配置外观时，UIAppearance实际上没有进行任何实际调用，而是把这个调用保存起来（在Objc中可以用NSInvocation对象来保存一个调用）。当实际的对象显示之前（添加到窗口上，drawRect:之前），就会对这个对象调用之前保存的调用。当这个setter调用后，你的界面风格自定义就完成了。
     
     读头文件。打开对应的UIKit元素的头文件，其中所有带有UI_APPEARANCE_SELECTOR标记的属性都支持通过外观代理来定制。举个例子，UINavigationBar.h中的tintColor属性带有UI_APPEARANCE_SELECTOR标记：
     
     
     它提供如下两个方法:
     
     + (id)appearance
     这个方法是统一全部改，比如你设置UINavBar的tintColor，你可以这样写：[[UINavigationBar appearance] setTintColor:myColor];
     
     + (id)appearanceWhenContainedIn:(Class <>)ContainerClass,...
     这个方法可设置某个类的改变：例如：设置UIBarButtonItem 在UINavigationBar、UIPopoverController、UITabbar中的效果。就可以这样写
     [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], [UIPopoverController class],[UITabbar class] nil] setTintColor:myPopoverNavBarColor];
     
     不限于以下几个类
     1. UINavigationBar
     2. UIBarButtonItem
     3. UITabbar
     4. UISegmentControl
     5. UIToolbar
     */
    
    //1.修改导航栏背景
    UINavigationBar * navigationBarAppearance = [UINavigationBar appearance];
    UIImage *navBackgroundImg = [UIImage imageNamed:@"navBg.png"];
    [navigationBarAppearance setBackgroundImage:navBackgroundImg forBarMetrics:UIBarMetricsDefault];
    
    //2.标签栏（UITabbar）
    UITabBar *tabBarAppearance = [UITabBar appearance];
    //设置背景图片
    [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_bg.png"]];
    //门置选择item的背景图片
    UIImage * selectionIndicatorImage =[[UIImage imageNamed:@"tabbar_slider"]resizableImageWithCapInsets:UIEdgeInsetsMake(4, 0, 0, 0)] ;
    [tabBarAppearance setSelectionIndicatorImage:selectionIndicatorImage];
    
    //3.分段控件（UISegmentControl）
    UISegmentedControl *segmentedControlAppearance = [UISegmentedControl appearance];
    //Segmenteg正常背景
    [segmentedControlAppearance setBackgroundImage:[UIImage imageNamed:@"Segmente.png"]
                          forState:UIControlStateNormal
                        barMetrics:UIBarMetricsDefault];
    //Segmente选中背景
    [segmentedControlAppearance setBackgroundImage:[UIImage imageNamed:@"Segmente_a.png"]
                          forState:UIControlStateSelected
                        barMetrics:UIBarMetricsDefault];
    //Segmente左右都未选中时的分割线
    //BarMetrics表示navigation bar的状态，UIBarMetricsDefault 表示portrait状态（44pixel height），UIBarMetricsLandscapePhone 表示landscape状态（32pixel height）
    [segmentedControlAppearance setDividerImage:[UIImage imageNamed:@"Segmente_line.png"]
            forLeftSegmentState:UIControlStateNormal
              rightSegmentState:UIControlStateNormal
                     barMetrics:UIBarMetricsDefault];
    
    [segmentedControlAppearance setDividerImage:[UIImage imageNamed:@"Segmente_line.png"]
            forLeftSegmentState:UIControlStateSelected
              rightSegmentState:UIControlStateNormal
                     barMetrics:UIBarMetricsDefault];
    
    [segmentedControlAppearance setDividerImage:[UIImage imageNamed:@"Segmente_line.png"]
            forLeftSegmentState:UIControlStateNormal
              rightSegmentState:UIControlStateSelected
                     barMetrics:UIBarMetricsDefault];
    //字体
    NSDictionary *textAttributes1 = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                      NSForegroundColorAttributeName: [UIColor blueColor],
                                      NSShadowAttributeName: [UIColor whiteColor],
                                      NSShadowAttributeName: [NSValue valueWithCGSize:CGSizeMake(1, 1)]};
    [segmentedControlAppearance setTitleTextAttributes:textAttributes1 forState:1];
    
    NSDictionary *textAttributes2 = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                      NSForegroundColorAttributeName: [UIColor whiteColor],
                                      NSShadowAttributeName: [UIColor blackColor],
                                      NSShadowAttributeName: [NSValue valueWithCGSize:CGSizeMake(1, 1)]};
    [segmentedControlAppearance setTitleTextAttributes:textAttributes2 forState:0];
    
    //4.UIBarbutton
    //注意：UIBarbutton有leftBarButton，rightBarButton和backBarButton，其中backBarButton由于带有箭头，需要单独设置。
    //barButton背景设置是ios6.0及以后的，而backbutton是ios5.0及以后的，这里要注意！
    
    //修改导航条上的UIBarButtonItem
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    
    //设置导航栏的字体包括backBarButton和leftBarButton，rightBarButton的字体
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18],
                                     NSForegroundColorAttributeName: [UIColor blueColor],
                                     NSShadowAttributeName: [UIColor whiteColor],
                                     NSShadowAttributeName: [NSValue valueWithCGSize:CGSizeMake(1, 1)]};
    [barButtonItemAppearance setTitleTextAttributes:textAttributes forState:1];//forState为0时为下正常状态，为1时为点击状态。
    //修改leftBarButton，rightBarButton背景效果
    [barButtonItemAppearance setBackgroundImage:[UIImage imageNamed:@"navBarButton.png"]
                          forState:UIControlStateNormal
                             style:UIBarButtonItemStylePlain
                        barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackgroundImage:[UIImage imageNamed:@"navBarButton_a.png"]
                          forState:UIControlStateHighlighted
                             style:UIBarButtonItemStylePlain
                        barMetrics:UIBarMetricsDefault];
    //backBarButton需要单独设置背景效果。只能在ios6.0以后才能用
    [barButtonItemAppearance setBackButtonBackgroundImage:[UIImage imageNamed:@"nav_bg.png"]
                                    forState:0
                                  barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage:[UIImage imageNamed:@"work.png"]
                                    forState:1
                                  barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonTitlePositionAdjustment:UIOffsetMake(2, -1)
                                       forBarMetrics:UIBarMetricsDefault];
    
    //5.工具栏（UIToolbar）
    UIToolbar *toolbarAppearance = [UIToolbar appearance];
    //样式和背景二选一即可，看需求了
    //样式（黑色半透明，不透明等）设置
    [toolbarAppearance setBarStyle:UIBarStyleBlackTranslucent];
    //背景设置
    [toolbarAppearance setBackgroundImage:[UIImage imageNamed:@"toolbarBg.png"]
                forToolbarPosition:UIToolbarPositionAny
                        barMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
