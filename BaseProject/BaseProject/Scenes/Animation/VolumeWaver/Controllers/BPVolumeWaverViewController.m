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

@interface BPVolumeWaverViewController ()
@property (nonatomic, weak) BPVolumeWaverView *voiceWaveView;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation BPVolumeWaverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatRecorder];
    [self creatTimer];
    [self stop];
}

- (void)leftBarButtonItemClickAction:(id)sender {
    [_voiceWaveView removeFromSuperview];
    _voiceWaveView = nil;
    [super leftBarButtonItemClickAction:sender];
}

- (void)stop {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

//        [self.voiceWaveView stopVoiceWaveWithCallback:^{
//
//        }];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_voiceWaveView stopSecondAnaimation];
//            [_voiceWaveView removeFromSuperview];
//            _removeWaver = YES;
//        });
    });
}

- (void)creatTimer {
//    [self.voiceWaveView startVoiceWave];
    __weak typeof (self) weakSelf = self;
    self.timer = [NSTimer bp_scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer *timer) {
        [weakSelf updateVolume];
    }];
}

- (void)updateVolume {
    [self.recorder updateMeters];
    CGFloat normalizedValue = pow (10, [self.recorder averagePowerForChannel:0] / 20);
    self.voiceWaveView.value = normalizedValue;
}

#pragma mark - getters
- (BPVolumeWaverView *)voiceWaveView {
    if (!_voiceWaveView) {
        BPVolumeWaverView *voiceWaveView = [[BPVolumeWaverView alloc] init];
        _voiceWaveView = voiceWaveView;
        _voiceWaveView.backgroundColor = kLightGrayColor;
        [self.view addSubview:_voiceWaveView];
        [_voiceWaveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.centerY.equalTo(self.view);
            make.height.equalTo(@60);
        }];
        
    }
    return _voiceWaveView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
    [_voiceWaveView removeFromSuperview];
}

-(void)creatRecorder {
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    NSDictionary *settings = @{AVSampleRateKey:          [NSNumber numberWithFloat: 44100.0],
                               AVFormatIDKey:            [NSNumber numberWithInt: kAudioFormatAppleLossless],
                               AVNumberOfChannelsKey:    [NSNumber numberWithInt: 2],
                               AVEncoderAudioQualityKey: [NSNumber numberWithInt: AVAudioQualityMin]};
    NSError *error;
    self.recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if(error) {
        return;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (error) {
    }
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder record];
}

@end
