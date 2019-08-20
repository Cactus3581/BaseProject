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
    BPLog(@"self.view = %@",NSStringFromCGRect(self.view.frame));
    BPGetFrameView *getFrameView = [[BPGetFrameView alloc] init];
    _getFrameView = getFrameView;
    getFrameView.backgroundColor = kThemeColor;
    [self.view addSubview:getFrameView];

    [getFrameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
    BPLog(@"getFrameView init = %@",NSStringFromCGRect(self.getFrameView.frame));

#pragma mark - 方法一
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    // receiver不能是_getFrameView，虽然size正确，但是center是错误的
    //[_getFrameView setNeedsLayout];
    //[_getFrameView layoutIfNeeded];
    BPLog(@"getFrameView layoutIfNeeded = %@",NSStringFromCGRect(self.getFrameView.frame));
}

#pragma mark - 方法二
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    BPLog(@"getFrameView viewDidLayoutSubviews = %@",NSStringFromCGRect(self.getFrameView.frame));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
