//
//  BPPreferredMaxLayoutWidthViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPPreferredMaxLayoutWidthViewController.h"
#import "BPPreferredMaxLayoutWidthView.h"

@interface BPPreferredMaxLayoutWidthViewController ()

@property (nonatomic,weak) BPPreferredMaxLayoutWidthView *preferredMaxLayoutWidthView;
@end

@implementation BPPreferredMaxLayoutWidthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredMaxLayoutWidthView.backgroundColor = kWhiteColor;
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (BPPreferredMaxLayoutWidthView *)preferredMaxLayoutWidthView {
    if (!_preferredMaxLayoutWidthView) {
        BPPreferredMaxLayoutWidthView *preferredMaxLayoutWidthView = [[BPPreferredMaxLayoutWidthView alloc] init];
        _preferredMaxLayoutWidthView = preferredMaxLayoutWidthView;
        [self.view addSubview:_preferredMaxLayoutWidthView];
        [_preferredMaxLayoutWidthView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _preferredMaxLayoutWidthView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
