//
//  BPGestureRecognizerCollectionView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGestureRecognizerCollectionView.h"

@implementation BPGestureRecognizerCollectionView

// 让CollectionView能同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
