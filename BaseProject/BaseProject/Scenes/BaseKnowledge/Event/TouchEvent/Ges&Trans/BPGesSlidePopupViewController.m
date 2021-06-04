//
//  BPGesSlidePopupViewController.m
//  BaseProject
//
//  Created by Ryan on 2021/5/31.
//  Copyright © 2021 cactus. All rights reserved.
//

#import "BPGesSlidePopupViewController.h"
#import "BPGesSlidePopupView.h"

@interface BPGesSlidePopupViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, BPGesSlidePopupViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@end


@implementation BPGesSlidePopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"showPopView";
    self.dataSource = @[];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self showGesSlidePopupView];
}

- (void)showGesSlidePopupView {
    UIView *view = [UIView new];
    UIView *headerView = [UIView new];
    headerView.backgroundColor = kGreenColor;
    [view addSubview:headerView];
    [view addSubview:self.collectionView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(view);
        make.height.mas_equalTo(80);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(view);
        make.top.equalTo(headerView.mas_bottom);
    }];

    [BPGesSlidePopupView showInView:self.view contentView:view delegate:self];
}

- (void)popupViewShowFinished:(BPGesSlidePopupView *)popupView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //  分页拉取数据
        self.dataSource = @[@"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1", @"1"];
        [self.collectionView reloadData];
        [popupView reload];
    });
}

- (CGFloat)popupView:(BPGesSlidePopupView *)popupView heightForContentViewWidth:(CGFloat)width {
    if (self.dataSource.count == 0) {
        return 150;
    }
    NSInteger perLineCount = (width - 10 - 10 + 10) / (100+10);
    NSInteger line = self.dataSource.count / perLineCount;
    NSInteger isAddline = self.dataSource.count % perLineCount;
    if (isAddline != 0) {
        line += 1;
    }
    CGFloat height = line * 100 + 10 + 10 + (line-1)*20;
    return height+80;
}

#pragma mark - 布局collectionview
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 20;
        flowLayout.itemSize = CGSizeMake(100, 100);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = YES;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.backgroundColor = kRedColor;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kGreenColor;
    return cell;
}

@end

