//
//  BPCardPageViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCardPageViewController.h"
#import "BPCardPageView.h"
#import "BPImagetUrlHelper.h"

@interface BPCardPageViewController ()
@property (nonatomic,weak) BPCardPageView *sliderShowView;
@end

@implementation BPCardPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sliderShowView.imageArray = @[kRandomColor,kRandomColor];
    self.sliderShowView.clickImageBlock = ^(NSInteger currentIndex) {
        BPLog(@"currentIndex = %ld",currentIndex);
    };
    
}

- (BPCardPageView *)sliderShowView {
    if (!_sliderShowView) {
        BPCardPageView *sliderShowView = [[BPCardPageView alloc] init];
        _sliderShowView = sliderShowView;
        [self.view addSubview:_sliderShowView];
        [_sliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.view).offset(80);
            make.height.mas_equalTo(150);
        }];
    }
    return _sliderShowView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
