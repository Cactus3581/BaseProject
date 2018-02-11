//
//  BPShapeLayerPathWaverView.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/1/29.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPShapeLayerPathWaverViewDelegate<NSObject>
@optional
/**
 *  所有动画结束回调
 */
- (void)allAnaimationFinish;
/**
 *  点击手势回调
 */
- (void)tapGesCallback;
@end

typedef void (^BPShapeLayerPathWaverViewCallback)(void);

@interface BPShapeLayerPathWaverView : UIView
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
 *  @param volume 音量大小 大小为0~1
 */
- (void)changeVolume:(CGFloat)volume;

/**
 *  停止声波动画
 */
- (void)stopVoiceWaveWithShowLoadingViewCallback:(BPShapeLayerPathWaverViewCallback)callback;

/**
 *  开始第二部分动画
 */
- (void)secondAnaimation;

/**
 *  移除所有动画
 */
- (void)stopSecondAnaimation;

/**
 *  重写移除方法
 */
- (void)removeFromSuperview;

@property (nonatomic,weak) id<BPShapeLayerPathWaverViewDelegate>delegate;

@end
