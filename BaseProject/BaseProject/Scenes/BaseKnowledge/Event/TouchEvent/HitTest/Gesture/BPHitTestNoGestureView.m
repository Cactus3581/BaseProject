//
//  BPHitTestNoGestureView.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/7/7.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestNoGestureView.h"

@interface BPHitTestNoGestureView()

@end


@implementation BPHitTestNoGestureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

#pragma mark - 事件传递：查找第一响应者

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"SubView Began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"SubView Move");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"SubView End");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    BPLog(@"SubView Cancelled");
}

@end
