//
//  KSTagFlowLayout.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSTagFlowLayout.h"

static CGFloat spacing = 10.f;
static CGFloat lineSpacing = 10.f;
static CGFloat inset = 15.f;

@interface KSTagFlowLayout ()
@property(nonatomic,strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributeArr;
@end

@implementation KSTagFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(inset, 0, 2, 0);
    //minimumLineSpacing 设置最小行间距
    //如果想设置间隔的话，必须要设置最小间隔跟最大间隔一样大小。
    self.minimumInteritemSpacing = spacing; //横向间距
    self.minimumLineSpacing = lineSpacing;//纵向间距
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for(int i = 0; i < [attributes count]; i++) {
        if (i == 0) {
            UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = spacing;
            currentLayoutAttributes.frame = frame;
            continue;
        }
        //当前attributes
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        //上一个attributes
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i-1];
        //我们想设置的最大间距，可根据需要改
        NSInteger maximumSpacing = spacing;
        //前一个cell的最右边
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前一个cell的最右边加上我们想要的间距加上当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
        //不加这个判断的后果是，UICollectionView只显示一行，原因是下面所有cell的x值都被加到第一行最后一个元素的后面了
        if(origin + maximumSpacing + currentLayoutAttributes.frame.size.width < self.collectionViewContentSize.width) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + maximumSpacing;
            currentLayoutAttributes.frame = frame;
        }else {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = spacing;
            currentLayoutAttributes.frame = frame;
        }
    }
    return attributes;
}

@end
