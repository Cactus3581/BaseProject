//
//  BPVolumeQueueHelper.m
//  BaseProject
//
//  Created by Ryan on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPVolumeQueueHelper.h"

#define minVolume 0.05

@interface BPVolumeQueueHelper()
@property (nonatomic, strong) NSMutableArray *volumeArray;
@end

@implementation BPVolumeQueueHelper

- (instancetype)init {
    self = [super init];
    if (self) {
        self.volumeArray = [NSMutableArray array];
    }
    return self;
}

- (void)pushVolume:(CGFloat)volume {
    if (volume >= minVolume) {
        [self.volumeArray addObject:[NSNumber numberWithFloat:volume]];
    }
}

- (void)pushVolumeWithArray:(NSArray *)array {
    if (BPValidateArray(array).count > 0) {
        for (NSInteger i = 0; i < array.count; i++) {
            CGFloat volume = [array[i] floatValue];
            [self pushVolume:volume];
        }
    }
}

- (CGFloat)popVolume {
    CGFloat volume = -10;
    if (BPValidateMuArray(self.volumeArray).count > 0) {
        if ([BPValidateMuArray(self.volumeArray) firstObject]) {
            volume = [[BPValidateMuArray(self.volumeArray) firstObject] floatValue];
            [self.volumeArray removeObjectAtIndex:0];
        }
    }
    return volume;
}

- (void)cleanQueue {
    if (_volumeArray) {
        [self.volumeArray removeAllObjects];
    }
}

- (NSMutableArray *)volumeArray {
    if (!_volumeArray) {
        _volumeArray = [NSMutableArray array];
    }
    return _volumeArray;
}

@end
