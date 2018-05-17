//
//  KSHeritageDictionaryListTestCell.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/5/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSHeritageDictionaryListTestCell.h"
#import "KSHeritageDictionaryMacro.h"
#import "KSHeritageDictionaryListCollectionViewCell.h"

@interface KSHeritageDictionaryListTestCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) KSWordBookAuthorityDictionaryFirstCategoryModel *model;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *array;
@end

@implementation KSHeritageDictionaryListTestCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configureCollectionView];
    self.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0f green:(arc4random() % 255) / 255.0f blue:(arc4random() % 255) / 255.0f alpha:1.0];
}

- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    if (!model.sub.count) { //没有tag
       _array = model.thirdCategoryModel.data;
    }else {
        KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel = self.model.sub[0];
        _array = secondCategoryModel.thirdCategoryModel.data;
    }
    [self.collectionView reloadData];
}

#pragma mark - 布局collectionview
- (void)configureCollectionView {
    self.backgroundColor = kWhiteColor;
    //主collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = layout.minimumLineSpacing = 0;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = kWhiteColor;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KSHeritageDictionaryListCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"KSHeritageDictionaryListCollectionViewCell"];
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
