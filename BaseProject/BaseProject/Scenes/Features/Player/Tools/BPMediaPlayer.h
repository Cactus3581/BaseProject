//
//  BPMediaPlayer.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/31.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "BPMediaModel.h"

NS_ASSUME_NONNULL_BEGIN

//播放状态
typedef NS_ENUM(NSInteger, BPAVPlayerState) {
    PlayerStateUnKnown,//未知
    PlayerStatePrepareToPlay,//马上准备播放
    PlayerStateReadyToPlay,//准备好播放
    PlayerStateError,//播放失败
    PlayerStatePlaying,//开始播放
    PlayerStatePaused,//暂停播放
    PlayerStateStopped,//停止工作
    PlayerStateFinished,//播放完成
    PlayerStateReset,//重置播放器，不同于Stopped
    PlayerStateNext, // 下一个
    PlayerStatePrevious, //上一个
};

//缓冲动画状态
typedef NS_ENUM(NSInteger, BPAVPlayerBufferingAnimation) {
    BPPLayerBufferingStopAnimation,//停止缓冲动画
    BPPLayerBufferingStartAnimation//开始缓冲动画
};

#pragma mark - 播放器通知名字

UIKIT_EXTERN  NSString * const BPAVplayerPlayStatusNotification;//播放状态的通知
UIKIT_EXTERN  NSString * const BPAVplayerPlayProgressNotification;//播放进度的通知
UIKIT_EXTERN  NSString * const BPAVplayerBufferingAnimationNotification;//缓冲动画通知
UIKIT_EXTERN  NSString * const BPAVplayerCachesProgressNotification;//缓存进度的通知

#pragma mark - 播放器通知key
UIKIT_EXTERN  NSString * const noti_userInfo_key_status;//播放状态情况
UIKIT_EXTERN  NSString * const noti_userInfo_key_totalTime;//总时间
UIKIT_EXTERN  NSString * const noti_userInfo_key_currentTime;//当前时间
UIKIT_EXTERN  NSString * const noti_userInfo_key_progress;//播放进度
UIKIT_EXTERN  NSString * const noti_userInfo_key_bufferingAnimation;//缓冲动画
UIKIT_EXTERN  NSString * const noti_userInfo_key_cachesProgress;//缓存进度情况

typedef void (^seekCompletionHandler)(BOOL finished);

@interface BPMediaPlayer : NSObject

@property (nonatomic,strong,readonly)   AVPlayer *player;//播放器
@property (nonatomic,copy,readonly)     NSString *urlString;//播放的音频
@property (nonatomic, readonly, strong) BPMediaModel *mediaModel;

@property (strong,nonatomic,readonly)   AVPlayerItem *playerItem;
@property (strong,nonatomic,readonly)   AVURLAsset *asset;
@property (nonatomic,copy,readonly)     NSString *cacheFilePath;//缓存路径
@property (nonatomic,copy,readonly)     NSString *totalTimeStr;//总时间
@property (nonatomic,assign,readonly)   NSInteger totalTime;
@property (nonatomic,copy,readonly)     NSString *currentTimeStr;// 当前时间
@property (nonatomic,assign,readonly)   NSInteger currentTime;
@property (nonatomic,assign,readonly)   CGFloat playProgress;//播放进度
@property (nonatomic,assign,readonly)   BOOL playButtonSelected;//播放按钮状态
@property (nonatomic,assign,readonly)   CGFloat cacheProgress;//缓存进度
@property (nonatomic,assign,readonly)   BPAVPlayerState state;//播放状态
@property (nonatomic,assign,readonly)   BPAVPlayerBufferingAnimation bufferingState;//缓冲状态（是否进行动画）
@property (nonatomic,assign,readonly)   CGSize presentationSize;//视频宽高
@property (nonatomic,strong,readonly)   UIImage *thumbnailImageAtCurrentTime;//当前时间的缩略帧图
@property (nonatomic,assign)            CGFloat rate;//当前播放速度，值为0.0时停止播放，值为1.0时为正常播放速度（注意更改播放速度要在视频开始播放之后才会生效）0.5-2倍；
@property (nonatomic,assign)            CGFloat volume;//声音大小
@property (nonatomic,assign)            BOOL muted;//指示播放器的音频输出是否为静音。只对播放器实例影响音频静音，对设备不影响。

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+ (instancetype)sharePlayer;

/**
 准备播放
 */

- (void)prepareWithMediaModel:(BPMediaModel *__nonnull)model;

/**
 细化准备播放，可将prepareWithMediaModel分为两步
 */
- (void)playerWillPrepareWithMediaModel:(BPMediaModel *__nonnull)model;
- (void)playerDidPrepareWithMediaModel:(BPMediaModel *__nonnull)model;

// 不涉及播放，只是涉及到跳转的时候用
//- (void)playerWithCourseModel:(BPCourseListModel *)courseModel chapterModel:(BPCourseChapterDetailInfo *)chapterModel;

// 以下四个暂时没用到
- (void)prepareWithUrl:(NSString *__nonnull)urlString;

- (void)prepareWithUrl:(NSString *__nonnull)urlString cacheFilePath:(NSString * __nullable)cacheFilePath;

- (void)preparePlayWithMediaListArray:(NSArray <BPMediaModel *> *)array index:(NSInteger)index;

- (void)preparePlayWithMediaListArray:(NSArray <BPMediaModel *> *)array;
/**
 准备播放
 */
- (void)preparePlay;

/**
 播放&&暂停事件
 */
- (void)playPauseAction;

/**
 播放事件
 */
- (void)play;

/**
 暂停事件
 */
- (void)pause;

/**
 自定义播放时间，比如快退快进
 
 @param value 0～1之间
 */
- (void)seekToTimePositionWithValue:(CGFloat)value completionHandler:(seekCompletionHandler)completionHandler ;

- (void)seekToPositiveTime:(CGFloat)currentTime completionHandler:(seekCompletionHandler)completionHandler ;

- (void)seekToTime:(CGFloat)value goPlaying:(BOOL)isGoplaying completionHandler:(seekCompletionHandler)completionHandler ;
- (void)seekToPositiveTime:(CGFloat)currentTime goPlaying:(BOOL)isGoplaying completionHandler:(seekCompletionHandler)completionHandler;

/**
 停止播放器
 */
- (void)stopPlayer;

/**
 reset 播放器,注意跟stopPlayer方法的不同，stopPlayer是每次进行更换item对象时执行，不清楚player内部数据；resetPlayer是调用stopPlayer之后，又清除了数据。
 */
- (void)resetPlayer;

/**
 获取缩略帧图
 
 @param second 指定的时间
 @return 图像
 */
- (UIImage *)getThumbnailImageAtTime:(NSInteger)second;

/**
 控制播放资源
 
 @param active 是否启用
 */
- (void)confirgAudioSessionWithActive:(BOOL)active;

/**
 移除锁屏信息
 
 */
- (void)removeNowPlayingInfoCenter;

/**
 model 转换
 
 */
- (BPMediaModel *)toMediaModelWithData:(id)data;

// 上报学习记录
- (void)uploadStudyRecord;

@end

NS_ASSUME_NONNULL_END
