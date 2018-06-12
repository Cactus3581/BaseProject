//
//  BPNestCardViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNestCardViewController.h"
#import "BPFlowMainCatergoryView.h"
#import "BPTestNestCardViewController.h"

@interface BPNestCardViewController ()<BPFlowMainCatergoryViewDelegate>
@property (nonatomic, weak) BPFlowMainCatergoryView *flowMainCatergoryView;
@end

@implementation BPNestCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flowMainCatergoryView.backgroundColor = kWhiteColor;
    self.flowMainCatergoryView.titles = @[@"to be bester",@"to be bester",@"to be bester",@"to be bester",@"to be bester"];
}

- (void)viewSafeAreaInsetsDidChange {
    [_flowMainCatergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
}

- (BPFlowMainCatergoryView *)flowMainCatergoryView {
    if (!_flowMainCatergoryView) {
        BPFlowMainCatergoryView * flowMainCatergoryView = [[BPFlowMainCatergoryView alloc] init];
        _flowMainCatergoryView = flowMainCatergoryView;
        _flowMainCatergoryView.delegate  = self;
        [self.view addSubview:flowMainCatergoryView];

    }
    return _flowMainCatergoryView;
}

- (UIViewController *)flowMainCatergoryView:(BPFlowMainCatergoryView *)flowMainCatergoryView cellForItemAtIndexPath:(NSInteger)row {
    BPTestNestCardViewController *vc = [[BPTestNestCardViewController alloc] init];
    vc.view.backgroundColor = kRandomColor;
    return vc;
}


//旋转事件，需要重新计算cell高度
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//    [self.flowMainCatergoryView reloadData];

    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //计算旋转之后的宽度并赋值
        CGSize screen = [UIScreen mainScreen].bounds.size;
        [self.flowMainCatergoryView reloadData];

        //界面处理逻辑
        //动画播放完成之后
        if(screen.width > screen.height){
            BPLog(@"横屏");
        }else{
            BPLog(@"竖屏");
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        BPLog(@"动画播放完之后处理");
//        [self.flowMainCatergoryView reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
