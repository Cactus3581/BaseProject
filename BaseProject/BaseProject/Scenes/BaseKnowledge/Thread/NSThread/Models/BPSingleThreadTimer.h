//
//  BPSingleThreadTimer.h
//  BaseProject
//
//  Created by Ryan on 2018/3/20.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPSingleThreadTimer : NSObject
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

