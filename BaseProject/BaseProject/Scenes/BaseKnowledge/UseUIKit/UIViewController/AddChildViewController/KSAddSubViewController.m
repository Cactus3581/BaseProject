//
//  KSAddSubViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSAddSubViewController.h"
#import "KSAddSubViewSubController.h"
#import "BPAppDelegate.h"
#import "KSAddSubViewSubController.h"

@interface KSAddSubViewController ()

@property (nonatomic,weak) UIViewController *subVc;

@end


@implementation KSAddSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        
        switch (type) {
                
            case 0:{
                [self onlyUseAddSubviewInViewByCurrentController];
            }
                break;
                
            case 1:{
                [self onlyUseAddSubviewInViewByCustomController];
            }
                break;
                
            case 2:{
                [self addChildViewControllerInViewByCurrentController];
            }
                break;
                
            case 3:{
                [self addChildViewControllerInViewByCustomController];
            }
                break;
                
            case 4:{
                [self onlyUseAddSubviewInWindowByCurrentController];
            }
                break;
                
            case 5:{
                [self onlyUseAddSubviewInWindowByCustomController];
            }
                break;
        }
    }
}

#pragma mark - 创建子控制器，并将事件写到本类里，然后将 子控制器 的View 添加到self.view上，手势和按钮事件可以响应，但是无法移除子VC（不知道方法是什么）

- (void)onlyUseAddSubviewInViewByCurrentController {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = kThemeColor;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *tapView = [[UIView alloc] init];
    tapView.backgroundColor = kThemeColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
    [tapView addGestureRecognizer:tap];
    
    UIButton *reoveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    reoveButton.backgroundColor = kThemeColor;
    [reoveButton addTarget:self action:@selector(removeSubController) forControlEvents:UIControlEventTouchUpInside];
    
    UIViewController *subVc = [[UIViewController alloc] init];
    _subVc = subVc;
    subVc.view.backgroundColor = kExplicitColor;
    
    [subVc.view addSubview:button];
    [subVc.view addSubview:reoveButton];
    [subVc.view addSubview:tapView];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(subVc.view);
        make.size.mas_equalTo(100);
        make.top.equalTo(subVc.view).offset(100);
    }];
    
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(button.mas_bottom).offset(20);
    }];
    
    [reoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(tapView.mas_bottom).offset(20);
    }];
    
    subVc.view.frame = self.view.bounds;
    [self.view addSubview:subVc.view];
}

- (void)buttonAction {
    BPLog(@"buttonAction");
}

- (void)tapGestureRecognizerAction {
    BPLog(@"tapGestureRecognizerAction");
}

- (void)removeSubController {
    [_subVc.view removeFromSuperview];
    _subVc.view = nil;
    _subVc = nil;
    BPLog(@"removeSubController");
}

#pragma mark - 创建自定义控制器，并将事件写到自定义控制器类里，然后将 子控制器 的View 添加到self.view上，按钮事件可以响应，但是手势无法响应，也无法移除子VC（不知道方法是什么）
- (void)onlyUseAddSubviewInViewByCustomController {
    KSAddSubViewSubController *subVc = [[KSAddSubViewSubController alloc] init];
    _subVc = subVc;
    subVc.view.backgroundColor = kExplicitColor;
    subVc.view.frame = self.view.bounds;
    [self.view addSubview:subVc.view];
}

#pragma mark - 创建子控制器，并将事件写到本类里，然后使用addChildViewController方法，按钮事件和手势可以响应，也可以正确移除子VC

- (void)addChildViewControllerInViewByCurrentController {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = kThemeColor;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *tapView = [[UIView alloc] init];
    tapView.backgroundColor = kThemeColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
    [tapView addGestureRecognizer:tap];
    
    UIButton *reoveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    reoveButton.backgroundColor = kThemeColor;
    [reoveButton addTarget:self action:@selector(removeChildVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIViewController *subVc = [[UIViewController alloc] init];
    _subVc = subVc;
    subVc.view.backgroundColor = kExplicitColor;
    
    [subVc.view addSubview:button];
    [subVc.view addSubview:tapView];
    [subVc.view addSubview:reoveButton];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(subVc.view);
        make.size.mas_equalTo(100);
        make.top.equalTo(subVc.view).offset(100);
        
    }];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(reoveButton.mas_bottom).offset(20);
    }];
    
    [reoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(button.mas_bottom).offset(20);
    }];
    
    [self addChildViewController:subVc];//1.addChildViewController:的同时调用addSubView：
    [self.view addSubview:subVc.view];
    subVc.view.frame = self.view.bounds;
    [subVc didMoveToParentViewController:self];
}

//移除子视图
- (void)removeChildVC {
    [_subVc willMoveToParentViewController:nil];//需要显示调用：通知child，即将解除父子关系，设置 child的parent即将为nil。
    [_subVc.view removeFromSuperview];
    [_subVc removeFromParentViewController];
    //[_subVc didMoveToParentViewController:nil];//不需要显示调用
}

#pragma mark - 创建自定义控制器，并将事件写到自定义控制器类里，然后使用用addChildViewController方法，按钮事件和手势可以响应，也可以正确移除子VC
- (void)addChildViewControllerInViewByCustomController {
    KSAddSubViewSubController *subVc = [[KSAddSubViewSubController alloc] init];
    subVc.isRemoveSubController = YES; // 注释掉，不会释放subVC
    _subVc = subVc;
    subVc.view.backgroundColor = kExplicitColor;    
    [self addChildViewController:subVc];//1.addChildViewController:的同时调用addSubView：
    [self.view addSubview:subVc.view];
    subVc.view.frame = self.view.bounds;
    [subVc didMoveToParentViewController:self];
}

#pragma mark - 创建子控制器，并将事件写到本类里，然后将 子控制器 的View 添加到window上，按钮事件和手势可以响应，但是无法移除子VC
- (void)onlyUseAddSubviewInWindowByCurrentController {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = kThemeColor;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *reoveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    reoveButton.backgroundColor = kThemeColor;
    [reoveButton addTarget:self action:@selector(removeSubController) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *tapView = [[UIView alloc] init];
    tapView.backgroundColor = kThemeColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction)];
    [tapView addGestureRecognizer:tap];
    
    UIViewController *subVc = [[UIViewController alloc] init];
    _subVc = subVc;
    subVc.view.backgroundColor = kExplicitColor;
    
    [subVc.view addSubview:button];
    [subVc.view addSubview:reoveButton];
    [subVc.view addSubview:tapView];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(subVc.view);
        make.size.mas_equalTo(100);
        make.top.equalTo(subVc.view).offset(100);
    }];
    
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(button.mas_bottom).offset(20);
    }];
    
    [reoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(tapView.mas_bottom).offset(20);
    }];
    
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:subVc.view];
    subVc.view.frame = delegate.window.bounds;
}

#pragma mark - 创建自定义控制器，并将事件写到自定义控制器类里，然后将 子控制器 的View 添加到window上，按钮事件和手势都无法响应，也无法移除子VC
- (void)onlyUseAddSubviewInWindowByCustomController {
    KSAddSubViewSubController *subVc = [[KSAddSubViewSubController alloc] init];
    _subVc = subVc;
    subVc.view.backgroundColor = kExplicitColor;
    
    BPAppDelegate *delegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:subVc.view];
    subVc.view.frame = delegate.window.bounds;
}

- (void)dealloc {
    BPLog(@"%@",_subVc);
}

@end
