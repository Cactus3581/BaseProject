//
//  KSAddSubViewSubController.m
//  BaseProject
//
//  Created by Ryan on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSAddSubViewSubController.h"

@interface KSAddSubViewSubController ()

@end

@implementation KSAddSubViewSubController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)initialize {
    
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
    
    [self.view addSubview:button];
    [self.view addSubview:reoveButton];
    [self.view addSubview:tapView];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(100);
        make.top.equalTo(self.view).offset(100);
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
}

- (void)buttonAction {
    BPLog(@"buttonAction");
}

- (void)tapGestureRecognizerAction {
    BPLog(@"tapGestureRecognizerAction");
}

- (void)removeSubController {

    if (_isRemoveSubController) {
        [self willMoveToParentViewController:nil];//需要显示调用：通知child，即将解除父子关系，设置 child的parent即将为nil。
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        //[_subVc didMoveToParentViewController:nil];//不需要显示调用
    } else {
        [self.view removeFromSuperview];
        BPLog(@"removeSubController");
    }
}

- (void)dealloc {
    BPLog(@"dealloc");
}

@end
