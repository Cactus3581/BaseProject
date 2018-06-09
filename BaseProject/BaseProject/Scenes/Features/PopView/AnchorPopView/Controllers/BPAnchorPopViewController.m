//
//  BPAnchorPopViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAnchorPopViewController.h"
#import "BPPopCollectionViewCell.h"
#import "BPAnchorPopView.h"
#import "Masonry.h"

@interface BPAnchorPopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate,BPPopCollectionViewCellDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) BPAnchorPopView *anchorPopView;
@end

@implementation BPAnchorPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testAnchorPoint];//测试锚点
//    [self configCollectionView];
//    [self configureButton];
}

#pragma mark - 锚点动画 - 普通button
- (void)showPopView:(UIButton *)bt {
    [self.view addSubview:self.anchorPopView];
    self.anchorPopView.targetView = bt;
    [_anchorPopView showPopView];
}

- (BPAnchorPopView *)anchorPopView {
    if (!_anchorPopView) {
        _anchorPopView = [BPAnchorPopView arrowPopViewWithHeight:80 targetView:nil superView:self.view];
        _anchorPopView.backgroundColor = kClearColor;
        //_anchorPopView.limitH = 49.0f;
        //_anchorPopView.offset = 20;
    }
    return _anchorPopView;
}

#pragma mark - 锚点动画 - 列表 showPopView
#pragma mark -cell - delegate
- (void)nextAction:(NSIndexPath *)indexpath {
    BPPopCollectionViewCell *cell = (BPPopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
    [self.view addSubview:self.anchorPopView];
    self.anchorPopView.targetView = cell.button;
    [_anchorPopView showPopView];
}

#pragma mark - 测试锚点
- (void)testAnchorPoint {
    self.view.backgroundColor = kGreenColor;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kRedColor;
    [rightButton setTitle:@"Show" forState:UIControlStateNormal];
    [rightButton setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [rightButton.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:rightButton];
    rightButton.layer.anchorPoint = CGPointMake(1, 0);
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
        make.centerX.mas_equalTo(-180);
        make.centerY.mas_equalTo(0);
        //        make.centerX.mas_equalTo(10);
        //        make.centerY.mas_equalTo(10);
    }];
    
    UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton1.backgroundColor = kPurpleColor;
    [rightButton1 setTitle:@"standard" forState:UIControlStateNormal];
    [rightButton1 setTitleColor:kPurpleColor forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [rightButton1.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [self.view addSubview:rightButton1];
    [rightButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(100);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(20);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.anchorPopView removePopView];
}

- (void)configureButton {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];//自定义样式
    rightButton.backgroundColor = kThemeColor;
    [rightButton setTitle:@"Show" forState:UIControlStateNormal];
    [rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    [[rightButton layer] setCornerRadius:25.0f];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.trailing.equalTo(self.view).offset(-30);
        make.centerY.equalTo(self.view);
    }];
}

- (void)buttonAct:(UIButton *)bt {
    [self showPopView:bt];
}

- (void)configCollectionView {
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth, 50);
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[BPPopCollectionViewCell class] forCellWithReuseIdentifier:@"BPPopCollectionViewCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPPopCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BPPopCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.path = indexPath;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

