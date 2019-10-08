//
//  BPTagFlowLayout.m
//  Collectionview
//
//  Created by xiaruzhen on 2016/12/17.
//  Copyright © 2016年 xiaruzhen. All rights reserved.
//

#import "BPTagFlowLayout.h"

@interface BPTagFlowLayout ()

@property(nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributeArr;

@end


@implementation BPTagFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0);
    //minimumLineSpacing 设置最小行间距
    //如果想设置间隔的话，必须要设置最小间隔跟最大间隔一样大小。
    self.minimumInteritemSpacing = 5.0f;
    self.minimumLineSpacing = 5.0f;
    BPLog(@"%.2f",self.collectionViewContentSize.width);
}

// rect 就是自身的bounds。这个方法为每一个视图元素创建对应的布局对象，存储于数组中并返回
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    BPLog(@"width = %.2f",self.collectionViewContentSize.width);

    for(int i = 0; i < [attributes count]; i++) {
        
        //当前attributes
        UICollectionViewLayoutAttributes *layoutAttributesItem = attributes[i];
        CGRect itemFrame = layoutAttributesItem.frame;
        
        BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(itemFrame));
        if (i == 0) {
            itemFrame.origin.x = 5;
            layoutAttributesItem.frame = itemFrame;
            continue;
        }
        
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributesItem = attributes[i - 1];
        
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 5;
        
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributesItem.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        
        if(origin + maximumSpacing + layoutAttributesItem.frame.size.width < self.collectionViewContentSize.width) {
            
            CGRect frame = layoutAttributesItem.frame;
            frame.origin.x = origin + maximumSpacing;
            layoutAttributesItem.frame = frame;
            
        }else {
            CGRect frame = layoutAttributesItem.frame;
            frame.origin.x = 5;
            layoutAttributesItem.frame = frame;
        }
    }

    return attributes;
}

//生成对应的cell的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *cellAttributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    return cellAttributes;
}

//生成对应的header/footer的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath].copy;
    return attributes;
}

//生成对应的装饰视图的attributes
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath].copy;
    return attributes;
}

// 旋转时，废弃当前布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}

@end
