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

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    BPLog(@"width = %.2f",self.collectionViewContentSize.width);

    for(int i = 0; i < [attributes count]; i++) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes1 = attributes[i];
        CGRect frame1 = currentLayoutAttributes1.frame;
        
        BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(frame1));
        if (i==0) {
            UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 5;
            currentLayoutAttributes.frame = frame;
            BPLog(@"NSStringFromCGRect1 = %@",NSStringFromCGRect(frame));
            continue;
        }
        
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes    = attributes[i - 1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = 5;
        
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }else{
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 5;
            currentLayoutAttributes.frame = frame;
        }
        
//        UICollectionViewLayoutAttributes *currentLayoutAttributes1 = attributes[i];
//        CGRect frame1 = currentLayoutAttributes1.frame;
//
//        BPLog(@"NSStringFromCGRect = %@",NSStringFromCGRect(frame1));
    }

    return attributes;
}

//生成对应的item Attributes
//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
//
//    return attributes;
//}
@end
