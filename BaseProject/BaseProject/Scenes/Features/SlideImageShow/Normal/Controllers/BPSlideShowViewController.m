//
//  BPSlideShowViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/10.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPSlideShowViewController.h"
#import "BPSliderShowView.h"

@interface BPSlideShowViewController ()
@property (nonatomic,weak) BPSliderShowView *sliderShowView;
@end

@implementation BPSlideShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.sliderShowView.imageArray = @"";
    self.sliderShowView.clickImageBlock = ^(NSInteger currentIndex) {
        BPLog(@"currentIndex = %ld",currentIndex);
    };

}

- (BPSliderShowView *)sliderShowView {
    if (!_sliderShowView) {
        BPSliderShowView *sliderShowView = [[BPSliderShowView alloc] init];
        _sliderShowView = sliderShowView;
        [self.view addSubview:self.sliderShowView];
        [self.sliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.trailing.centerY.equalTo(self.view);
            make.centerY.equalTo(self.view);
            make.leading.equalTo(self.view).offset(50);
            make.trailing.equalTo(self.view).offset(-50);
            make.height.mas_equalTo(200);
        }];
    }
    return _sliderShowView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
