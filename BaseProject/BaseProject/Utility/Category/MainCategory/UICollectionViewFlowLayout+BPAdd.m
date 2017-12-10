//
//  UICollectionViewFlowLayout+BPAdd.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
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
