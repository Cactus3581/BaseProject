//
//  BPScrollReusableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPScrollReusableViewController.h"

@interface BPScrollReusableViewController ()
@property (weak, nonatomic) UILabel *instanceNumberLabel;
@property (weak, nonatomic) UILabel *titleLabel;
@end

@implementation BPScrollReusableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self reloadData];
}

- (void)setUpViews {
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.textColor = kThemeColor;
    [self.view addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    UILabel *instanceNumberLabel = [[UILabel alloc] init];
    _instanceNumberLabel = instanceNumberLabel;
    _instanceNumberLabel.textColor = kExplicitColor;
    [self.view addSubview:_instanceNumberLabel];
    [_instanceNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view).offset(10);
        make.bottom.equalTo(self.view).offset(-10);
    }];
}

- (void)setPage:(NSNumber *)page {
    if (_page != page) {
        _page = page;
        [self reloadData];
    }
}

- (void)reloadData {
    self.titleLabel.text = [NSString stringWithFormat:@"Page #%@", self.page];
    self.instanceNumberLabel.text = [NSString stringWithFormat:@"Instance #%ld", self.numberOfInstance];
}

@end
