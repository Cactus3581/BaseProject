//
//  CADisplayLink+BPAdd.h
//  BaseProject
//
//  Created by Ryan on 2018/1/30.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class CADisplayLink;

typedef void(^displayLinkBlock) (CADisplayLink *displayLink);

@interface CADisplayLink (BPAdd)

@property (nonatomic,copy)displayLinkBlock executeBlock;

+ (CADisplayLink *)displayLinkWithExecuteBlock:(displayLinkBlock)block;
+ (CADisplayLink *)displayLinkWithRunLoop:(NSRunLoop *)runloop executeBlock:(displayLinkBlock)block;

@end
