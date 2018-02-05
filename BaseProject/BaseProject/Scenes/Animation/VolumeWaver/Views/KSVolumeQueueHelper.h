//
//  KSVolumeQueueHelper.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSVolumeQueueHelper : NSObject

- (void)pushVolume:(CGFloat)volume;

- (void)pushVolumeWithArray:(NSArray *)array;

- (CGFloat)popVolume;

- (void)cleanQueue;

@end
