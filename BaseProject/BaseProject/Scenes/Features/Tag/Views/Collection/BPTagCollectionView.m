//
//  BPTagCollectionView.m
//  BaseProject
//
//  Created by Ryan on 2018/5/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagCollectionView.h"
#import "BPTagCollectionViewFlowLayout.h"
#import "BPTagCollectionViewCell.h"

@interface BPTagCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) UICollectionView *collectionView;
@property (nonatomic,assign,readwrite,getter = getHeight) CGFloat cardHeight;
@end

static NSString * cellIdentifier = @"BPTagCollectionViewCell";

@implementation BPTagCollectionView

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

- (void)setTitlesArray:(NSArray<NSString *> *)titlesArray {
    _titlesArray = titlesArray;
    [self.collectionView reloadData];
}

- (void)initializeSubViews {
    BPTagCollectionViewFlowLayout *flowLayout = [[BPTagCollectionViewFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView = collectionView;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = self.backgroundColor;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[BPTagCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  self.titlesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPTagCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.text = self.titlesArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [self.titlesArray[indexPath.row] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    size.height = 30;
    size.width += 30;
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView reloadData];
    if (_delegate && [_delegate respondsToSelector:@selector(tagCollectionView:didSelectRowAtIndex:)]) {
        [_delegate tagCollectionView:self didSelectRowAtIndex:indexPath.row];
    }
}

#pragma mark - 获取collectionView的contentSize 方法1
//KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(object == _collectionView && [keyPath isEqualToString:@"contentSize"]) {
        CGSize size = _collectionView.contentSize;
        if (_delegate && [_delegate respondsToSelector:@selector(getHeight:)]) {
            [_delegate getHeight:size.height];
        }
    }
}

#pragma mark - 获取collectionView的contentSize 方法2
- (CGFloat)getHeight {
    //方法1
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        // 刷新完成
        if (_delegate && [_delegate respondsToSelector:@selector(getHeight:)]) {
//            [_delegate getHeight:self.collectionView.contentSize.height];
        }
    });
    
    //方法2
    /*
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    //刷新完成
    return self.collectionView.contentSize.height;
     */
    return self.collectionView.contentSize.height;
}

- (void)dealloc {
    [_collectionView removeObserver:self forKeyPath:@"contentSize"];
}

@end
