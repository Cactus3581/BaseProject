//
//  UICollectionViewFlowLayout+BPFullItem.m
//  BaseProject
//
//  Created by xiaruzhen on 15/12/18.
//  Copyright © 2015年 cactus. All rights reserved.
//

#import "UICollectionViewFlowLayout+BPFullItem.h"
#import <objc/runtime.h>

@implementation UICollectionViewFlowLayout (BPFullItem)

- (void)setFullItem:(BOOL)fullItem{
    objc_setAssociatedObject(self, "fullItem", @(fullItem), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)fullItem{
    return [objc_getAssociatedObject(self, "fullItem") intValue];
}

- (void)prepareLayout{
    if (self.fullItem) {
        self.itemSize = self.collectionView.bounds.size;
    }
    [super prepareLayout];
}

@end
