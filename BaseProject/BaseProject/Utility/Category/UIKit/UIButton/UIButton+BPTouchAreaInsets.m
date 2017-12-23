//
// The MIT License (MIT)
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <objc/runtime.h>
#import "UIButton+BPTouchAreaInsets.h"

@implementation UIButton (BPTouchAreaInsets)

- (UIEdgeInsets)bp_touchAreaInsets
{
	return [objc_getAssociatedObject(self, @selector(bp_touchAreaInsets)) UIEdgeInsetsValue];
}
/**
 *  @brief  设置按钮额外热区
 */
- (void)setBp_touchAreaInsets:(UIEdgeInsets)touchAreaInsets
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
	objc_setAssociatedObject(self, @selector(bp_touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIEdgeInsets touchAreaInsets = self.bp_touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
	return CGRectContainsPoint(bounds, point);
}

@end
