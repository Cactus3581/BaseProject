//
//  BPArrowPopViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/1/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPArrowPopViewController.h"
#import "BPArrowPopView.h"

@interface BPArrowPopViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) BPArrowPopView *arrowPopView;
@end

@implementation BPArrowPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"绘制箭头popView";
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self showPopView:sender];
}

#pragma mark - 自定义绘制箭头popView
- (void)showPopView:(UIView *)view {
    [self.view addSubview:self.arrowPopView ];
    [self.arrowPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.leading.equalTo(self.view).offset(10);
        make.trailing.equalTo(self.view).offset(-10);
    }];
}

- (BPArrowPopView *)arrowPopView {
    if (!_arrowPopView) {
        _arrowPopView = [[BPArrowPopView alloc]init];
        [_arrowPopView setBackgroundColor:kOrangeColor];
    }
    return _arrowPopView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.arrowPopView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
