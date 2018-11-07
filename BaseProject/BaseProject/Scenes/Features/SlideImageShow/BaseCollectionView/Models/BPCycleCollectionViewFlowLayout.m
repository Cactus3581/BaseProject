//
//  BPCycleCollectionViewFlowLayout.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/10/19.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "BPCycleCollectionViewFlowLayout.h"

@implementation BPCycleCollectionViewFlowLayout
//重写方法
// 这个方法返回所有的布局所需对象,瀑布流也可以重写这个方法实现.
//1.返回rect中的所有的元素的布局属性
//2.返回的是包含UICollectionViewLayoutAttributes的NSArray
//3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：
//1)layoutAttributesForCellWithIndexPath:
//2)layoutAttributesForSupplementaryViewOfKind:withIndexPath:
//3)layoutAttributesForDecorationViewOfKind:withIndexPath:

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    // 1.获取cell对应的attributes对象
    NSArray* arrayAttrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    return arrayAttrs;
}

/*!
 *  多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

/// 滑动停止
///
/// @param proposedContentOffset 当手指滚动完毕后，自然情况下根据“惯性”，会停留的位置
/// @param velocity              速率,周率
///
/// @return 人为要让它停留的位置
//- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
//    // 1.计算中心点位置
//    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
//
//    // 2.计算可视化区域
//    CGFloat visibleX = proposedContentOffset.x;
//    CGFloat visibleY = proposedContentOffset.y;
//    CGFloat visibleW = self.collectionView.bounds.size.width;
//    CGFloat visibleH = self.collectionView.bounds.size.height;
//    CGRect visibleRect = CGRectMake(visibleX, visibleY, visibleW, visibleH);
//
//    // 3.获取可视区域的cell的attribute对象
//    NSArray *attrs = [self layoutAttributesForElementsInRect:visibleRect];
//
//    // 4.比较出最小的偏移
//    int min_idx = 0;
//    UICollectionViewLayoutAttributes *min_attr = attrs[min_idx];
//
//    // 5.循环比较出最小的
//    for (int i = 1; i< attrs.count; i++){
//        // 5.1min_attr和中心点的距离
//        CGFloat distance1 = ABS(min_attr.center.x - centerX);
//
//        // 5.2当前循环的attr和中心点的距离
//        UICollectionViewLayoutAttributes *currentAttr = attrs[i];
//        CGFloat distance2 = ABS(currentAttr.center.x - centerX);
//
//        if (distance2 < distance1) {
//            min_idx = i;
//            min_attr = currentAttr;
//        }
//    }
//    // 6.计算出最小的偏移值
//    CGFloat offsetX = min_attr.center.x - centerX;
//
//    return CGPointMake(proposedContentOffset.x + offsetX, proposedContentOffset.y);
//}

@end

