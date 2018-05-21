//
//  BPTagCollectionViewFlowLayout.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/21.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTagCollectionViewFlowLayout.h"
static CGFloat horizontalSpacing = 10.f;
static CGFloat lineSpacing = 10.f;
static CGFloat topInset = 15.f;
static CGFloat bottomInset = 15.f;
static CGFloat leftInset = 15.f;
static CGFloat rightInset = 15.f;

@interface BPTagCollectionViewFlowLayout ()
@property(nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributeArr;
@end

@implementation BPTagCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
    //minimumLineSpacing 设置最小行间距
    //如果想设置间隔的话，必须要设置最小间隔跟最大间隔一样大小。
    self.minimumInteritemSpacing = horizontalSpacing; //横向间距
    self.minimumLineSpacing = lineSpacing;//纵向间距
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSInteger line = 0;
    for(int i = 0; i < [attributes count]; i++) {
        if (i == 0) {
            UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = leftInset;
            frame.origin.y = topInset;
            currentLayoutAttributes.frame = frame;
            continue;
        }
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i-1];
        //前一个cell的最右边
        CGFloat origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        CGRect frame = currentLayoutAttributes.frame;
        //要不要取整。
        if(origin + horizontalSpacing + currentLayoutAttributes.frame.size.width + rightInset < self.collectionViewContentSize.width) {
            frame.origin.x = origin + horizontalSpacing;
            frame.origin.y = prevLayoutAttributes.frame.origin.y;
            currentLayoutAttributes.frame = frame;
        }else {
            //另起一行的第一个
            ++line;
            frame.origin.x = leftInset;
            frame.origin.y = line * frame.size.height + line * horizontalSpacing + topInset;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

@end

