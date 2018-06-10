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
    [self handleDynamicJumpData];
}

- (void)handleDynamicJumpData {
    if (self.needDynamicJump) {
        NSInteger type = [self.dynamicJumpDict[@"type"] integerValue];
        switch (type) {
            case 0:{
                [self testAnchorPointAndAutoLayout];//测试锚点
            }
                break;
                
            case 1:{
                [self configureButton];
            }
                break;
                
            case 2:{
                [self configCollectionView];
            }
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - 测试锚点
- (void)testAnchorPointAndAutoLayout {
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.backgroundColor = kThemeColor;
    [rightButton setTitle:@"standard" forState:UIControlStateNormal];
    [rightButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(80);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton1.layer.anchorPoint = CGPointMake(0, 0);
    rightButton1.backgroundColor = kExplicitColor;
    [rightButton1 setTitle:@"show" forState:UIControlStateNormal];
    [rightButton1 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [self.view addSubview:rightButton1];

    [rightButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
        //重点测试点
//        make.leading.equalTo(rightButton);
//        make.top.equalTo(rightButton).offset(0);
        
        make.center.equalTo(rightButton);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.anchorPopView removePopView];
}

#pragma mark - 无列表锚点动画
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

#pragma mark - 列表 showPopView
- (void)nextAction:(NSIndexPath *)indexpath {
    BPPopCollectionViewCell *cell = (BPPopCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
    [self.view addSubview:self.anchorPopView];
    self.anchorPopView.targetView = cell.button;
    [_anchorPopView showPopView];
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
