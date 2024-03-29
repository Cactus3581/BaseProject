//
//  BPCardPageViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/17.
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
    self.sliderShowView.imageArray = [BPImagetUrlHelper getImageUrlSet];
    [_sliderShowView setRadius:10 cornerColor:kWhiteColor];
    self.sliderShowView.clickImageBlock = ^(NSInteger currentIndex) {
        BPLog(@"currentIndex = %ld",currentIndex);
    };
}

- (BPCardPageView *)sliderShowView {
    if (!_sliderShowView) {
        BPCardPageView *sliderShowView = [[BPCardPageView alloc] init];
        _sliderShowView = sliderShowView;
        _sliderShowView.padding = 7;
        _sliderShowView.imageInset = 8;

        _sliderShowView.placeHolderImage = [UIImage imageNamed:@"reading_holder_image_left"];
        _sliderShowView.backgroundColor = kWhiteColor;
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
