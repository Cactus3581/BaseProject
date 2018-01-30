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
@property (nonatomic, strong) BPVolumeWaverView *voiceWaveView;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation BPVolumeWaverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRecorder];
    [self config1];
    [self config2];

}

- (void)configAutoresizingMask {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    view.backgroundColor = kLightGrayColor;
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:view];
}

- (void)config2 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_voiceWaveView stopVoiceWaveWithShowLoadingViewCallback:^{
//            [_voiceWaveView secondAnaimation];
//        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [_voiceWaveView stopSecondAnaimation];
//            [_voiceWaveView removeFromSuperview];
        });
    });
}

- (void)config1 {
    [self.view addSubview:self.voiceWaveView];
    [self.voiceWaveView startVoiceWave];
    weakify(self);
    self.timer = [NSTimer bp_scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer *timer) {
        strongify(self);
        [self updateVolume];
    }];
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
        _voiceWaveView = [[BPVolumeWaverView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 54)];
    }
    return _voiceWaveView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
}

@end
