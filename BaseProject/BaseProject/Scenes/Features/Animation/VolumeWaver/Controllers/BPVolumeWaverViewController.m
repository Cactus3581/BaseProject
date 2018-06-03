//
//  BPVolumeWaverViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPVolumeWaverViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSTimer+BPUnRetain.h"
#import "CADisplayLink+BPAdd.h"

#import "BPNormalVolumeWaverView.h"
#import "BPVolumeWaverView.h"
#import "BPShapeLayerPathWaverView.h"
#import "BPDrawWaverView.h"

@interface BPVolumeWaverViewController ()
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) BPNormalVolumeWaverView *baseWaverView;
@property (nonatomic, weak) BPVolumeWaverView *voiceWaveView;
@property (nonatomic, weak) BPShapeLayerPathWaverView *shapeLayerPathWaverView;
@property (nonatomic, weak) BPDrawWaverView *drawWaverView;
@end

@implementation BPVolumeWaverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatRecorder];
    [self showBaseWaver];
    [self showWaver_path_1];
    [self showWaver_path_2];
    [self showWaverd_draw_1];
    [self showWaverd_draw_2];
    [self creatTimer];
    [self stop];
}

#pragma mark - show methods
- (void)showBaseWaver {
    
}

- (void)showWaver_path_1 {
    [self.voiceWaveView startVoiceWave];
}

- (void)showWaver_path_2 {
    [self.shapeLayerPathWaverView startVoiceWave];
}

- (void)showWaverd_draw_1 {
    [self.drawWaverView startVoiceWave];
}

- (void)showWaverd_draw_2 {
    
}

#pragma mark - 停止
- (void)stop {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.voiceWaveView stopVoiceWaveWithCallback:^{

        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_voiceWaveView removeFromSuperview];
        });
    });
}

#pragma mark - timer
- (void)creatTimer {
    __weak typeof (self) weakSelf = self;
    self.timer = [NSTimer bp_scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer *timer) {
        [weakSelf updateVolume];
    }];
}

- (void)updateVolume {
    [self.recorder updateMeters];
    CGFloat normalizedValue = pow (10, [self.recorder averagePowerForChannel:0] / 20);
    self.baseWaverView.value = normalizedValue;
    self.voiceWaveView.value = normalizedValue;
    [self.shapeLayerPathWaverView changeVolume:normalizedValue];
    self.drawWaverView.value = normalizedValue;
}

#pragma mark - lazy methods
- (BPNormalVolumeWaverView *)baseWaverView {
    if (!_baseWaverView) {
        BPNormalVolumeWaverView *voiceWaveView = [[BPNormalVolumeWaverView alloc] init];
        _baseWaverView = voiceWaveView;
        _baseWaverView.backgroundColor = kLightGrayColor;
        [self.view addSubview:_baseWaverView];
        [_baseWaverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.equalTo(self.view);
            make.height.equalTo(@60);
        }];
    }
    return _baseWaverView;
}

- (BPVolumeWaverView *)voiceWaveView {
    if (!_voiceWaveView) {
        BPVolumeWaverView *voiceWaveView = [[BPVolumeWaverView alloc] init];
        _voiceWaveView = voiceWaveView;
        _voiceWaveView.backgroundColor = kLightGrayColor;
        [self.view addSubview:_voiceWaveView];
        [_voiceWaveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.top.trailing.equalTo(self.baseWaverView);
            make.height.equalTo(@60);
        }];
    }
    return _voiceWaveView;
}

- (BPShapeLayerPathWaverView *)shapeLayerPathWaverView {
    if (!_shapeLayerPathWaverView) {
        BPShapeLayerPathWaverView *voiceWaveView = [[BPShapeLayerPathWaverView alloc] init];
        _shapeLayerPathWaverView = voiceWaveView;
        _shapeLayerPathWaverView.backgroundColor = kLightGrayColor;
        [self.view addSubview:_shapeLayerPathWaverView];
        [_shapeLayerPathWaverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.top.trailing.equalTo(self.voiceWaveView);
            make.height.equalTo(@60);
        }];
    }
    return _shapeLayerPathWaverView;
}

- (BPDrawWaverView *)drawWaverView {
    if (!_drawWaverView) {
        BPDrawWaverView *voiceWaveView = [[BPDrawWaverView alloc] init];
        _drawWaverView = voiceWaveView;
        _drawWaverView.backgroundColor = kLightGrayColor;
        [self.view addSubview:_drawWaverView];
        [_drawWaverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.top.trailing.equalTo(self.shapeLayerPathWaverView);
            make.height.equalTo(@60);
        }];
    }
    return _drawWaverView;
}

- (void)creatRecorder {
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

- (void)leftBarButtonItemClickAction:(id)sender {
    [self removeSunViews];
    [super leftBarButtonItemClickAction:sender];
}

- (void)removeSunViews {
    [_voiceWaveView removeFromSuperview];
    _voiceWaveView = nil;
    [_baseWaverView removeFromSuperview];
    _baseWaverView = nil;
    [_shapeLayerPathWaverView removeFromSuperview];
    _shapeLayerPathWaverView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
    [self removeSunViews];
}

@end
