//
//  CALayer+BPMask.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/3/14.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (BPMask)

- (CALayer *)configMask:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
