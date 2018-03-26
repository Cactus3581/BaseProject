//
//  BPNSThread.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/19.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPNSThread : NSObject

@end

@interface BPNSThreadTimer : NSObject
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@interface BPNSThreadTimerRunloop : NSObject

@end


