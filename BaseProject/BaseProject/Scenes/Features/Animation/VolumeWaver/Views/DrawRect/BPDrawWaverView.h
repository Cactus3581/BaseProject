//
//  BPDrawView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BPVolumeWaverViewDelegate<NSObject>
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

@interface BPDrawWaverView : UIView

@property (nonatomic, assign) CGFloat value;//0-1之间
@property (nonatomic,weak) id<BPVolumeWaverViewDelegate>delegate;

- (void)startVoiceWave;

/**
 *  停止声波动画
 */
- (void)stopVoiceWaveWithCallback:(dispatch_block_t)callback;

/**
 *  开始第二部分动画
 */
- (void)secondAnaimation;

/**
 *  重写移除方法
 */
- (void)removeFromSuperview;

@end

