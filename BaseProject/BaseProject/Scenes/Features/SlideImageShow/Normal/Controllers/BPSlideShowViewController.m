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
@property (nonatomic,strong) BPSliderShowView *sliderShowView;
@end

@implementation BPSlideShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sliderShowView];
//    self.sliderShowView.frame = CGRectMake(0, 100, kScreenWidth, 200);
    [self.sliderShowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.centerY.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    self.sliderShowView.imageArray = @[[UIColor redColor],[UIColor yellowColor],[UIColor blueColor],[UIColor greenColor],[UIColor purpleColor]];
}

- (BPSliderShowView *)sliderShowView {
    if (!_sliderShowView) {
        _sliderShowView = [[BPSliderShowView alloc] init];
        _sliderShowView.backgroundColor = [UIColor lightGrayColor];
    }
    return _sliderShowView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
