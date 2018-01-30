//
//  BPVolumeWaverViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPVolumeWaverViewController.h"
#import "BPVolumeWaverView.h"
#import <AVFoundation/AVFoundation.h>
#import "NSTimer+BPUnRetain.h"
#import "NSTimer+BPAdd.h"
#import "CADisplayLink+BPAdd.h"

@interface BPVolumeWaverViewController ()
@property (nonatomic, strong) BPVolumeWaverView *voiceWaveView;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL removeWaver;

@end

@implementation BPVolumeWaverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupRecorder];
//    [self config1];
//    [self config2];
    [self displayLink];

}
- (void)displayLink {
    __weak typeof (self) weakSelf = self;
    __block NSInteger timers  = 0;
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithExecuteBlock:^(CADisplayLink *displayLink) {
        NSLog(@"%d",self.removeWaver);
        timers ++;
        if (timers > 1000) {
            [displayLink invalidate];
        }
    }];
    //CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(invokeWaveCallback)];
//    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)configAutoresizingMask {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    view.backgroundColor = kLightGrayColor;
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:view];
}

- (void)config2 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_voiceWaveView stopVoiceWaveWithShowLoadingViewCallback:^{
            [_voiceWaveView secondAnaimation];
        }];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_voiceWaveView stopSecondAnaimation];
            [_voiceWaveView removeFromSuperview];
            _removeWaver = YES;
        });
    });
}

- (void)config1 {
    [self.view addSubview:self.voiceWaveView];
    [self.voiceWaveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(54));
    }];
    [self.voiceWaveView startVoiceWave];

    __weak typeof (self) weakSelf = self;
    
//    NSTimer *timer = [NSTimer bp_scheduledTimerWithTimeInterval:0.1 block:^{
//        if (!weakSelf.removeWaver) {
//            [weakSelf updateVolume];
//        }else {
//            [timer invalidate];
//        }
//    } repeats:YES];
    
//    self.timer = timer;
    
//    self.timer = [NSTimer bp_scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer *timer) {
//
////        BPLog(@"%d",weakSelf.removeWaver);
//    }];
}

- (void)updateVolume {
    [self.recorder updateMeters];
    CGFloat normalizedValue = pow (10, [self.recorder averagePowerForChannel:0] / 20);
    [_voiceWaveView changeVolume:normalizedValue];
}

-(void)setupRecorder {
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = @{AVSampleRateKey:          [NSNumber numberWithFloat: 44100.0],
                               AVFormatIDKey:            [NSNumber numberWithInt: kAudioFormatAppleLossless],
                               AVNumberOfChannelsKey:    [NSNumber numberWithInt: 2],
                               AVEncoderAudioQualityKey: [NSNumber numberWithInt: AVAudioQualityMin]};
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if(error) {
        NSLog(@"Ups, could not create recorder %@", error);
        return;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
        NSLog(@"Error setting category: %@", [error description]);
    }
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder record];
}

#pragma mark - getters
- (BPVolumeWaverView *)voiceWaveView {
    if (!_voiceWaveView) {
        _voiceWaveView = [[BPVolumeWaverView alloc] init];
    }
    return _voiceWaveView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _removeWaver = YES;
    [_timer invalidate];
    _timer = nil;
    [_voiceWaveView removeFromSuperview];
}

@end
