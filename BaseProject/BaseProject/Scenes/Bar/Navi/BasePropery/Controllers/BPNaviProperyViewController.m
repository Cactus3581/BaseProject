//
//  BPNaviProperyViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/2.
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

#import "BPNaviProperyViewController.h"
#import <Masonry.h>

@interface BPNaviProperyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionview;

@end

@implementation BPNaviProperyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kGreenColor;
    //[self configNavigationItem];//navigationItem
    //[self configNavigationBar];//navigationBar
    //[self configSubViews];      //由导航栏引起的零点坐标问题
    //[self configNewFeature];      // iOS 11 新特性
}

#pragma mark iOS 11 新特性
- (void)configNewFeature {
    if (kiOS11) {
        //self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        /*
         // 自动模式依赖上一个 item 的特性
         UINavigationItemLargeTitleDisplayModeAutomatic,
         // 针对当前 item 总是启用大标题特性
         UINavigationItemLargeTitleDisplayModeAlways,
         // Never
         UINavigationItemLargeTitleDisplayModeNever,
         */
        //self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
        
        
        //self.viewRespectsSystemMinimumLayoutMargins = YES;
        
        
        NSString *edgeStr = NSStringFromUIEdgeInsets(self.view.safeAreaInsets);
        NSString *layoutFrmStr = NSStringFromCGRect(self.view.safeAreaLayoutGuide.layoutFrame);
        NSLog(@"viewDidAppear safeAreaInsets = %@, layoutFrame = %@", edgeStr, layoutFrmStr);
        //2017-09-19 14:45:50.257807+0800 Sample[5608:1365070] viewDidAppear safeAreaInsets = {20, 0, 0, 0}, layoutFrame = {{0, 20}, {375, 603}}
        
        //self.view.directionalLayoutMargins = NSDirectionalEdgeInsetsMake(0, 0, 0, 30);
        
        //self.additionalSafeAreaInsets = UIEdgeInsetsMake(30, 0, 0, 30);//在原有的safeAreaInsets值中增加对应的边距值。如果原来的是{10, 0, 0, 10}, 则最后得出的边距是{40, 0, 0, 40}。
    }
}
    
#pragma mark navigationBar
- (void)configNavigationBar {
    
    //backgroundImage:背景图片
    //当给我们navigationBar设置图片时，navigationBar不再透明
    /*
     图片尺寸：
     当小于44或者大于64时 图片会在navigationBar 和 statusBar产生平铺效果
     当尺寸正好等于44时，图片只会为navigationBar附上图片
     当尺寸正好等于64时，图片会为navigationBar以及statusBar同时附上图片。
     */
    
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
    UIImage *navi_backImage = [UIImage imageNamed:@"naviBar"];
    //[self.navigationController.navigationBar setBackgroundImage:navi_backImage forBarMetrics:UIBarMetricsDefault];
    
    //导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    //导航栏透明渐变:对self.barImageView.alpha 做出改变
    UIImageView * barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = 0.3;
    
    //shadowImage:是导航栏下面的那根细线，如果不设置则会看到一根线。
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //方法二：
    //self.navigationController.navigationBar.clipsToBounds = YES;
    //此处使底部线条颜色为红色
    //[navigationBar setShadowImage:[UIImage imageWithColor:[UIColor redColor]]];
    
    [UINavigationBar appearance].tintColor = kOrangeColor;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navi_backImage"] forBarMetrics:UIBarMetricsDefault];
    
    /*
     设置风格：
     设置navigationBar的颜色,系统只支持这两种格式
     //UIBarStyleDefault = 0,默认白色
     //UIBarStyleBlack = 1,黑色
     */
    
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //barTintColor:导航栏背景色
    //self.navigationController.navigationBar.barTintColor = kOrangeColor;
    
    //tintColor:按钮颜色，包括图片跟字体
    self.navigationController.navigationBar.tintColor = kPurpleColor;
    
    //translucent:半透明开关
    //当为NO时:ViewController上的View的原点坐标会以navigationBar以下的坐标为原点
    //当为YES时:ViewController上的View的原点坐标会以屏幕左上角为原点
    self.navigationController.navigationBar.translucent = NO;
    
    
    //定制返回按钮
    UIImage *navi_item_Image = [[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //两个要一起用,为啥这么用，苹果言语不详
    self.navigationController.navigationBar.backIndicatorImage = navi_item_Image;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = navi_item_Image;
    
    //titleTextAttributes:修改导航栏标题
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 2);
    //字典中放入你想修改的键值对,原来的UITextAttributeFont、UITextAttributeTextColor、UITextAttributeTextShadowColor、UITextAttributeTextShadowOffset已弃用
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kRedColor,
                                                                    NSShadowAttributeName:shadow,
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:15]
                                                                    };
    
    //toolbarHidden:导航栏toolBar隐藏开关
    self.navigationController.toolbarHidden = NO;
}

//当视图的安全区域发生变更时会触发该方法的回调。可以通过该方法来处理安全区域变更时的子视图布局。
//如果你想准确地知道安全区域是什么时候被改变的，可以重写UIView的safeAreaInsetsDidChange方法，在这个方法里面可以监听安全区域的边距调整的事件（如果使用的是UIViewController，其也提供相应方法来实现监听)
- (void)safeAreaInsetsDidChange {
    //写入变更安全区域后的代码...
}

#pragma mark navigationItem
- (void)configNavigationItem {
    //UINavigationController并没有navigationItem这样一个直接的属性，由于UINavigationController继承于UIViewController,而UIViewController是有navigationItem这个属性的，所以才会出现如图所示的情况，如果你以下面的这句代码这样用是没有任何效果的。这当然是由于UINavigationController是个特殊的视图控制器，它是视图控制器的容器（另外两个容器是UITabBarController和UISplitViewController）,你不应该把它当一般的UIViewController来使用.
    self.navigationController.navigationItem.title = @"刘大帅";
    
    /*
     title和navigationItem.title的区别：
     当项目中没有tabBarController时：title和navigationItem.title效果是一样。
     当项目中有设置tabBarController时：
     设置self.title会显示在TabBarItem上和navigationBar上。
     但如果你只需要TabBarItem上和NavigationBar上显示的不一样的话这些都需要单独设置。
     */
    //控制导航栏标题
    self.navigationItem.title = @"Navi Propery";
    self.title = @"Navi Propery";
    
    //promt
    self.navigationItem.prompt = @"promt";
    
    //titleView
    /*
     //视图的x和y无效
     
     */
    //self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"naviBar"]];
    
    //添加按钮
    UIImage *navi_item_image = [UIImage imageNamed:@"rest"];
    //style:UIBarButtonItemStylePlain;UIBarButtonItemStyleDone
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc] initWithTitle:@"item1" style:UIBarButtonItemStylePlain target:nil action:nil];
    //style:UIBarButtonItemStylePlain;UIBarButtonItemStyleDone
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc] initWithImage:navi_item_image style:UIBarButtonItemStyleDone target:nil action:nil];
    //style:UIBarButtonItemStylePlain;UIBarButtonItemStyleDone
    //landscapeImagePhone 横屏显示的图片?
    UIBarButtonItem* item3 = [[UIBarButtonItem alloc] initWithImage:navi_item_image landscapeImagePhone:navi_item_image style:UIBarButtonItemStylePlain target:nil action:nil];
    //style:系统图标
    UIBarButtonItem* item4 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
    //自定义view:自定义view大小
    UIBarButtonItem* item5 = [[UIBarButtonItem alloc] initWithCustomView: [[UIImageView alloc] initWithImage:navi_item_image]];
    
    self.navigationItem.leftBarButtonItems = @[item1,item2,item3];//左->右
    
    self.navigationItem.rightBarButtonItems = @[item5,item4];//右->左
    
    //修复navigationController侧滑关闭失效的问题
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

//主要研究由导航栏及改变导航栏的属性引起的零点坐标问题
/*
iOS7之后都是从屏幕原点开始布局的，但是有时，我们也会遇到在 NavigationController 中是以（0，64）布局的，此处又是什么情况呢？先来看一下下面三个属性：
*/
#pragma mark tableView受Navi布局的影响
- (void)configSubViews {
    
    //这几个属性当使用的时候互相影响互相有联系，对原点改变的影响力：navigationBarHidden> edgesForExtendedLayout> translucent> extendedLayoutIncludesOpaqueBars
    
#pragma mark - 1. edgesForExtendedLayout:表示视图是否覆盖到四周的区域，默认是UIRectEdgeAll
    //self.edgesForExtendedLayout =  UIRectEdgeNone;
    //self.edgesForExtendedLayout =  UIRectEdgeAll;
    
#pragma mark - 2. translucent:半透明开关
    //默认为YES时:ViewController上的View的原点坐标会以屏幕左上角为原点
    //当为NO时:ViewController上的View的原点坐标会以navigationBar以下的坐标为原点。不管edgesForExtendedLayout设置成UIRectEdgeAll还是UIRectEdgeNone，view都是从导航栏底部开始
    //    self.navigationController.navigationBar.translucent = NO;
    
    
#pragma mark - 3. extendedLayoutIncludesOpaqueBars:默认值NO，这个属性指定了当Bar使用了不透明图片时，视图是否延伸至Bar所在区域； 但是Bar的默认属性是透明的。也就是说只有在不透明下才有用；因此，如果我们自定义了navBar背景图片，view会从导航栏下面开始布局。
    //如果我们自定义了nav bar背景图片，view会从导航栏下面开始布局。
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"naviBar"] forBarMetrics:UIBarMetricsDefault];
    
    //默认值NO，只有在不透明下才有用。那么问题来了，怎么让translucent=NO的时候，view也能从（0，0）开始布局呢？苹果也考虑到了这种需求，提供了extendedLayoutIncludesOpaqueBars 这个属性，当YES的时候，view从（0，0）布局
    //self.extendedLayoutIncludesOpaqueBars = YES;
    
    
#pragma mark - 4. automaticallyAdjustsScrollViewInsets:默认值是YES。只要是VC中的控件，都是从设备左上角的(0,0)开始算的，如果视图里面存在唯一一个UIScrollView,那么它会自动设置相应的内边距（如果有navbar的时候，这个内边距是64，这样scrollview可以占满屏幕，内容在64像素以下，不会被遮到，滑动scrollview，可以透过半透明效果看到scrollview上面的内容）。设置改变的是inset，而不是frame。
    /*
     如果一个控制器被导航控制器管理。并且该控制器的第一个子控件是UIScrollView,系统默认会调节UIScrollView的contentInset
     　　UIEdgeInsetsMake(64, 0, 0, 0) // 有导航栏
     　　UIEdgeInsetsMake(0, 0, 0, 0) // 没有导航栏; //UIEdgeInsetsMake(20, 0, 0, 0) // 没有导航栏,这个错误
     
     UIEdgeInsetsMake(64, 0, 49, 0) // 导航控制器又被UITabBarController管理
     
     　　以下为如何取消系统的默认这自动调节功能
     */
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize = CGSizeMake(0, 0);//预估cell高度
    flowLayout.itemSize = CGSizeMake(kScreenWidth, 64);
    flowLayout.minimumLineSpacing = 10;//纵向的行间距
    flowLayout.minimumInteritemSpacing = 0;
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    flowLayout.headerReferenceSize = flowLayout.footerReferenceSize = CGSizeMake(0, 0);
    _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.view addSubview:_collectionview];
    [self.view sendSubviewToBack:_collectionview];
    [_collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //[self.collectionview setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    _collectionview.backgroundColor = kBlueColor;
    //_collectionview.layoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionview.dataSource = self;
    _collectionview.delegate = self;
    _collectionview.bounces = YES;
    _collectionview.alwaysBounceVertical = YES;
    _collectionview.showsVerticalScrollIndicator = YES;
    [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    //禁止系统自动对scrollview调整contentInsets的。
    if (kiOS11) {
        self.collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:view];
    view.backgroundColor = kRedColor;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(150);
        //make.top.equalTo(self.view).mas_offset(64);
        make.top.equalTo(self.view).mas_offset(0);
        make.centerX.equalTo(self.view);
    }];
}

#pragma mark 导航栏做动画时的隐藏与显示
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
    两种方法都是可以隐藏导航栏的，隐藏之后依然可以使用push和pop方法。
    */
    
    //[self.navigationController setNavigationBarHidden:YES animated:animated];//无法提供手势滑动pop效果，但是有系统自动的动画效果。

    //[self.navigationController.navigationBar setHidden:YES];//可以提供手势滑动pop效果，但是没有系统自动的动画效果。
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //[self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark - collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 15;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kPurpleColor;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
