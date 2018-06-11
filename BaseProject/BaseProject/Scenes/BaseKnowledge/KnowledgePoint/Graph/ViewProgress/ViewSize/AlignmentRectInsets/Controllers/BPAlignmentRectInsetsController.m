//
//  BPAlignmentRectInsetsController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAlignmentRectInsetsController.h"

#import "BPAlignmentRectInsetsView.h"
#import "BPAlignmentRectInsetsTemplateView.h"

@interface BPAlignmentRectInsetsController ()
@property (nonatomic,weak) BPAlignmentRectInsetsView *alignmentRectInsetsView;
@property (nonatomic,weak) BPAlignmentRectInsetsTemplateView *alignmentRectInsetsTemplateView;
@property (nonatomic,assign) NSInteger index;
@end

@implementation BPAlignmentRectInsetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.alignmentRectInsetsView.backgroundColor = kThemeColor;
    self.alignmentRectInsetsTemplateView.backgroundColor = kThemeColor;
    
}

#pragma mark - config rightBarButtonItem
- (void)configRightBarButtomItem {
    UIView *view = [[UIView alloc] init];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTintColor:kWhiteColor];
    [rightBarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton setTitle:@"change" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font  = BPFont(16);
    [rightBarButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton sizeToFit];
    
    UIButton *rightBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton1 setTintColor:kWhiteColor];
    [rightBarButton1 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton1 setTitle:@"change1" forState:UIControlStateNormal];
    rightBarButton1.titleLabel.font  = BPFont(16);
    [rightBarButton1 addTarget:self action:@selector(change1) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton1.frame = CGRectMake(CGRectGetMaxX(rightBarButton.frame)+10, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton1 sizeToFit];
    
    
    [view addSubview:rightBarButton];
    [view addSubview:rightBarButton1];
    view.frame = CGRectMake(0, 0, rightBarButton.width+15+rightBarButton1.width, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

- (void)change {
    if (self.index>3) {
        self.index = 0;
    }
    [self.alignmentRectInsetsView updateIndex:self.index text:nil];
    ++self.index;
}

- (void)change1 {
    if (self.index>3) {
        self.index = 0;
    }
    [self.alignmentRectInsetsTemplateView updateIndex:self.index text:nil];
    ++self.index;
}

- (BPAlignmentRectInsetsView *)alignmentRectInsetsView {
    if (!_alignmentRectInsetsView) {
        BPAlignmentRectInsetsView *alignmentRectInsetsView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BPAlignmentRectInsetsView class]) owner:self options:nil] lastObject];
        _alignmentRectInsetsView = alignmentRectInsetsView;
        [self.view addSubview:_alignmentRectInsetsView];
        [_alignmentRectInsetsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(80);

        }];
    }
    return _alignmentRectInsetsView;
}

- (BPAlignmentRectInsetsTemplateView *)alignmentRectInsetsTemplateView {
    if (!_alignmentRectInsetsTemplateView) {
        BPAlignmentRectInsetsTemplateView *alignmentRectInsetsTemplateView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BPAlignmentRectInsetsTemplateView class]) owner:self options:nil] lastObject];
        _alignmentRectInsetsTemplateView = alignmentRectInsetsTemplateView;
        [self.view addSubview:_alignmentRectInsetsTemplateView];
        [_alignmentRectInsetsTemplateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.alignmentRectInsetsView.mas_bottom).offset(20);
        }];
    }
    return _alignmentRectInsetsTemplateView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
