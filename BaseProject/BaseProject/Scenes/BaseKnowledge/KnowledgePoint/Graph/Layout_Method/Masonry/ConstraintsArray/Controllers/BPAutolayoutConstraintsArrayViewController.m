//
//  BPAutolayoutConstraintsArrayViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAutolayoutConstraintsArrayViewController.h"
#import "BPAutolayoutConstraintsArrayView.h"

@interface BPAutolayoutConstraintsArrayViewController ()
@property (nonatomic,weak) BPAutolayoutConstraintsArrayView *updateView;
@property (nonatomic, assign) BOOL animate;
@end

@implementation BPAutolayoutConstraintsArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.updateView.backgroundColor = kWhiteColor;
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (BPAutolayoutConstraintsArrayView *)updateView {
    if (!_updateView) {
        BPAutolayoutConstraintsArrayView *updateView = [[BPAutolayoutConstraintsArrayView alloc] init];
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
