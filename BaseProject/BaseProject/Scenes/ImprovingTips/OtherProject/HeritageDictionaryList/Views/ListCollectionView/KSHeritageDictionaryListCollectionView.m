//
//  KSHeritageDictionaryListCollectionView.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/5/14.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSHeritageDictionaryListCollectionView.h"
#import "KSHeritageDictionaryListCollectionViewCell.h"
#import "KSHeritageDictionaryMacro.h"

static NSString *kHeritageDictionaryList  = @"KSHeritageDictionaryList";
@interface KSHeritageDictionaryListCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) UICollectionView *collectionView;
@end

@implementation KSHeritageDictionaryListCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCollectionView];
}

- (void)setHeaderView:(UIView *)headerView {
    _headerView = headerView;
    //self.tableView.tableHeaderView = headerView;
}

- (void)setArray:(NSArray *)array {
    _array = array;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)configureCollectionView {
    self.backgroundColor = kWhiteColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];;
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KSHeritageDictionaryListCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"KSHeritageDictionaryListCollectionViewCell"];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return BPValidateArray(self.array).count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.width,165.f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSHeritageDictionaryListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSHeritageDictionaryListCollectionViewCell" forIndexPath:indexPath];
    KSWordBookAuthorityDictionaryThirdCategoryModel *thirdCategoryModel = self.array[indexPath.row];
    [cell setModel:thirdCategoryModel indexPath:indexPath];

    return cell;
}



@end

