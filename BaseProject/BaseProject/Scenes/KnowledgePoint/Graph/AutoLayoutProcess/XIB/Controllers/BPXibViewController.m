//
//  BPXibViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/15.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPXibViewController.h"
#import "BPXibView.h"

@interface BPXibViewController ()
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) BPXibView *xibview;
@end
//intrinsicContentSize
//http://blog.csdn.net/zhanglizhi111/article/details/78259814
//http://blog.csdn.net/u012265444/article/details/51837562
//http://www.cocoachina.com/cms/wap.php?action=article&id=12121
//http://blog.csdn.net/pucker/article/details/45149759
//https://www.jianshu.com/p/1410f4eab8b3
//http://blog.csdn.net/zhuzhihai1988/article/details/44016715
//http://www.cocoachina.com/ios/20151021/13825.html
//https://www.jianshu.com/p/66e0b808d833
//https://www.jianshu.com/p/094e6baccd5a
//https://www.jianshu.com/p/683fbcbfb705
//http://blog.csdn.net/PZ0605/article/details/47305981

@implementation BPXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BPLog(@"ViewController: 1-viewDidLoad");
}

- (void)initSubView {
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.top.equalTo(self.view).offset(100);
        make.trailing.equalTo(self.view).offset(-100);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BPLog(@"ViewController: 2-viewWillAppear");
}

- (void)viewLayoutMarginsDidChange {
    [super viewLayoutMarginsDidChange];
    BPLog(@"3");
    BPLog(@"ViewController: 3-viewLayoutMarginsDidChange");
}

- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    BPLog(@"ViewController: 4-viewSafeAreaInsetsDidChange");
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    BPLog(@"ViewController: 5-updateViewConstraints");
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    BPLog(@"ViewController: 6-viewWillLayoutSubviews");
    
}

//在view的layoutSubViews或者ViewController的viewDidLayoutSubviews方法里后可以拿到view的实际frame，所以当我们真的需要frame的时候需要在这个时间点以后才能拿到。
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    BPLog(@"ViewController: 7-viewDidLayoutSubviews");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BPLog(@"ViewController: 8-viewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    BPLog(@"ViewController: 9-viewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    BPLog(@"ViewController: 10-viewDidDisappear");
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"next" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(showView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)showView {
    [self.view addSubview:self.xibview];
    [self.xibview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.top.equalTo(self.view).offset(100);
        make.leading.equalTo(self.view).offset(100);
    }];
}

- (BPXibView *)xibview {
    if (!_xibview) {
        _xibview = [[[NSBundle mainBundle] loadNibNamed:@"BPXibView" owner:self options:nil] firstObject];
        _xibview.backgroundColor = [UIColor redColor];
    }
    return _xibview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

