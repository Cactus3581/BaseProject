//
//  BPTopCategoryListTagView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryListTagView.h"
#import "BPTopCategoryListTagCollectionViewCell.h"
#import "BPTopCategoryTagFlowLayout.h"
#import "BPTopCategoryModel.h"

@interface BPTopCategoryListTagView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic,assign,readwrite,getter = getHeight) CGFloat cardHeight;
@end
static NSString * cellIdentifier = @"BPTopCategoryListTagCollectionViewCell";

@implementation BPTopCategoryListTagView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeSubViews];
    }
    return self;
}

//KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(object == _collectionView && [keyPath isEqualToString:@"contentSize"]) {
        CGSize size = _collectionView.contentSize;
        if (_delegate && [_delegate respondsToSelector:@selector(getHeight:)]) {
            [_delegate getHeight:size.height];
        }
    }
}

- (CGFloat)getHeight {
    [self.collectionView layoutIfNeeded];
    return self.collectionView.contentSize.height;

}
- (void)setModel:(BPTopCategoryFirstCategoryModel *)model {
    _model = model;
    [self.collectionView reloadData];
}

- (void)initializeSubViews {
    BPTopCategoryTagFlowLayout *flowLayout = [[BPTopCategoryTagFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView = collectionView;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = kWhiteColor;
    flowLayout.estimatedItemSize = CGSizeMake(0, 0);
    [self.collectionView registerNib:[BPTopCategoryListTagCollectionViewCell bp_loadNib] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(0);
        make.trailing.equalTo(self).offset(0);
        make.top.bottom.equalTo(self);
    }];
    [_collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.model.sub.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPTopCategoryListTagCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    BPTopCategorySecondCategoryModel *model = self.model.sub[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPTopCategorySecondCategoryModel *model = self.model.sub[indexPath.row];
    NSString *str = model.name;
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    size.height = 35;
    size.width += 30;
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.model.sub enumerateObjectsUsingBlock:^(BPTopCategorySecondCategoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.isSelected = NO;
    }];
    BPTopCategorySecondCategoryModel *model = self.model.sub[indexPath.row];
    model.isSelected = YES;
    [self.collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectWithModel:indexPath:)]) {
        [_delegate didSelectWithModel:model indexPath:indexPath];
    }
}

- (void)dealloc {
    [_collectionView removeObserver:self forKeyPath:@"contentSize"];
}

@end
