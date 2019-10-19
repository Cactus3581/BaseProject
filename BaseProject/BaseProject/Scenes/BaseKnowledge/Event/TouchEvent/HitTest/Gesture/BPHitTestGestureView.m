//
//  BPHitTestGestureView.m
//  BaseProject
//
//  Created by Ryan on 2019/7/6.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestGestureView.h"

@interface BPHitTestGestureView()

@end


@implementation BPHitTestGestureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tap {
    BPLog(@"SubView tap");
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    BPLog(@"SubView Began");
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    BPLog(@"SubView Move");
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    BPLog(@"SubView End");
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    BPLog(@"SubView Cancelled");
//}

@end
