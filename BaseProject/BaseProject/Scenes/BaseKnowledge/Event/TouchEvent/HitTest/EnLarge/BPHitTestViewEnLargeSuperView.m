//
//  BPHitTestViewC.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/22.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestViewEnLargeSuperView.h"

static CGFloat enlargeInset = -50;

@implementation BPHitTestViewEnLargeSuperView

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
    BPLog(@"边界之外可以响应");
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect bounds = CGRectInset(self.bounds,enlargeInset,enlargeInset);//注意这里是负数，扩大了之前的bounds的范围
    
    return CGRectContainsPoint(bounds, point);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"Super");
}

@end
