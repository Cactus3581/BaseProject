//
//  BPPopViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPopViewController.h"
#import "Masonry.h"

@interface BPPopViewController ()

@property (nonatomic,strong) UIView *popView;
@end

@implementation BPPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"showPopView";
}

- (void)rightBarButtonItemClickAction:(id)sender {
    self.popView.backgroundColor = kThemeColor;
    [self.view layoutIfNeeded];
    [self.popView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).offset((-(CGRectGetHeight(self.popView.bounds))));
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (UIView *)popView {
    if (!_popView) {
        _popView = [[UIView alloc] init];
        [self.view addSubview:_popView];
        [_popView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@400);
            make.leading.trailing.equalTo(self.view);
            make.top.equalTo(self.view.mas_bottom);
        }];
    }
    return _popView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
