//
//  BPInheritViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPInheritViewController.h"
#import "BPPaddingButton.h"

@interface BPInheritViewController ()
@property (nonatomic,weak) UIButton *referenceButton;
@property (nonatomic,weak) BPPaddingButton *paddingButton;
@end

@implementation BPInheritViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initReferenceView];
    [self testPaddingButton];
}

- (void)initReferenceView {
    UIButton *referenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _referenceButton = referenceButton;
    [referenceButton setTitle:@"i am referenceButton" forState:UIControlStateNormal];
    referenceButton.backgroundColor = kThemeColor;
    [referenceButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.view addSubview:referenceButton];
    [referenceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(80);
        make.width.height.mas_equalTo(100);
    }];
}

- (void)testPaddingButton {
    UIView *backView = [[UIView alloc] init];
    [self.view addSubview:backView];
    backView.backgroundColor = kRedColor;
    
    BPPaddingButton *paddingButton = [BPPaddingButton buttonWithType:UIButtonTypeCustom];
    _paddingButton = paddingButton;
    [paddingButton setTitle:@"i am paddingButton" forState:UIControlStateNormal];
    [paddingButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.view addSubview:paddingButton];
    [paddingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.referenceButton.mas_bottom).mas_offset(50);
//        make.width.height.mas_equalTo(200);
    }];
    
    [paddingButton addTarget:self action:@selector((clickAction)) forControlEvents:UIControlEventTouchUpInside];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.referenceButton.mas_bottom).mas_offset(50);
        make.width.height.mas_equalTo(200);
    }];
}

- (void)clickAction {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
