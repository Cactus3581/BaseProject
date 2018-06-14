//
//  BPSlideShowViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/10.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSlideShowViewController.h"
#import "BPSliderShowView.h"
#import "BPTestSliderShowView.h"

@interface BPSlideShowViewController ()
@property (nonatomic,weak) BPSliderShowView *sliderShowView;
@property (nonatomic,weak) BPTestSliderShowView *testSliderShowView;

@end

@implementation BPSlideShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.sliderShowView.imageArray = @[kRedColor,kYellowColor,kBlueColor];
//    self.sliderShowView.clickImageBlock = ^(NSInteger currentIndex) {
//        BPLog(@"currentIndex = %ld",currentIndex);
//    };
    
    self.testSliderShowView.imageArray = @[kRedColor,kYellowColor,kBlueColor];
    self.testSliderShowView.clickImageBlock = ^(NSInteger currentIndex) {
        BPLog(@"currentIndex = %ld",currentIndex);
    };

}

- (BPSliderShowView *)sliderShowView {
    if (!_sliderShowView) {
        BPSliderShowView *sliderShowView = [[BPSliderShowView alloc] init];
        _sliderShowView = sliderShowView;
        [self.view addSubview:_sliderShowView];
        [_sliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.centerY.equalTo(self.view);
            make.height.mas_equalTo(200);
        }];
        BPLog(@"%@",NSStringFromCGRect(_sliderShowView.frame));
        [self.view updateConstraintsIfNeeded];
        BPLog(@"%@",NSStringFromCGRect(_sliderShowView.frame));
        [_sliderShowView updateConstraintsIfNeeded];
        BPLog(@"%@",NSStringFromCGRect(_sliderShowView.frame));
        [_sliderShowView layoutIfNeeded];
        BPLog(@"%@",NSStringFromCGRect(_sliderShowView.frame));
        [self.view layoutIfNeeded];
        BPLog(@"%@",NSStringFromCGRect(_sliderShowView.frame));
    }
    return _sliderShowView;
}

- (BPTestSliderShowView *)testSliderShowView {
    if (!_testSliderShowView) {
        BPTestSliderShowView *testSliderShowView = [[BPTestSliderShowView alloc] init];
        _testSliderShowView = testSliderShowView;
        [self.view addSubview:_testSliderShowView];
        [_testSliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view).offset(10);
            make.trailing.equalTo(self.view).offset(-10);
            make.top.equalTo(self.sliderShowView.mas_bottom).offset(10);
            make.height.mas_equalTo(200);
        }];
    }
    return _testSliderShowView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
