//
//  KSHeritageDictionaryListTagView.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSHeritageDictionaryListTagView.h"
#import "KSHeritageDictionaryListTagCollectionViewCell.h"
#import "KSTagFlowLayout.h"
#import "KSHeritageDictionaryModel.h"

@interface KSHeritageDictionaryListTagView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic,assign,readwrite,getter = getHeight) CGFloat cardHeight;
@end
static NSString * cellIdentifier = @"KSHeritageDictionaryListTagCollectionViewCell";

@implementation KSHeritageDictionaryListTagView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configSubViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
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
- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model {
    _model = model;
    [self.collectionView reloadData];
}

- (void)configSubViews {
    KSTagFlowLayout *flowLayout = [[KSTagFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView = collectionView;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = kWhiteColor;
    flowLayout.estimatedItemSize = CGSizeMake(0, 0);
    [self.collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
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
    KSHeritageDictionaryListTagCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    KSWordBookAuthorityDictionarySecondCategoryModel *model = self.model.sub[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    KSWordBookAuthorityDictionarySecondCategoryModel *model = self.model.sub[indexPath.row];
    NSString *str = model.name;
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    size.height = 35;
    size.width += 30;
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.model.sub enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionarySecondCategoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.isSelected = NO;
    }];
    KSWordBookAuthorityDictionarySecondCategoryModel *model = self.model.sub[indexPath.row];
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
