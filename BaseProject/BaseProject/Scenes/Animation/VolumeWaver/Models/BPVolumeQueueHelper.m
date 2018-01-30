//
//  BPVolumeQueueHelper.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPVolumeQueueHelper.h"

#define minVolume 0.05

@interface BPVolumeQueueHelper()

@property (nonatomic, strong) NSMutableArray *volumeArray;

@end

@implementation BPVolumeQueueHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.volumeArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)pushVolume:(CGFloat)volume
{
    if (volume >= minVolume) {
        [_volumeArray addObject:[NSNumber numberWithFloat:volume]];
    }
}

- (void)pushVolumeWithArray:(NSArray *)array
{
    if (array.count > 0) {
        for (NSInteger i = 0; i < array.count; i++) {
            CGFloat volume = [array[i] floatValue];
            [self pushVolume:volume];
        }
    }
}

- (CGFloat)popVolume
{
    CGFloat volume = -10;
    if (_volumeArray.count > 0) {
        volume = [[_volumeArray firstObject] floatValue];
        [_volumeArray removeObjectAtIndex:0];
    }
    
    return volume;
}

- (void)cleanQueue
{
    if (_volumeArray) {
        [_volumeArray removeAllObjects];
    }
}

@end

