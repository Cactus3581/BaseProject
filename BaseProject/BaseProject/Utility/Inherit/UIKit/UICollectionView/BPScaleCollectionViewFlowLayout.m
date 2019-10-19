//
//  BPScaleCollectionViewFlowLayout.m
//  BaseProject
//
//  Created by Ryan on 2017/11/27.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPScaleCollectionViewFlowLayout.h"

@implementation BPScaleCollectionViewFlowLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    UICollectionView *collectionView = [self collectionView];
    UIEdgeInsets insets = [collectionView contentInset];
    CGPoint offset = [collectionView contentOffset];
    CGFloat minY = -insets.top;
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    if (offset.y < minY) {
        CGSize  headerSize = [self headerReferenceSize];
        CGFloat deltaY = fabsf(offset.y - minY);
        for (UICollectionViewLayoutAttributes *attrs in attributes) {
            if ([attrs representedElementKind] == UICollectionElementKindSectionHeader) {
                CGRect headerRect = [attrs frame];
                headerRect.size.height = MAX(minY, headerSize.height + deltaY);
                headerRect.origin.y = headerRect.origin.y - deltaY;
                [attrs setFrame:headerRect];
                break;
            }
        }
    }
    return attributes;
}

@end
