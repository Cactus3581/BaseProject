//
//  BPNaviProperyViewController.m
//  BaseProject
//
//  Created by Ryan on 2017/12/2.
//  Copyright © 2017年 cactus. All rights reserved.
//

/*
 1. 导航栏手势的影响
 2. 对导航栏基类的UI设置，对特定页面的导航栏ui设置
 3. 隐藏导航栏动画
 4. 通常因为scroll，设置导航栏的做法
 5. 自定义item大小及位置
 6. ios11 新特性：http://www.jianshu.com/p/04a9d1008276
 */

/**
 
 1. UINavigationController：
 UINavigationController是个特殊的视图控制器，它是视图控制器的容器（另外两个容器是UITabBarController和UISplitViewController）,你不应该把它当一般的UIViewController来使用.
 
 2. navigationBar：由UINavigationController管理

 
 3. navigationItem：由vc管理，不该由UINavigationController管理
 navigationItem控制导航栏标题(title)、promt、标题视图(titleView)、以及按钮（barButtonItem）的添加和数量。
 
 UINavigationController并没有navigationItem这样一个直接的属性，由于UINavigationController继承于UIViewController,而UIViewController是有navigationItem这个属性的。
 它是UINavigationItem一个独特的实例。当视图控制器被推到导航控制器中时，它来代表这个视图控制器。当第一次访问这个属性的时候，它会被创建。因此，如果你并没有用导航控制器来管理视图控制器，那你不应该访问这个属性。为确保navigationItem 已经配置，你可以在视图控制器初始化时，重写这个属性、创建BarButtonItem。
 UIBarButtonItem:它是专门给UIToolBar和UINavigationBar定制的类似button的类就好了。navigationItem有leftBarButtonItems和rightBarButtonItems两个属性
 
 总结:如果把导航控制器比作一个剧院，那导航栏就相当于舞台，舞台必然是属于剧院的，所以，导航栏是导航控制器的一个属性。视图控制器（UIViewController）就相当于一个个剧团，而导航项（navigation item）就相当于每个剧团的负责人，负责与剧院的人接洽沟通。显然，导航项应该是视图控制器的一个属性。虽然导航栏和导航项都在做与导航相关的事情，但是它们的从属是不同的。
 
 导航栏相当于负责剧院舞台的布景配置，导航项则相当于协调每个在舞台上表演的演员（bar button item,title 等等），每个视图控制器的导航项可能都是不同的，可能一个右边有一个选择照片的bar button item,而另一个视图控制器的右边有两个bar button item。
 
 */

#import "BPNaviProperyViewController.h"
#import "UIImage+BPAdd.h"

@interface BPNaviProperyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UIView *testView;
@end

@implementation BPNaviProperyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self configNavigationBar];
    [self configNavigationItem];
    [self initializeSubViews];//由导航栏引起的零点坐标问题
    //[self setUpAppearance];
    //[self otherTest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self setNavigationBarHidden_1:YES animated:animated];
    //[self setNavigationBarHidden_2:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self setNavigationBarHidden_1:NO animated:animated];
    //[self setNavigationBarHidden_2:NO];
}

#pragma mark 设置UINavigationBar：包括：系统style、设置颜色、设置背景图片、取出背景图片设置alpha、设置底部线条、设置item tintColor、半透明度、修改导航栏标题属性
- (void)configNavigationBar {
    
    UIImage *backImage = [UIImage bp_imageWithColor:kGreenColor size:CGSizeMake(kScreenWidth, 1)];//当给我们navigationBar设置图片时，navigationBar不再透明
    /*
     UIBarMetricsDefault 默认值，表示横屏竖屏都显示
     UIBarMetricsCompact 横屏样式
     UIBarMetricsDefaultPrompt和UIBarMetricsCompactPrompt是有promt的两种样式
     */
    
    /*
     UIImageRenderingModeAutomatic,          //根据图片的使用环境和所处的绘图上下文自动调整渲染模式。受tintColor影响
     UIImageRenderingModeAlwaysOriginal,     //  始终绘制图片原始状态，不受tintColor影响
     UIImageRenderingModeAlwaysTemplate,     //始终根据Tint Color绘制图片，忽略图片的颜色信息。
     */
    
    [self.navigationController.navigationBar setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];

    //导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    //导航栏透明渐变:对self.barImageView.alpha 做出改变
    UIImageView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0.3;
    
    //清除导航栏下面的细线，如果不设置则会看到一根线。
    //方法一：
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    //方法二：
    //self.navigationController.navigationBar.clipsToBounds = YES;
    
    //使底部线条颜色为红色

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;//设置风格

    //barTintColor:导航栏背景色
    self.navigationController.navigationBar.barTintColor = kOrangeColor;//导航栏背景色

    //tintColor:按钮颜色，包括图片跟字体
    self.navigationController.navigationBar.tintColor = kPurpleColor;//按钮颜色，包括图片跟字体

    //translucent:半透明开关：当为NO时:ViewController上的View的原点坐标会以navigationBar以下的坐标为原点；当为YES时:ViewController上的View的原点坐标会以屏幕左上角为原点
    self.navigationController.navigationBar.translucent = YES;

    //titleTextAttributes:修改导航栏标题
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = kRGBA(0, 0, 0, 0.8);
    shadow.shadowOffset = CGSizeMake(0, 2);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kRedColor,
                                                                    NSShadowAttributeName:shadow,
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:15]
                                                                };
}

#pragma mark 系统及自定义navigationItem
- (void)configNavigationItem {
    
    self.navigationItem.title = @"title";//控制导航栏标题
    self.title = @"title";//当项目中没有tabBarController时：title和navigationItem.title效果是一样；当项目中有设置tabBarController时：设置self.title会显示在TabBarItem上和navigationBar上;
    self.navigationController.navigationItem.title = @"title"; //无效：UINavigationController并没有navigationItem这样一个直接的属性
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"item1" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIImage *navi_item_image = [UIImage imageNamed:@"cactus_round_steady"];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:navi_item_image style:UIBarButtonItemStyleDone target:nil action:nil];
    //landscapeImagePhone 横屏显示的图片?
    UIBarButtonItem* item3 = [[UIBarButtonItem alloc] initWithImage:navi_item_image landscapeImagePhone:navi_item_image style:UIBarButtonItemStylePlain target:nil action:nil];
    //自定义view:自定义view大小
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithCustomView: [[UIImageView alloc] initWithImage:navi_item_image]];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"custom";
    label.textColor = kGreenColor;
    UIBarButtonItem *item6 = [[UIBarButtonItem alloc] initWithCustomView:label];

    self.navigationItem.leftBarButtonItems = @[item1,item2,item3];//左->右
    self.navigationItem.rightBarButtonItems = @[item6,item5,item4];//右->左
    
    //self.navigationItem.prompt = @"promt";
    
    //self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"naviBarBackGroundImage"]];视图的x和y无效
}


#pragma mark 由导航栏及改变导航栏的属性引起的零点坐标问题

/*
 导航项系统默认设置：导航栏透明（高斯模糊）+ 所有原点都在左上角+tableview inset改变

 iOS7之后都是从屏幕原点开始布局的，但是有时，我们也会遇到在 NavigationController 中是以（0，64）布局的，此处又是什么情况呢？先来看一下下面几个属性：
 这几个属性当使用的时候互相影响互相有联系，对原点改变的影响力：navigationBarHidden> edgesForExtendedLayout> translucent> extendedLayoutIncludesOpaqueBars
 
 1. 所有view（包括scroll）坐标原点在导航栏下面,不影响导航栏的颜色及背景，即跟它没关系，只影响坐标原点；也不会设置scroll的偏移量
 self.edgesForExtendedLayout =  UIRectEdgeNone;
 
 2. 透明度:所有view（包括scroll）坐标原点在导航栏下面,导航栏背景色肯定是不透明的,无论设置某种系统风格还是背景图、背景颜色
 self.navigationController.navigationBar.translucent = NO;
 
 3.不让scroll产生偏移，也就是说内容y同frame的y，这样好处理，特别是在多scroll环境下
 if (kiOS11) {
 self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
 } else {
 self.automaticallyAdjustsScrollViewInsets = NO;
 }
 
 4. 给导航栏设置背景图片，但是导航栏还是高斯也就是半透明，所以一般会配合设置translucent让其不透明
 [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cactus_theme"] forBarMetrics:UIBarMetricsDefault];//(不会改变原点+tableview inset改变了+导航栏还是透明的)
 
 5. 给导航栏设置背景色，一旦设置了即为不透明
 self.navigationController.navigationBar.barTintColor = kYellowColor;
 
 6. 给导航栏的item设置渲染颜色，不适用，因为一般都是自定义的控件，不适用系统的item
 self.navigationController.navigationBar.tintColor = kYellowColor;
 
 7. 让translucent=NO的时候，坐标从（0，0）开始布局；平时用不到，因为默认就是从（0，0）开始布局，一般跟translucent一块使用
 self.extendedLayoutIncludesOpaqueBars = YES;
 
 */
- (void)initializeSubViews {
    [self setupTableView];
    [self setupNormalView];
    
// 1. edgesForExtendedLayout:表示视图是否覆盖到四周的区域，默认是UIRectEdgeAll
    //self.edgesForExtendedLayout =  UIRectEdgeAll;
    self.edgesForExtendedLayout = UIRectEdgeNone;//所有view（包括scroll）坐标原点在导航栏下面，scroll不会偏移
    
// 2. translucent:半透明开关，默认为YES时:ViewController上的View的原点坐标会以屏幕左上角为原点；当为NO时:ViewController上的View的原点坐标会以navigationBar以下的坐标为原点。不管edgesForExtendedLayout设置成UIRectEdgeAll还是UIRectEdgeNone，view都是从导航栏底部开始
    self.navigationController.navigationBar.translucent = NO;//半透明度（所有view（包括scroll）坐标原点在导航栏下面+导航栏背景色为纯黑色（风格））
    
//3. automaticallyAdjustsScrollViewInsets:默认值是YES。只要是VC中的控件，都是从设备左上角的(0,0)开始算的，如果视图里面存在唯一一个UIScrollView,那么它会自动设置相应的内边距（如果有navbar的时候，这个内边距是64，这样scrollview可以占满屏幕，内容在64像素以下，不会被遮到，滑动scrollview，可以透过半透明效果看到scrollview上面的内容）。设置改变的是inset，而不是frame。
    /*
     如果一个控制器被导航控制器管理。并且该控制器的第一个子控件是UIScrollView,系统默认会调节UIScrollView的contentInset
     UIEdgeInsetsMake(64, 0, 0, 0) // 有导航栏
     UIEdgeInsetsMake(0, 0, 0, 0) // 没有导航栏;
     UIEdgeInsetsMake(64, 0, 49, 0) // 导航控制器又被UITabBarController管理
     */

    //以下为如何取消系统的默认这自动调节功能
    if (kiOS11) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//5. 自定义navigationBar背景图片：不会改变原点；tableview inset改变了；导航栏还是半透明的，所以一般会配合设置translucent让其不透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"cactus_theme"] forBarMetrics:UIBarMetricsDefault];

//6. 导航栏背景色：不会改变原点；tableview inset改变了；导航栏颜色变了；不透明
    self.navigationController.navigationBar.barTintColor = kYellowColor;
    self.navigationController.navigationBar.tintColor = kYellowColor;

//7. extendedLayoutIncludesOpaqueBars:默认值NO（一般用不到），这个属性指定了当Bar使用了不透明图片时，并设置translucent让bar不透明，也就是说只有在不透明下才有用。那么问题来了，怎么让translucent=NO的时候，view也能从（0，0）开始布局呢？苹果也考虑到了这种需求，提供了extendedLayoutIncludesOpaqueBars 这个属性，当YES的时候，view从（0，0）布局。
    self.extendedLayoutIncludesOpaqueBars = YES;
}

#pragma mark - Pop系统边缘手势
- (void)interactivePopGestureRecognizer {
    //修复navigationController侧滑关闭失效的问题
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 导航栏做动画时的隐藏与显示:两种方法都是可以隐藏导航栏的，隐藏之后依然可以使用push和pop方法。
//无法提供手势滑动pop效果，但是有系统自动的动画效果。
- (void)setNavigationBarHidden_1:(BOOL)hidden animated:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:hidden animated:animated];
}

//可以提供手势滑动pop效果，但是没有系统自动的动画效果。
- (void)setNavigationBarHidden_2:(BOOL)hidden {
    [self.navigationController.navigationBar setHidden:hidden];
}

- (void)setUpAppearance {
    //iOS 11 之前 把系统的backButton的文字去掉，11之后不管用了
    //[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    // 项目中所有的导航栏统一设置
    [UINavigationBar appearance].tintColor = kOrangeColor;
    //[[UINavigationBar appearance] setBackgroundImage:backImage forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - 其他测试
- (void)otherTest {
    //可以制造bar或者高斯模糊,toolbarHidden:导航栏toolBar隐藏开关
    self.navigationController.toolbarHidden = NO;
    
    //定制返回按钮
    UIImage *navi_item_Image = [[UIImage imageNamed:bp_naviItem_backImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //两个要一起用,为啥这么用，苹果言语不详
    self.navigationController.navigationBar.backIndicatorImage = navi_item_Image;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = navi_item_Image;
}

#pragma mark - 创建view
- (UIView *)testView {
    if (!_testView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        _testView = view;
        [self.view addSubview:view];
        view.backgroundColor = kRedColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).mas_offset(10);
            make.centerX.equalTo(self.view);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(kScreenHeight-20);
            
        }];
    }
    return _testView;
}

- (void)setupNormalView {
    self.testView.backgroundColor = kGreenColor;
}

- (void)setupTableView {
    self.tableView.backgroundColor = kPurpleColor;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(10);
            make.bottom.leading.trailing.equalTo(self.view);
        }];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.backgroundColor = kRedColor;
    }
    cell.textLabel.text = @"i am cell";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
