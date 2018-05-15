//
//  BPTagCollectionView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagCollectionView.h"
#import "BPTagCell.h"
#import "BPCollectionViewFlowLayout.h"

@interface BPTagCollectionView() <UICollectionViewDataSource, UICollectionViewDelegateLeftAlignedLayout>

@end

@implementation BPTagCollectionView {
    NSIndexPath *_lastChoose;
    NSInteger _chooseNumber;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (!layout) {
        BPCollectionViewFlowLayout *flowLayout = [[BPCollectionViewFlowLayout alloc] init];
        layout = flowLayout;
    }
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.scrollEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.allowsMultipleSelection = YES;
        _chooseNumber = 0;
        self.delegate = self;
        self.dataSource = self;
        self.maximumNumber = NSIntegerMax;
        self.backgroundColor = [UIColor clearColor];
        [self registerClass:[BPTagCell class] forCellWithReuseIdentifier:[BPTagCell cellReuseIdentifier]];
    }
    return self;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tagArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BPTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[BPTagCell cellReuseIdentifier] forIndexPath:indexPath];
    cell.model = _tagArray[indexPath.row];
    if (cell.model.isChoose) {
        _lastChoose = indexPath;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BPTagCell *cell = (BPTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (((BPTagModel *)_tagArray[indexPath.row]).isChoose) {
        [self collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
        return;
    }
    
    if (_chooseNumber < _maximumNumber) {
        _chooseNumber ++;
        ((BPTagModel *)_tagArray[indexPath.row]).isChoose = YES;
        cell.model = _tagArray[indexPath.row];
        [self switchTag:cell.model];
    } else {
        if (_maximumNumber == 1) {
            [self collectionView:collectionView didDeselectItemAtIndexPath:_lastChoose];
            _chooseNumber ++;
            ((BPTagModel *)_tagArray[indexPath.row]).isChoose = YES;
            cell.model = _tagArray[indexPath.row];
            [self switchTag:cell.model];
            return;
        }
        NSLog(@"最多选择%li个标签", (long)_maximumNumber);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    BPTagCell *cell = (BPTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (((BPTagModel *)_tagArray[indexPath.row]).isChoose) {
        ((BPTagModel *)_tagArray[indexPath.row]).isChoose = NO;
        _chooseNumber --;
        cell.model = _tagArray[indexPath.row];
        [self disSwitchTag:cell.model];
        
    } else {
        if  (self.allowsMultipleSelection) {
            [self collectionView:collectionView didSelectItemAtIndexPath:indexPath];
        }
        return;
    }
}

- (void)setMaximumNumber:(NSInteger)maximumNumber {
    _maximumNumber = maximumNumber;
    if (maximumNumber == 1) {
        self.allowsMultipleSelection = NO;
    }
}

- (void)setTagArray:(NSArray *)tagArray {
    _tagArray = tagArray;
    _chooseNumber = 0;
    for (int i = 0; i < tagArray.count; i++) {
        if (((BPTagModel *)_tagArray[i]).isChoose) {
            _chooseNumber ++;
        }
    }
}

- (void)switchTag:(BPTagModel *)tagModel {
    if (self.tagDelegate && [self.tagDelegate respondsToSelector:@selector(switchTag:)]) {
        [self.tagDelegate switchTag:tagModel];
    }
}

- (void)disSwitchTag:(BPTagModel *)tagModel {
    if (self.tagDelegate && [self.tagDelegate respondsToSelector:@selector(disSwitchTag:)]) {
        [self.tagDelegate disSwitchTag:tagModel];
    }
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [((BPTagModel *)_tagArray[indexPath.row]).name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return CGSizeMake(pixel(size.width + 16), 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 12;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(12, 12, 12, 12);
}

extern float pixel(float num) {
    
    float unit = 1.0 / [UIScreen mainScreen].scale;
    double remain = fmod(num, unit);
    return num - remain + (remain >= unit / 2.0? unit: 0);
}

@end

