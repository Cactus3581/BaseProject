//
//  BPHitTestButton.m
//  BaseProject
//
//  Created by Ryan on 2019/7/6.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestButton.h"

@implementation BPHitTestButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        self.userInteractionEnabled = YES;
//        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap {
    BPLog(@"BPTouchButton Tap");
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    BPLog(@"BPTouchButton Began");
//}

//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    BPLog(@"BPTouchButton Move");
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    BPLog(@"BPTouchButton End");
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    BPLog(@"BPTouchButton Cancelled");
//}

@end
