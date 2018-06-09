//
//  KSHeritageDictionaryListContainerCollectionViewCell2.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSHeritageDictionaryListContainerCollectionViewCell4.h"
#import "KSHeritageDictionaryListTagView.h"
#import "KSHeritageDictionaryListCollectionView.h"
#import "KSHeritageDictionaryListcollectionViewCell.h"
#import "KSHeritageDictionaryMacro.h"


static NSString *kHeritageDictionaryList  = @"KSHeritageDictionaryList";

@interface KSHeritageDictionaryListContainerCollectionViewCell4()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KSHeritageDictionaryListTagViewDelegate>
@property (weak, nonatomic) IBOutlet KSHeritageDictionaryListTagView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) KSWordBookAuthorityDictionaryFirstCategoryModel *model;
@end

@implementation KSHeritageDictionaryListContainerCollectionViewCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    self.tagView.delegate = self;
    [self configureCollectionView];
}

- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    self.tagView.model = model;
    if (!model.sub.count) { //没有tag
        self.tagViewHeightConstraint.constant = 0.f;
        if (model.thirdCategoryModel) {
            self.array = model.thirdCategoryModel.data;
            [self.collectionView reloadData];
        }else {
            [self requestWithID:model.classId firstCategoryModel:model secondCategoryModel:nil];
        }
    }else {
        self.tagViewHeightConstraint.constant = model.tagHeight;
        [self handleListData];
    }
}

#pragma tagView delegate
- (void)getHeight:(CGFloat)height {
    if (self.model.sub.count) {
        if (self.model.tagHeight != height) {
            self.model.tagHeight = height;
            self.tagViewHeightConstraint.constant = height;
        }
    }else {
        self.tagViewHeightConstraint.constant = 0.f;
    }
}

- (void)handleListData {
    __block NSInteger showNumber = 0;
    [self.model.sub enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionarySecondCategoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isSelected) {
            showNumber = idx;
        }
    }];
    KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel = self.model.sub[showNumber];
    if (secondCategoryModel.thirdCategoryModel) {
        self.array = secondCategoryModel.thirdCategoryModel.data;
        [self.collectionView reloadData];
    }else {
        [self requestWithID:secondCategoryModel.classId firstCategoryModel:self.model secondCategoryModel:secondCategoryModel];
    }
}

- (void)requestWithID:(NSString *)classID firstCategoryModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)firstCategoryModel secondCategoryModel:(KSWordBookAuthorityDictionarySecondCategoryModel *)secondCategoryModel {
    __weak typeof(self) weakSelf = self;
}

- (void)didSelectWithModel:(KSWordBookAuthorityDictionarySecondCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    if (model.thirdCategoryModel) {
        self.array = model.thirdCategoryModel.data;
        [self.collectionView reloadData];
    }else {

    }
}

- (void)configureCollectionView {
    self.backgroundColor = kWhiteColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];;
//    self.collectionView = collectionView;
    _collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KSHeritageDictionaryListCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"KSHeritageDictionaryListCollectionViewCell"];
//    [self addSubview:self.collectionView];
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
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

