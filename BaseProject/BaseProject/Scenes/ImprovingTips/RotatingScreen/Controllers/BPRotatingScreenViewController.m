//
//  BPRotatingScreenViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPRotatingScreenViewController.h"
#import "BPRotatingScreenView.h"
#import "BPRotatingScreenPresentiewController.h"
#import "BPRotatingScreenPushiewController.h"
#import "BPBaseNavigationController.h"

@interface BPRotatingScreenViewController ()
@property (nonatomic,weak) BPRotatingScreenView *rotatingScreenView ;
@end

/*
 场景问题：
 1. 支持旋转的方法：设置某个页面是否支持旋转
 2. 旋转前后的回调通知：设置UI
 3. 设置一进来的屏幕方向：比如视频页面一进来就是横屏方向
 4. 手动强制设置旋转：
 
 注意点及屏幕旋转时的一些建议
 1. 关于控制器的旋转方向权限：：该vc下，只实现三个协议方法是无效的，必须在它受管理的容器内（导航和标签控制器）同时实现三个协议方法
 2. 旋转过程中，暂时界面操作的响应
 3. 视图中有tableview的话，旋转后，强制 [tableview reloadData]，保证在方向变化以后，新的row能够充满全屏。例如对于有些照片展示界面，竖屏只显示一列，但是横屏的时候显示列表界面，这个时候一个界面就会显示更多的元素，此时reload内容就是很有必要的。
 4. 对于view层级比较复杂的时候，为了提高效率在旋转开始前使用截图替换当前的view层级，旋转结束后再将原view层级替换回来。
 
 关于方向：
 方向区分：有界面方向和设备方向，它俩之间有对应关系；
 UIDeviceOrientation（设备方向）和UIInterfaceOrientation（屏幕方向）是两个不同的概念。前者代表了设备的一种状态，而后者是屏幕为了应对不同的设备状态，做出的用户界面上的响应。在iOS设备旋转时，由UIKit接收到旋转事件，然后通过AppDelegate通知当前程序的UIWindow对象，UIWindow对象通知它的rootViewController，如果该rootViewController支持旋转后的屏幕方向，完成旋转，否则不旋转；弹出的ViewController也是如此处理。
 */

@implementation BPRotatingScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testVC];
    [self testView];
    [self configRightBarButtomItem];
    [self initSubViews];
    [self initCenterButton];
}

- (void)testVC {
    [self setUPApplicationDidChangeStatusBarOrientationNotification];//屏幕旋转时，建议监听这个
    [self setUPDeviceOrientationDidChangeNotification];//不建议监听这个
}

- (void)testView {
    
}

#pragma mark - 1：APP中某些页面，如视频播放页，一出现就要求横屏。这些横屏页面或模态弹出、或push进来。
#pragma mark - 1.1：push推入ViewController情况下 强制横屏的设置
- (void)push {
    BPRotatingScreenPushiewController *vc = [[BPRotatingScreenPushiewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 1.2：模态弹出ViewController情况下 强制横屏的设置
- (void)present {
    BPRotatingScreenPresentiewController *vc = [[BPRotatingScreenPresentiewController alloc] init];
    BPBaseNavigationController *naviVc = [[BPBaseNavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:naviVc animated:YES completion:nil];
}

- (void)resert {
    [self setInterfaceOrientation:UIInterfaceOrientationPortrait];
}

#pragma mark - 2：手动强制旋转
- (void)setInterfaceOrientation {
    [self setInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
}

#pragma mark - 3：监听旋转通知

#pragma mark - 3.1：监听StatusBarOrientation通知：利用状态栏的方向变化来判断旋转方向
//说明：手机锁定竖屏后，UIApplicationWillChangeStatusBarOrientationNotification和 ** UIApplicationDidChangeStatusBarOrientationNotification**通知也失效了。
- (void)setUPApplicationDidChangeStatusBarOrientationNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleStatusBarOrientationChange:)
                                                name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

//界面方向改变的处理
- (void)handleStatusBarOrientationChange: (NSNotification *)notification{
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (interfaceOrientation) {
            
        case UIInterfaceOrientationUnknown:
            BPLog(@"未知方向");
            break;
            
        case UIInterfaceOrientationPortrait:
            BPLog(@"界面直立");
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            BPLog(@"界面直立，上下颠倒");
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            BPLog(@"界面朝左");
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            BPLog(@"界面朝右");
            break;
            
        default:
            break;
    }
}

#pragma mark - 3.2：监听设备方向通知：监听的是手机物理方向的改变
//说明：手机锁定竖屏后，UIDeviceOrientationDidChangeNotification通知就失效了。
- (void)setUPDeviceOrientationDidChangeNotification {
    //开启和监听 设备旋转的通知（不开启的话，设备方向一直是UIInterfaceOrientationUnknown）
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
}


//设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationFaceUp:
            BPLog(@"屏幕朝上平躺");
            break;
            
        case UIDeviceOrientationFaceDown:
            BPLog(@"屏幕朝下平躺");
            break;
            
        case UIDeviceOrientationUnknown:
            BPLog(@"未知方向");
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            BPLog(@"屏幕向左横置");
            break;
            
        case UIDeviceOrientationLandscapeRight:
            BPLog(@"屏幕向右橫置");
            break;
            
        case UIDeviceOrientationPortrait:
            BPLog(@"屏幕直立");
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:
            BPLog(@"屏幕直立，上下顛倒");
            break;
            
        default:
            BPLog(@"无法辨识");
            break;
    }
}

#pragma mark - 3.3：controller 代理方法得到旋转的通知:只要屏幕转动都会触发
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //计算旋转之后的宽度并赋值
        CGSize screen = [UIScreen mainScreen].bounds.size;
        //界面处理逻辑
        /*
         */
        //动画播放完成之后
        if(screen.width > screen.height){
            BPLog(@"横屏");
        }else{
            BPLog(@"竖屏");
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        BPLog(@"动画播放完之后处理");
    }];
}

#pragma mark - 3.4：主动获取方向
- (void)activeGetBarOrientation {
    //读取界面方向:UIInterfaceOrientation和状态栏有关，通过UIApplication的单例调用statusBarOrientation来获取
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    BPLog(@"InterfaceOrientation = %d",interfaceOrientation);
    
    //读取设备方向:UIDevice单例代表当前的设备。从这个单例中可以获得的信息设备，如设备方向orientation。
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    BPLog(@"deviceOrientation = %d",deviceOrientation);
}

#pragma mark - 4：controller 旋转方法：权限、可选方向、以及模态默认进来的方向
//是否自动旋转,返回YES可以自动旋转,返回NO禁止旋转
- (BOOL)shouldAutorotate {
    BPLog(@"是否支持旋转");
    return YES;
}

//返回支持的方向:决定UIViewController可以支持哪些界面方向。
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    BPLog(@"controller支持旋转的方向");
    return UIInterfaceOrientationMaskAll;
}

//由模态推出的视图控制器 优先支持的屏幕方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    BPLog(@"由模态推出的视图控制器 优先支持的屏幕方向");
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//最后在dealloc中移除通知 和结束设备旋转的通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [[UIDevice currentDevice]endGeneratingDeviceOrientationNotifications];
}

- (void)initCenterButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button addTarget:self action:@selector(setInterfaceOrientation) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"手动设置旋转" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)initSubViews {
    BPRotatingScreenView *rotatingScreenView  = [[BPRotatingScreenView alloc] init];
    _rotatingScreenView  = rotatingScreenView ;
    [self.view addSubview:rotatingScreenView ];
    [rotatingScreenView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(self.view.mas_width).offset(-50);
    }];
    rotatingScreenView .backgroundColor = kThemeColor;
}

#pragma mark - config rightBarButtonItem
- (void)configRightBarButtomItem {
    UIView *view = [[UIView alloc] init];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTintColor:kWhiteColor];
    [rightBarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton setTitle:@"push" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font  = BPFont(16);
    [rightBarButton addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton sizeToFit];
    
    UIButton *rightBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton1 setTintColor:kWhiteColor];
    [rightBarButton1 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton1 setTitle:@"present" forState:UIControlStateNormal];
    rightBarButton1.titleLabel.font  = BPFont(16);
    [rightBarButton1 addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton1.frame = CGRectMake(CGRectGetMaxX(rightBarButton.frame)+10, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton1 sizeToFit];
    
    UIButton *rightBarButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton2 setTintColor:kWhiteColor];
    [rightBarButton2 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton2 setTitle:@"resert" forState:UIControlStateNormal];
    rightBarButton2.titleLabel.font  = BPFont(16);
    [rightBarButton2 addTarget:self action:@selector(resert) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton2.frame = CGRectMake(CGRectGetMaxX(rightBarButton1.frame)+10, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton2 sizeToFit];
    
    UIButton *rightBarButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton3 setTintColor:kWhiteColor];
    [rightBarButton3 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton3 setTitle:@"get方向" forState:UIControlStateNormal];
    rightBarButton3.titleLabel.font = BPFont(16);
    [rightBarButton3 addTarget:self action:@selector(activeGetBarOrientation) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton3.frame = CGRectMake(CGRectGetMaxX(rightBarButton2.frame)+10, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton3 sizeToFit];
    
    [view addSubview:rightBarButton];
    [view addSubview:rightBarButton1];
    [view addSubview:rightBarButton2];
    [view addSubview:rightBarButton3];

    view.frame = CGRectMake(0, 0, rightBarButton.width+15+rightBarButton1.width+15+rightBarButton2.width+15+rightBarButton3.width, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

@end
