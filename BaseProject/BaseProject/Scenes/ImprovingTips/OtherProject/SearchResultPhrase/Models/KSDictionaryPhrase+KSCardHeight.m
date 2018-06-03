//
//  KSDictionaryPhrase+KSCardHeight.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSDictionaryPhrase+KSCardHeight.h"
#import <objc/runtime.h>

// 定义关联的key
static const char *headerHeightKey = "headerHeight";
static const char *cellHeightKey = "cellHeight";

@implementation KSDictionarySubItemPhraseJxLj (KSCardHeight)

- (CGFloat)cellHeight {
    NSNumber *height = objc_getAssociatedObject(self, cellHeightKey);
    return height.floatValue;
}

- (void)setCellHeight:(CGFloat)cellHeight {
    objc_setAssociatedObject(self, cellHeightKey, @(cellHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation KSDictionarySubItemPhraseJx (KSCardHeight)

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

@implementation KSDictionarySubItemPhrase (KSCardHeight)

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

@implementation KSDictionaryPhrase (KSCardHeight)

@end
