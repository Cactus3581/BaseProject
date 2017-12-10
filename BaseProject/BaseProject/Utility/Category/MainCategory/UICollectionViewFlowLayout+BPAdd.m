//
//  UICollectionViewFlowLayout+BPAdd.m
//  BPCurrencyExchange
//
//  Created by wazrx on 16/3/6.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UICollectionViewFlowLayout+BPAdd.h"
#import "NSObject+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UICollectionViewFlowLayout_BPAdd)

@implementation UICollectionViewFlowLayout (BPAdd)

+(void)load{
    [self bp_swizzleInstanceMethod:@selector(prepareLayout) with:@selector(_bp_prepareLayout)];
}

- (void)setFullItem:(BOOL)bp_fullItem{
    [self bp_setAssociateValue:@(bp_fullItem) withKey:"bp_fullItem"];
}

- (BOOL)fullItem{
    BOOL test = [[self bp_getAssociatedValueForKey:"bp_fullItem"] boolValue];
    return test;
}

- (void)_bp_prepareLayout{
    [self _bp_prepareLayout];
    if (self.fullItem) {
        self.itemSize = self.collectionView.bounds.size;
    }
}

@end
