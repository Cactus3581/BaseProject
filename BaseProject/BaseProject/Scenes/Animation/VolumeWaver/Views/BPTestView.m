//
//  BPTestView.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTestView.h"


@interface BPTestView ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@end

static NSRunLoop *_voiceWaveRunLoop;

@implementation BPTestView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self startVoiceWaveThread];
    }
    return self;
}


#pragma mark - 开启子线程准备进行异步绘制
- (NSThread *)startVoiceWaveThread {
    self.backgroundColor = kWhiteColor;
    static NSThread *_voiceWaveThread = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _voiceWaveThread =
        [[NSThread alloc] initWithTarget:self
                                selector:@selector(voiceWaveThreadEntryPoint:)
                                  object:nil];
        [_voiceWaveThread start];
    });
    return _voiceWaveThread;
}

- (void)voiceWaveThreadEntryPoint:(id)__unused object {
    @autoreleasepool {
        [[NSThread currentThread] setName:@"bpVolumeWaver_thread"];
        _voiceWaveRunLoop = [NSRunLoop currentRunLoop];
        [_voiceWaveRunLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [_voiceWaveRunLoop run];
    }
}


#pragma mark - 开启定时器，开始进行波浪动画（通过时时更新异步绘制来实现的）
- (void)startVoiceWave {
    
    if (_voiceWaveRunLoop) {
        [self.displayLink invalidate];
        __weak typeof (self) weakSelf = self;
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
        [self.displayLink addToRunLoop:_voiceWaveRunLoop forMode:NSRunLoopCommonModes];
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_voiceWaveRunLoop) {
                [self.displayLink invalidate];
                __weak typeof (self) weakSelf = self;
                self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
                [self.displayLink addToRunLoop:_voiceWaveRunLoop forMode:NSRunLoopCommonModes];
            }
        });
    }
}

#pragma mark - 定时器方法：时时绘制
- (void)invokeWaveCallback {
    [self updateMeters];
}

#pragma mark - 外部通过接口实现数据更新
- (void)changeVolume:(CGFloat)volume {
    @synchronized (self) {
        BPLog(@"changeVolume %d",[NSThread isMainThread]);
    }
}

#pragma mark - 定时器方法：时时绘制：updateMeters
- (void)updateMeters {
    BPLog(@"updateMeters %d",[NSThread isMainThread]);
}

@end
