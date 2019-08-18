//
//  BPAutoLayoutScrollViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoLayoutScrollViewController.h"
#import "BPAutoLayoutScrollView.h"


@interface BPAutoLayoutScrollViewController ()

@property (nonatomic,weak) BPAutoLayoutScrollView *autoLayoutScrollView;
@end

@implementation BPAutoLayoutScrollViewController

/*
 
 1. 处理滚动视图时，可使用混合布局；
 
 2. 只要是指定了contentView并明确了contentView的布局（位置及大小），就可以不需要手动设置scroll的contentSize
 
 **/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autoLayoutScrollView.backgroundColor = kWhiteColor;
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (BPAutoLayoutScrollView *)autoLayoutScrollView {
    if (!_autoLayoutScrollView) {
        BPAutoLayoutScrollView *autoLayoutScrollView = [[BPAutoLayoutScrollView alloc] init];
        _autoLayoutScrollView = autoLayoutScrollView;
        [self.view addSubview:_autoLayoutScrollView];
        [_autoLayoutScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _autoLayoutScrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end


