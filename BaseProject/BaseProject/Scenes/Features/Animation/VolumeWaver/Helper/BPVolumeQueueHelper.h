//
//  BPVolumeQueueHelper.h
//  BaseProject
//
//  Created by Ryan on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVolumeQueueHelper : NSObject

- (void)pushVolume:(CGFloat)volume;

- (void)pushVolumeWithArray:(NSArray *)array;

- (CGFloat)popVolume;

- (void)cleanQueue;

@end
