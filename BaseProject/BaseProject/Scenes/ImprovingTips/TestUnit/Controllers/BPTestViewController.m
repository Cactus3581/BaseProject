//
//  BPTestViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPTestViewController.h"
#import "BPCircleProgressButton.h"
#import "CALayer+BPMask.h"

@interface BPTestViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic,copy) NSString *str1;
@property (nonatomic,weak) UIView *maskView;

@end


@implementation BPTestViewController

@dynamic str1;

- (NSString *)str1 {
    return @"";
}

- (void)setStr1:(NSString *)str1 {
//    _str1 = str1;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testMaskLayer];
    return;

    [self testAsync];
    [self testAsync1];

    return;
    
    
    NSString *str1 = @"a";
    NSString *str2 = @"a";

    NSNumber *number1 = @(1);
    NSNumber *number2 = @(1);

    
    NSArray *array = @[str1,number1];
    
    BPLog(@"%d,%d,%d,%d",[str1 isEqual:str2],[number1 isEqual:number2],[array containsObject:str2],[array containsObject:number2]);

    
//    [self InitializeCircleProgressButton];
}

- (void)testMaskLayer {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"cell_autoLayoutHeight03"];
    [self.view addSubview:imageView];
    
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    _maskView = maskView;
    maskView.backgroundColor = [kRedColor colorWithAlphaComponent:1];
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
    [maskView addGestureRecognizer:tap];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(5, 436, 90, 40) cornerRadius:5] bezierPathByReversingPath]];
    
    
    // 构造e了一个镂空的layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = kGreenColor.CGColor;
    shapeLayer.strokeColor = kBlueColor.CGColor;
    shapeLayer.lineWidth = 1;
    
    shapeLayer.path = path.CGPath;
    // 当shapeLayer的部分有颜色时，才能看到maskView；关键点是：没有颜色（透明）时看不到maskView，但是能看到maskView.layer的前一个
    [maskView.layer setMask:shapeLayer];
    //[maskView.layer addSublayer:shapeLayer];
}

- (void)remove {
    [_maskView removeFromSuperview];
}

- (void)testAsync {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"testAsync");
    });
}

- (void)testAsync1 {
    NSLog(@"testAsync1");
}

- (void)InitializeCircleProgressButton {
    BPCircleProgressButton *playerButton = [BPCircleProgressButton buttonWithType:UIButtonTypeCustom];
    playerButton.bounds = CGRectMake(0, 0, 100, 100);
    playerButton.center = self.view.center;
    playerButton.showsTouchWhenHighlighted = NO;
    playerButton.enabled = YES;
    playerButton.progress = 0.5;
    [self.view addSubview:playerButton];
    playerButton.backgroundColor = kGreenColor;
}

#pragma mark - 系统手势
- (void)configureNaviPropery {
    self.navigationController.hidesBarsWhenKeyboardAppears = YES; // 当键盘弹出的时候，导航栏自动隐藏，默认NO，注意：如果只设置这个属性为YES，键盘出现的时候，导航栏就自动隐藏了，但是之后无论怎么操作，导航栏都不会再显示出来，所有需要配合hidesBarsOnSwipe或者hidesBarsOnTap使用，这样的话，导航栏就能自如的隐藏和展示了
    
    self.navigationController.hidesBarsOnSwipe = YES; // 上下滑动的时候，导航栏自动隐藏和显示
    [self.navigationController.barHideOnSwipeGestureRecognizer addTarget:self action:@selector(swipeGesture:)];
    
    self.navigationController.hidesBarsOnTap = YES; // 点击控制器的时候，导航栏自动隐藏和显示
    
    self.navigationController.hidesBarsWhenVerticallyCompact = YES; // 当导航栏的垂直size比较紧凑的时候，导航栏自动隐藏
    
    //interactivePopGestureRecognizer属性，这个属性是只读的，用来操作控制器的手势返回滑动。
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    //toolbarHidden属性,toolbarHidden属性默认是关闭的，
    self.navigationController.toolbarHidden = NO;
    
    //hidesBottomBarWhenPushed属性，该属性默认NO，设置为YES的话，在导航栏push控制器的时候，自动将tabBar隐藏，隐藏之后不会自动显示出来，还需手动设置
    self.navigationController.hidesBottomBarWhenPushed = YES;
}

- (void)swipeGesture:(UILongPressGestureRecognizer*)gestureRecognizer{
    BPLog(@"swipeGesture");
}

- (CGSize)intrinsicContentSize {
    return UILayoutFittingExpandedSize;
}


#pragma mark - 边界之外能否响应
- (void)configureViewOut {
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = kClearColor;
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(120);
        make.center.equalTo(self.view);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = kGreenColor;
    [backView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(backView);
    }];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kRedColor;
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [rightButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(30);
        make.top.equalTo(view).offset(-15);
        make.trailing.equalTo(view.mas_trailing).offset(15);
    }];
    //    view.layer.masksToBounds = YES;
}

#pragma mark - view hidden lauout 依赖
- (void)configureLayout {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    [rightButton setBackgroundImage:[UIImage imageNamed:@"transitionWithType01"] forState:UIControlStateNormal];
    [rightButton setTitle:@"push" forState:UIControlStateNormal];
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:27.0f];
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [rightButton.titleLabel sizeToFit];
    rightButton.imageView.layer.masksToBounds = YES;
    rightButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [rightButton addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.backgroundColor = kGreenColor;
    [self.view addSubview:rightButton];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.width.height.mas_equalTo(50);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    [bottomButton setBackgroundImage:[UIImage imageNamed:@"transitionWithType01"] forState:UIControlStateNormal];
    [bottomButton setTitle:@"push" forState:UIControlStateNormal];
    [bottomButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:27.0f];
    [bottomButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [bottomButton.titleLabel sizeToFit];
    bottomButton.imageView.layer.masksToBounds = YES;
    bottomButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [bottomButton addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    bottomButton.backgroundColor = kGreenColor;
    [self.view addSubview:bottomButton];
    
    //rightButton.hidden = YES;
    
    [bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightButton).offset(100);
        make.width.height.mas_equalTo(50);
        make.centerX.equalTo(self.view);
    }];
}

- (void)next:(UIButton *)bt {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
