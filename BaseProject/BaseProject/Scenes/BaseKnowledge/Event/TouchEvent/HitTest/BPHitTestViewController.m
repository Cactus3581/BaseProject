//
//  BPHitTestViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPHitTestViewController.h"
#import "UIView+BPToast.h"
#import "BPHitTestViewBaseProcessSuperView.h"
#import "BPHitTestViewEnLargeSuperView.h"
#import "BPHitTestInterceptParentView.h"
#import "BPOutSideSuperView.h"
#import "UIResponder+BPMsgSend.h"
#import "BPHitTestGestureView.h"
#import "BPHitTestButton.h"
#import "BPHitTestNoGestureView.h"

/*
 1、扩大UIButton的响应热区
 2、子view超出了父view的bounds响应事件
 3、ScrollView page滑动
 */

@interface BPHitTestViewController ()

@property (nonatomic,weak) UIButton *button;
@end


@implementation BPHitTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            case 0:{
                [self baseUse];
            }
                break;
                
            case 1:{
                [self eventIntercept];
            }
                break;
                
            case 2:{
                [self eventOutSide];
            }
                break;
                
            case 3:{
                [self eventEnLarge];
            }
                break;
                
            case 4:{
                [self eventOutSide]; // 多层级View的通讯
            }
                break;
                
            case 5:{
                [self gesture]; // 手势对响应链传递的影响
            }
                break;
                
            case 6:{
                [self control]; // UIControl 对响应链传递的影响
            }
                break;
                
            case 7:{
                [self findVC]; // 找到 响应者所在的控制器
            }
                break;
                
                
        }
    }
}

#pragma mark - 找到 响应者所在的控制器

- (void)findVC {
    [self.view bp_parentController];
}

#pragma mark - 基础过程
- (void)baseUse {
    
    BPHitTestViewBaseProcessSuperView *hitView = [[BPHitTestViewBaseProcessSuperView alloc]init];
    hitView.backgroundColor = kLightGrayColor;
    [self.view addSubview:hitView];
    
    [hitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(hitView.mas_width);
        make.center.equalTo(self.view);
    }];
}

#pragma mark - 事件拦截，让其他 responder 处理事件
- (void)eventIntercept {
    BPHitTestInterceptParentView *hitView = [[BPHitTestInterceptParentView alloc]init];
    hitView.backgroundColor = kLightGrayColor;
    [self.view addSubview:hitView];
    
    [hitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(hitView.mas_width);
        make.center.equalTo(self.view);
    }];
}

#pragma mark - 事件转发，让边界之外也能响应
- (void)eventOutSide {
    BPOutSideSuperView *hitView = [[BPOutSideSuperView alloc]init];
    hitView.backgroundColor = kLightGrayColor;
    [self.view addSubview:hitView];
    
    [hitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(hitView.mas_width);
        make.center.equalTo(self.view);
    }];
}

#pragma mark - 扩大响应范围
- (void)eventEnLarge {
    BPHitTestViewEnLargeSuperView *hitView = [[BPHitTestViewEnLargeSuperView alloc]init];
    hitView.backgroundColor = kLightGrayColor;
    [self.view addSubview:hitView];
    
    [hitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(100));
        make.center.equalTo(self.view);
    }];
}

#pragma mark - 多层级View的通讯
- (void)bp_routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo {
    NSLog(@"%s eventName:%@",__func__,eventName);
}

#pragma mark - 手势对响应链传递的影响
- (void)gesture {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    BPHitTestGestureView *hitView = [[BPHitTestGestureView alloc]init];
    hitView.backgroundColor = kRedColor;
    [self.view addSubview:hitView];
    
    [hitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(100));
        make.center.equalTo(self.view);
    }];
    
    BPHitTestNoGestureView *hitView1 = [[BPHitTestNoGestureView alloc]init];
    hitView1.backgroundColor = kLightGrayColor;
    [self.view addSubview:hitView1];

    [hitView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hitView.mas_bottom).offset(-30);
        make.centerX.width.height.equalTo(hitView);
    }];
}

#pragma mark - UIControl 对响应链传递的影响
- (void)control {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    BPHitTestButton *button = [BPHitTestButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = kRedColor;
    [button setTitle:@"Button" forState:UIControlStateNormal];
    [button setTitleColor:kPurpleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(100));
        make.center.equalTo(self.view);
    }];
    
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}
+ (void)load {
    
}
- (void)tap {
    BPLog(@"controller tap");
}

- (void)buttonAction {
    BPLog(@"BPHitTestButton Action");
//    [self bp_routerEventWithName:@"" userInfo:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"Controller Began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"Controller Move");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"Controller End");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"Controller Cancelled");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
