//
//  BPPushChildViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/5/3.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPPushChildViewController.h"

@interface BPPushChildViewController ()

@end

@implementation BPPushChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)initialize {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = kThemeColor;
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *reoveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    reoveButton.backgroundColor = kThemeColor;
    [reoveButton addTarget:self action:@selector(removeSubController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [self.view addSubview:reoveButton];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(100);
        make.top.equalTo(self.view).offset(100);
    }];
    
    [reoveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(button);
        make.size.equalTo(button);
        make.top.equalTo(button.mas_bottom).offset(20);
    }];
}

- (void)buttonAction {
    BPBaseViewController *vc = [[BPBaseViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeSubController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    BPLog(@"dealloc");
}

@end
