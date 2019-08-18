//
//  BPAutoLayoutPriorityViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoLayoutPriorityViewController.h"

@interface BPAutoLayoutPriorityViewController ()
@property (nonatomic,weak) UILabel *leftLabel1;
@property (nonatomic,weak) UILabel *rightLabel1;



@property (nonatomic,assign) BOOL change;

@end

/*
 约束优先级核心就是是为了 "有些场景需要动态进行布局，如果存在多套约束的情况下，解决约束冲突" 的问题。
 

 **/
@implementation BPAutoLayoutPriorityViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"change";
    self.leftLabel1.text = @"加入阅读列表";
    self.rightLabel1.text = @"马上去阅读";
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self.leftLabel1 removeFromSuperview];
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (UILabel *)leftLabel1 {
    if (!_leftLabel1) {
        UILabel *label = [[UILabel alloc] init];
        _leftLabel1 = label;
        _leftLabel1.backgroundColor = kThemeColor;
        _leftLabel1.textColor = kWhiteColor;
        [self.view addSubview:_leftLabel1];
        [_leftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(50);
            make.leading.equalTo(self.view).offset(10);
        }];
    }
    return _leftLabel1;
}

- (UILabel *)rightLabel1 {
    if (!_rightLabel1) {
        UILabel *label = [[UILabel alloc] init];
        _rightLabel1 = label;
        _rightLabel1.backgroundColor = kThemeColor;
        _rightLabel1.textColor = kWhiteColor;
        [self.view addSubview:_rightLabel1];
        [_rightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_leftLabel1.mas_trailing).offset(10);
            make.leading.equalTo(self.view).offset(10).priorityMedium();
            make.centerY.equalTo(_leftLabel1);
            make.trailing.equalTo(self.view).offset(-10);
        }];
    }
    return _rightLabel1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

