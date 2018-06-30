//
//  BPAutoLayoutUpdateConstraintsController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutoLayoutUpdateConstraintsController.h"
#import "BPAutoLayoutUpdateView.h"

@interface BPAutoLayoutUpdateConstraintsController ()
@property (nonatomic,weak) BPAutoLayoutUpdateView *updateView;
@property (nonatomic, assign) BOOL animate;
@end

@implementation BPAutoLayoutUpdateConstraintsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"animate";
    self.updateView.backgroundColor = kWhiteColor;
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)rightBarButtonItemClickAction:(id)sender {
    self.animate = !self.animate;
    self.updateView.animate = self.animate;
}

- (BPAutoLayoutUpdateView *)updateView {
    if (!_updateView) {
        BPAutoLayoutUpdateView *updateView = [[BPAutoLayoutUpdateView alloc] init];
        _updateView = updateView;
        [self.view addSubview:_updateView];
        [_updateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _updateView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

