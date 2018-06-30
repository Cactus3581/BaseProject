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

#import "BPAlignmentRectInsetsLabel.h"

/*
 你可能会直观的认为 Auto Layout 中，约束是使用 frame 来确定视图的大小和位置的，但实际上，它使用的是 对齐矩形(alignment rect) 这个几何元素。不过在大多数情况下，frame 和 alignment rect 是相等的，所以你这么理解也没什么不对。
 
 对齐矩形不作为frame的一部分,autoLayout操作的是对齐矩形，比方说，将原来view的对齐矩形方法重写，四周扩大10，frame还是跟原来一样，但是位置和大小变了，重复遍：autoLayout操作的是对齐矩形！
 
 */

@interface BPAlignmentRectInsetsController ()
@property (nonatomic,weak) BPAlignmentRectInsetsView *alignmentRectInsetsView;
@property (nonatomic,weak) BPAlignmentRectInsetsTemplateView *alignmentRectInsetsTemplateView;
@property (nonatomic,weak) BPAlignmentRectInsetsLabel *alignmentRectInsetsLabel;

@property (nonatomic,assign) NSInteger index;
@end

@implementation BPAlignmentRectInsetsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configRightBarButtomItem];
    self.alignmentRectInsetsView.backgroundColor = kThemeColor;
    self.alignmentRectInsetsTemplateView.backgroundColor = kThemeColor;
    self.alignmentRectInsetsLabel.text = @"我是继承自重写对齐矩形的Label";
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    for (UIView *subView in self.alignmentRectInsetsTemplateView.subviews) {
        if ([subView isKindOfClass:[BPAlignmentRectInsetsLabel class]]) {
            BPLog(@"BPAlignmentRectInsetsLabel = %@",NSStringFromCGRect(subView.frame));
        }
    }
    BPLog(@"%@",NSStringFromCGRect(self.alignmentRectInsetsView.frame));
    BPLog(@"%@",NSStringFromCGRect(self.alignmentRectInsetsTemplateView.frame));
    BPLog(@"%@",NSStringFromCGRect(self.alignmentRectInsetsLabel.frame));

}

#pragma mark - config rightBarButtonItem
- (void)configRightBarButtomItem {
    UIView *view = [[UIView alloc] init];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTintColor:kWhiteColor];
    [rightBarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton setTitle:@"Normal" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font  = BPFont(16);
    [rightBarButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton sizeToFit];
    rightBarButton.frame = CGRectMake(CGRectGetMinX(rightBarButton.frame), 0, CGRectGetWidth(rightBarButton.bounds), bp_naviItem_height);

    UIButton *rightBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton1 setTintColor:kWhiteColor];
    [rightBarButton1 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton1 setTitle:@"RectInsets" forState:UIControlStateNormal];
    rightBarButton1.titleLabel.font  = BPFont(16);
    [rightBarButton1 addTarget:self action:@selector(change1) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton1.frame = CGRectMake(CGRectGetMaxX(rightBarButton.frame)+10, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton1 sizeToFit];
    rightBarButton1.frame = CGRectMake(CGRectGetMinX(rightBarButton1.frame), 0, CGRectGetWidth(rightBarButton1.bounds), bp_naviItem_height);

    [view addSubview:rightBarButton];
    [view addSubview:rightBarButton1];
    
    view.frame = CGRectMake(0, 0, rightBarButton.width+10+rightBarButton1.width+5, bp_naviItem_height);
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

- (BPAlignmentRectInsetsLabel *)alignmentRectInsetsLabel {
    if (!_alignmentRectInsetsLabel) {
        BPAlignmentRectInsetsLabel *alignmentRectInsetsLabel = [[BPAlignmentRectInsetsLabel alloc] init];
        _alignmentRectInsetsLabel = alignmentRectInsetsLabel;
        _alignmentRectInsetsLabel.backgroundColor = kThemeColor;
        _alignmentRectInsetsLabel.textColor = kWhiteColor;
        [self.view addSubview:_alignmentRectInsetsLabel];
        [_alignmentRectInsetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(0);
        }];
    }
    return _alignmentRectInsetsLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
