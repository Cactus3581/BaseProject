//
//  BPVolumeWaverView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YSCShowLoadingCircleCallback)(void);

@interface BPVolumeWaverView : UIView

/**
 *  设置波纹个数，默认两个
 *
 *  @param waveNumber                 波纹个数
 */
- (void)setVoiceWaveNumber:(NSInteger)waveNumber;

/**
 *  开始声波动画
 */
- (void)startVoiceWave;

/**
 *  改变音量来改变声波振动幅度
 *
 *  @param stopVoiceWave 音量大小 大小为0~1
 */
- (void)changeVolume:(CGFloat)volume;

/**
 *  停止声波动画
 */
- (void)stopVoiceWaveWithShowLoadingViewCallback:(YSCShowLoadingCircleCallback)showLoadingCircleCallback;

@end
