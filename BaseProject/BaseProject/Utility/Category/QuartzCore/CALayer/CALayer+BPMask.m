//
//  CALayer+BPMask.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/3/14.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "CALayer+BPMask.h"

@implementation CALayer (BPMask)

- (CALayer *)configMask:(CGRect)rect {
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = rect;
    maskLayer.contents = (id)[UIImage imageNamed:@"popview_anchor_arrow"].CGImage;
    maskLayer.contentsGravity = kCAGravityResizeAspect;
    maskLayer.backgroundColor = kRedColor.CGColor;
    self.mask = maskLayer;
    return maskLayer;
}

@end
