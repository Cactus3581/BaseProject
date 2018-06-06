//
//  BPMultiLevelCatalogueModel+BPHeight.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMultiLevelCatalogueModel+BPHeight.h"
#import <objc/runtime.h>

// 定义关联的key
static const char *headerHeightKey = "headerHeight";
static const char *cellHeightKey = "cellHeight";

@implementation BPMultiLevelCatalogueModel3rd (BPCardHeight)

- (CGFloat)cellHeight {
    NSNumber *height = objc_getAssociatedObject(self, cellHeightKey);
    return height.floatValue;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    objc_setAssociatedObject(self, cellHeightKey, @(cellHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation BPMultiLevelCatalogueModel2nd (BPCardHeight)

- (CGFloat)headerHeight {
    NSNumber *height = objc_getAssociatedObject(self, headerHeightKey);
    return height.floatValue;
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    objc_setAssociatedObject(self, headerHeightKey, @(headerHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cellHeight {
    NSNumber *height = objc_getAssociatedObject(self, cellHeightKey);
    return height.floatValue;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    objc_setAssociatedObject(self, cellHeightKey, @(cellHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation BPMultiLevelCatalogueModel1st (BPCardHeight)

- (CGFloat)headerHeight {
    NSNumber *height = objc_getAssociatedObject(self, headerHeightKey);
    return height.floatValue;
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    objc_setAssociatedObject(self, headerHeightKey, @(headerHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cellHeight {
    NSNumber *height = objc_getAssociatedObject(self, cellHeightKey);
    return height.floatValue;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    objc_setAssociatedObject(self, cellHeightKey, @(cellHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation BPMultiLevelCatalogueModel (BPCardHeight)

@end
