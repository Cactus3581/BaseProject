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


