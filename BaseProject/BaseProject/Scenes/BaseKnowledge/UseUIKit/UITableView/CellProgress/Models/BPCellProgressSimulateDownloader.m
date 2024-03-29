//
//  BPCellProgressSimulateDownloader.m
//  BaseProject
//
//  Created by Ryan on 2018/3/9.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCellProgressSimulateDownloader.h"

@interface BPCellProgressSimulateDownloader()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation BPCellProgressSimulateDownloader

- (void)startDownload:(BPCellProgressModel *)model {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(downLoadTimer) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)downLoadTimer {
    static float progress = 0;
    progress += 0.1;
    if (progress > 1.01) {
    } else {
        self.model.progress = progress;
    }
}

@end
