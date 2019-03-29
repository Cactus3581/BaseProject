//
//  BPGetFrameViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGetFrameViewController.h"
#import "BPGetFrameView.h"

@interface BPGetFrameViewController ()
@property (nonatomic,weak) BPGetFrameView *getFrameView;
@end

@implementation BPGetFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BPLog(@"self.view viewDidLoad = %@",NSStringFromCGRect(self.view.frame));
    BPGetFrameView *getFrameView = [[BPGetFrameView alloc] init];
    _getFrameView = getFrameView;
    [self.view addSubview:getFrameView];

    [getFrameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    BPLog(@"getFrameView init = %@",NSStringFromCGRect(self.getFrameView.frame));

#pragma mark - 方法1
    [_getFrameView getFrame];

//    [self.view setNeedsLayout];
//    [self.view layoutIfNeeded];
    getFrameView.backgroundColor = kThemeColor;
}

#pragma mark - 方法2.1
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    BPLog(@"%.2f",_getFrameView.width);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
