//
//  BPHitTestViewB.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/22.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPHitTestViewBaseProcessView.h"

@interface BPHitTestViewBaseProcessView()

@end


@implementation BPHitTestViewBaseProcessView

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BPLog(@"SubView Began");
}

@end
