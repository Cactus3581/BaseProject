//
//  BPVolumeQueueHelper.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPVolumeQueueHelper : NSObject

- (void)pushVolume:(CGFloat)volume;

- (void)pushVolumeWithArray:(NSArray *)array;

- (CGFloat)popVolume;

- (void)cleanQueue;

@end
