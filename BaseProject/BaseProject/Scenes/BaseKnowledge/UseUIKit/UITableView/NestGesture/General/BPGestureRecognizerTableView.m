//
//  BPGestureRecognizerTableView.m
//  BaseProject
//
//  Created by Ryan on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPGestureRecognizerTableView.h"

@implementation BPGestureRecognizerTableView

// 让tableview能同时响应多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
