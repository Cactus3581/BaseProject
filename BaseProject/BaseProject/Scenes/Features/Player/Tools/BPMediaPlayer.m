//
//  BPMediaPlayer.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/31.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPMediaPlayer.h"
#import <AFNetworking/AFNetworking.h>

#import <MediaPlayer/MediaPlayer.h>
#import "BPMediaDataSourceManager.h"
#import "BPMediaModel.h"
#import "SDWebImageManager.h"



static NSString *kPlayerAudioLastMediaCacheName   = @"PlayerAudioLastMediaCache.data";
static NSString *kPlayerAudioLastCourseModelCacheName   = @"PlayerAudioLastCourseModelCache.data";

//缓冲动画状态
typedef NS_ENUM(NSInteger, BPAVPlayerSwitchoverActionType) {
    BPAVPlayerSwitchoverNone,//
    BPAVPlayerSwitchoverNext,//下一个操作
    BPAVPlayerSwitchoverPrevious,//上一个操作
    BPAVPlayerSwitchoverAutoNext,//自动播放下一个
};

#pragma mark - 播放器通知名字
NSString *const BPAVplayerPlayProgressNotification          = @"BPAVplayerPlayProgressNotification";//播放进度的通知
NSString *const BPAVplayerPlayStatusNotification            = @"BPAVplayerPlayStatusNotification";//播放状态的通知
NSString *const BPAVplayerBufferingAnimationNotification    = @"BPAVplayerBufferingAnimationNotification";//缓冲动画通知
NSString *const BPAVplayerCachesProgressNotification        = @"BPAVplayerCachesProgressNotification";//缓存进度的通知

#pragma mark - 播放器通知key
NSString *const noti_userInfo_key_status                    = @"play_Status";
NSString *const noti_userInfo_key_totalTime                 = @"totalTime";
NSString *const noti_userInfo_key_currentTime               = @"currentTime";
NSString *const noti_userInfo_key_progress                  = @"progress";
NSString *const noti_userInfo_key_bufferingAnimation        = @"bufferingAnimation";
NSString *const noti_userInfo_key_cachesProgress            = @"cachesProgress";

#pragma mark - KVO key
static NSString *const kStatus                              = @"status";
static NSString *const kLoadedTimeRanges                    = @"loadedTimeRanges";
static NSString *const kPlaybackBufferEmpty                 = @"playbackBufferEmpty";
static NSString *const kPlaybackLikelyToKeepUp              = @"playbackLikelyToKeepUp";
static NSString *const kPresentationSize                    = @"presentationSize";
static NSString *const kRate                                = @"rate";

static BPMediaPlayer *playerManager = nil;

@interface BPMediaPlayer()
@property (strong,nonatomic) id timeObserver;  //播放时间观察者
@property (nonatomic,strong) AVPlayer *player;//播放器
@property (nonatomic,copy)   NSString *urlString;//播放的音频
@property (nonatomic,copy)   NSString *totalTimeStr;//总时间
@property (nonatomic,assign) NSInteger totalTime;
@property (nonatomic,copy)   NSString *currentTimeStr;// 当前时间
@property (nonatomic,assign) NSInteger currentTime;
@property (nonatomic,assign) CGFloat playProgress;//播放进度
@property (nonatomic,assign) BOOL playButtonSelected;//播放按钮状态
@property (nonatomic,assign) CGFloat cacheProgress;//缓存进度
@property (nonatomic,assign) CGSize presentationSize;//视频宽高
@property (nonatomic,assign) BPAVPlayerState state;//播放状态
@property (nonatomic,assign) BPAVPlayerBufferingAnimation bufferingState;//缓冲状态
@property (strong,nonatomic) AVPlayerItem *playerItem;//和媒体资源存在对应关系，管理媒体资源的信息和状态。
@property (strong,nonatomic) AVURLAsset *asset;//AVAsset是抽象类，不能直接使用，其子类AVURLAsset可以根据URL生成包含媒体信息的Asset对象
@property (nonatomic,strong) UIImage *thumbnailImageAtCurrentTime;//当前时间的缩略帧图

@property (nonatomic,strong) NSMutableDictionary *centerInfoDict;//控制中心信息
@property (nonatomic,strong) BPMediaModel *mediaModel;
// 下面两个数据涉及的是用数组播放的，暂时用不到
@property (nonatomic,assign) NSInteger currentIndex;//当前播放的是第几首
@property (nonatomic, strong) NSDate *studyRecordDate; // 记录学习进度
@end

@implementation BPMediaPlayer

@synthesize rate = _rate;

#pragma mark - 初始化 单例
+ (instancetype)sharePlayer{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerManager = [[self alloc] init];
        //[playerManager configAFNetworkReachabilityManager];//监控网络
        [playerManager confirgRemoteControlEventHandler];//自定义控制中心按钮
        [playerManager addObserver];
    });
    return playerManager;
}

#pragma mark - 配置session
- (void)confirgAudioSessionWithActive:(BOOL)active {
    if (active) {
        [[AVAudioSession sharedInstance] setActive:YES error:nil];//只要写了setCategory，这句话不写也OK，为什么？？
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                         withOptions:AVAudioSessionCategoryOptionAllowBluetooth | AVAudioSessionCategoryOptionDuckOthers
                                               error:nil];
    }else {
        [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    }
}

#pragma mark - 初始值
- (void)initialValue {
    _playButtonSelected = NO;
    _cacheProgress = 0.f;
    _bufferingState = BPPLayerBufferingStopAnimation;
    _presentationSize = CGSizeZero;
    
    /*
     //以下5个不需要重置
     totalTimeStr
     totalTime
     currentTimeStr
     currentTime
     playProgress
     
     ulrString/mediaModel 在stop中置为nil
     state 在reset中改为reset
     */
}

#pragma mark - player 准备数据
//- (void)playerWithCourseModel:(BPCourseListModel *)courseModel chapterModel:(BPCourseChapterDetailInfo *)chapterModel {
//    self.courseModel = courseModel;
//    self.chapterModel = chapterModel;
//}

- (void)preparePlayWithMediaListArray:(NSArray <BPMediaModel *> *)array index:(NSInteger)index {
    BPMediaModel *model = BPValidateArrayObjAtIdx(array, index);
    if (!BPValidateString(model.urlString).length || [BPValidateString(_urlString) isEqualToString:model.urlString]) {
        return;//如果音频地址一样，返回
    }
    _urlString = model.urlString;
    [[BPMediaDataSourceManager sharePlayerDataManager] setMediaListArrayWithArray:array.copy];
    self.currentIndex = index;
    _mediaModel = model;
    [self stopPlayer];
    [self preparePlay];
}

- (void)preparePlayWithMediaListArray:(NSArray <BPMediaModel *> *)array {
    [self preparePlayWithMediaListArray:array index:0];
}

- (void)prepareWithMediaModel:(BPMediaModel *__nonnull)model {
    if (!model) {
        return;
    }
    [self preparePlayWithMediaListArray:@[model]];
}

- (void)playerWillPrepareWithMediaModel:(BPMediaModel *__nonnull)model {
    
}

- (void)playerDidPrepareWithMediaModel:(BPMediaModel *__nonnull)model {
    
}

- (void)prepareWithUrl:(NSString *__nonnull)urlString {
    [self prepareWithUrl:urlString cacheFilePath:nil];
}

- (void)prepareWithUrl:(NSString *__nonnull)urlString cacheFilePath:(NSString * __nullable)cacheFilePath {
    BPMediaModel *model = [[BPMediaModel alloc] init];
    model.urlString = urlString;
    model.cachePath = cacheFilePath;
    [self preparePlayWithMediaListArray:@[model]];
}

- (void)preparePlay {
    [playerManager confirgAudioSessionWithActive:YES];//配置audioSession
    //只有停止了才能准备数据，为什么这么设计：因为播放按钮，不仅管理着播放暂停事件，还接受输入数据事件，如果不是停止状态，每次点击播放暂停按钮，都会生成新的item对象，造成循环。
    if (_state != PlayerStateStopped) return;
    NSURL *url;
    if (self.mediaModel.cachePath) {//有缓存播放缓存文件
        url = [NSURL fileURLWithPath:self.self.mediaModel.cachePath];
    }else {
        url = [NSURL URLWithString:BPUrlStringEncode(self.urlString)];
    }
    //创建新的item 有两种方法
    //TODO:AVURLAsset下载/获取缩略帧图/
    AVURLAsset *asset = [AVURLAsset assetWithURL:url];
    _asset = asset;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    //AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    _playerItem = playerItem;
    self.player = [AVPlayer playerWithPlayerItem:playerItem];// 每次都重新创建Player，替换replaceCurrentItemWithPlayerItem:
    //[self.player replaceCurrentItemWithPlayerItem:playerItem];//该方法阻塞线程
    
    [self enableAudioTracks:YES inPlayerItem:_playerItem];// 解决rate速度切换不正常
    
    [self addObserverWithPlayerItem:playerItem];//添加通知以及观察者，包括控制中心通知，完成通知，对item的观察等
    
    [self configPlayerItemPropery];
    
    _state = PlayerStatePrepareToPlay;
}

#pragma mark - iOS 9以上的新属性，暂未使用
- (void)configPlayerItemPropery {
    
    //_player.actionAtItemEnd = AVPlayerActionAtItemEndPause;//播放完毕后暂停
    
    if (@available(iOS 9.0, *)) {
        _playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = NO;// iOS9系统以前默认开启，iOS9默认关闭，处于暂停状态时，暂停缓冲
    }
    
    if (@available(iOS 10.0, *)) {
        _playerItem.preferredForwardBufferDuration = 1;//定义首选的前向缓冲区持续时间(以秒为单位)。如果设置为0，将为大多数用例选择适当的缓冲级别。
        _player.automaticallyWaitsToMinimizeStalling = NO;//解决iOS 10偶尔播放不了的问题
        AVPlayerTimeControlStatus timeControlStatus = self.player.timeControlStatus; // 监听播放状态的最新API
        NSString *reasonForWaitingToPlay = self.player.reasonForWaitingToPlay; // 查找不能播放的原因
        BPLog(@"%@",reasonForWaitingToPlay);
    }
}

// rate速度切换：在代码中设置小于0.5的值一直不生效，可以使用下面的方法:
- (void)enableAudioTracks:(BOOL)enable inPlayerItem:(AVPlayerItem*)playerItem {
    for (AVPlayerItemTrack *track in playerItem.tracks){
        if ([track.assetTrack.mediaType isEqual:AVMediaTypeVideo]) {
            track.enabled = enable;
        }
    }
}

#pragma mark - NSNotificationCenter
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];// 监听耳机插入和拔掉通知
    
    //程序被杀死时调用,保存数据。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminateNotification:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    
    
    /*
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionInterruptionCallback:) name:AVAudioSessionInterruptionNotification object:nil]; //打断处理-1：来电话、闹铃响等中断。
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionSilenceSecondaryAudioHintCallback:) name:AVAudioSessionSilenceSecondaryAudioHintNotification object:nil]; //打断处理-2：其他App占据AudioSession的时候回调
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionMediaServicesWereLostCallback:) name:AVAudioSessionMediaServicesWereLostNotification object:nil];// 如果媒体服务器被杀死，将被通知
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionMediaServicesWereResetCallback:) name:AVAudioSessionMediaServicesWereResetNotification object:nil];// 如果服务器重新启动，将被通知
     */
}

//程序被杀死时调用,保存数据。
- (void)applicationWillTerminateNotification:(NSNotification*)notification {
    [self saveLastMediaData];
}

- (void)saveLastMediaData {
    
}

- (void)recordMediaProgress {
    
}

#pragma mark - KVO
- (void)addObserverWithPlayerItem:(AVPlayerItem *)playerItem {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEndTimeCallback:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];//添加播放完成通知
    
    /*
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemPlaybackStalled:) name:AVPlayerItemPlaybackStalledNotification object:self.player.currentItem];//网络不好的时候，就会回调，但是回调方法不走：没有及时到达继续播放
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieJumped:) name:AVPlayerItemTimeJumpedNotification object:self.player.currentItem];//项目的当前时间发生了不连续的变化
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieJumped:) name:AVPlayerItemFailedToPlayToEndTimeNotification object:self.player.currentItem];//播放失败 item has failed to play to its end time
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieJumped:) name:AVPlayerItemNewAccessLogEntryNotification object:self.player.currentItem];// a new access log entry has been added
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieJumped:) name:AVPlayerItemNewErrorLogEntryNotification object:self.player.currentItem];// a new error log entry has been added
     
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieJumped:) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:self.player.currentItem];// NSError
     */
    
    //    //对这个方法传递一个时间数组，player会在播放到指定时间后回调这个block
    //    self.timeObserver = [self.player addBoundaryTimeObserverForTimes:@[[NSValue valueWithCMTime:CMTimeMake(1, 1000)]] queue:NULL usingBlock:^{
    //
    //        //Playback started
    //
    //        BPLog(@"currentTimeStr = %@",self.currentTimeStr);
    ////        [player removeTimeObserver:self.playerObserver];
    //    }];
    
    //在item添加完kvo，如果可以播放播放，执行以下代码：播放进度
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {// 播放1s回调一次
        NSTimeInterval totalTime = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        //发通知赋值：播放进度，当前播放时间，总时间
        if (isnan(totalTime)) {
            BPLog(@"isnan");
            //_playProgress = 0;
        }else {
            //BPLog(@"!isnan");
            //_playProgress = time.value/time.timescale/totalTime;
        }
        NSDictionary *dic = @{noti_userInfo_key_totalTime:BPValidateString(weakSelf.totalTimeStr),
                              noti_userInfo_key_currentTime:BPValidateString(weakSelf.currentTimeStr),
                              noti_userInfo_key_progress:BPValidateNumber(@(weakSelf.playProgress))
                              };
        [weakSelf postNotificationName:BPAVplayerPlayProgressNotification dic:dic];
        [weakSelf configNowPlayingInfoCenterWithArtistTitle:weakSelf.mediaModel.artistTitle albumTitle:weakSelf.mediaModel.albumTitle title:weakSelf.mediaModel.title image:weakSelf.mediaModel.image];
    }];
    //给item添加KVO 观察播放暂停状态，缓存进度（目前没用，因为有下载器）,观察可以播放和失败等
    [self.player addObserver:self forKeyPath:kRate options:NSKeyValueObservingOptionNew context:nil];//观察播放暂停状态
    [playerItem addObserver:self forKeyPath:kStatus options:NSKeyValueObservingOptionNew context:nil];//观察可以播放和失败结果
    [playerItem addObserver:self forKeyPath:kLoadedTimeRanges options:NSKeyValueObservingOptionNew context:nil];//观察缓存进度
    [playerItem addObserver:self forKeyPath:kPlaybackBufferEmpty options:NSKeyValueObservingOptionNew context:nil];//监听播放的区域缓存是否为空,即开始动画
    [playerItem addObserver:self forKeyPath:kPlaybackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:nil];//缓存可以播放的时候调用，即隐藏动画
    [playerItem addObserver:self forKeyPath:kPresentationSize options:NSKeyValueObservingOptionNew context:nil];//数据的宽和高（16:9）
}

//KVO 监听item状态方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    //只执行一次
    if ([keyPath isEqualToString:kStatus]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        switch (status) {
            case AVPlayerItemStatusUnknown: {
                BPLog(@"未知状态");
                _state = PlayerStateError;
                NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateError)};
                [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
                break;
            }
            case AVPlayerItemStatusReadyToPlay: {//可以播放音乐
                BPLog(@"播放音乐");
#warning 这里处理有待商榷
                /*
                 _state = PlayerStateReadyToPlay;//置为准备状态
                 NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateReadyToPlay)};
                 [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];//发送等待播放通知
                 */
                
                //[self play];
                break;
            }
            case AVPlayerItemStatusFailed: {//失败
                BPLog(@"播放失败");
                _state = PlayerStateError;
                NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateError)};
                [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
                break;
            }
        }
    } else if ([keyPath isEqualToString:kLoadedTimeRanges]) { //获取缓冲进度
        NSArray *array = self.player.currentItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);//本次缓冲起始时间
        NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);//缓冲时间
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        float totalTime = CMTimeGetSeconds(self.player.currentItem.duration);//视频总长度
        float progress = totalBuffer/totalTime;//缓冲进度
        _cacheProgress = progress;
        NSDictionary *dic = @{noti_userInfo_key_cachesProgress:@(progress)};
        [self postNotificationName:BPAVplayerCachesProgressNotification dic:dic];
    } else if ([keyPath isEqualToString:kPlaybackBufferEmpty]) {//监听播放的区域缓存是否为空,即开始动画，但是此方法不准
        // 当缓冲是空的时候
        if (self.player.currentItem.playbackBufferEmpty) { // 加判断不准啊，不走里面
            //BPLog(@"开始缓冲动画");
            _bufferingState = BPPLayerBufferingStartAnimation;
            NSDictionary *dic = @{noti_userInfo_key_bufferingAnimation:@(BPPLayerBufferingStartAnimation)};
            [self postNotificationName:BPAVplayerBufferingAnimationNotification dic:dic];
#warning 待优化： 缓冲较差时候可以让播放器暂停，等待缓冲完成继续播放
        }
    } else if ([keyPath isEqualToString:kPlaybackLikelyToKeepUp]) {//缓存可以播放的时候调用，即隐藏动画。真正开始播放声音的地方。
        // 当缓冲好的时候
        if (self.player.currentItem.playbackLikelyToKeepUp){
            //BPLog(@"停止缓冲动画");
            _bufferingState = BPPLayerBufferingStopAnimation;
            NSDictionary *dic = @{noti_userInfo_key_bufferingAnimation:@(BPPLayerBufferingStopAnimation)};
            [self postNotificationName:BPAVplayerBufferingAnimationNotification dic:dic];
        }
    } else if ([keyPath isEqualToString:kRate]) {
#warning 判断播放暂停的状态有待商榷：可利用_status或者新属性
        if (self.player.rate == 0.0) {//暂停状态
            _state = PlayerStatePaused;
            NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStatePaused)};
            [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
        }else if (self.player.rate == 1.0) {//播放状态
            _state = PlayerStatePlaying;
            NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStatePlaying)};
            [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
            
        }else {
            _state = PlayerStateError;//失败状态
            NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateError)};
            [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
        }
    } else if ([keyPath isEqualToString:kPresentationSize]) {
        _presentationSize = self.player.currentItem.presentationSize;
    }
}

//移除通知：stopPlayer和delloc时用
- (void)removeObserver {
    
    if (self.timeObserver) {
        [self.player removeTimeObserver:self.timeObserver];//移除观察者
        self.timeObserver = nil;
        [self.player removeObserver:self forKeyPath:kRate];
    }
    
    //移除KVO
    [self.player.currentItem removeObserver:self forKeyPath:kStatus];
    [self.player.currentItem removeObserver:self forKeyPath:kLoadedTimeRanges];
    [self.player.currentItem removeObserver:self forKeyPath:kPlaybackBufferEmpty];
    [self.player.currentItem removeObserver:self forKeyPath:kPlaybackLikelyToKeepUp];
    [self.player.currentItem removeObserver:self forKeyPath:kPresentationSize];
    
    //[self.player replaceCurrentItemWithPlayerItem:nil];//移除当前播放的item对象，会阻塞线程
    self.player = [AVPlayer playerWithPlayerItem:nil];//移除当前播放的item对象;替换replaceCurrentItemWithPlayerItem
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    _asset = nil;
    _playerItem = nil;
}

#pragma mark - 提供给外界的控制播放器：播放、暂停、快进退的方法

- (void)playPauseAction {
    
    [playerManager confirgAudioSessionWithActive:YES];//配置audioSession
#warning 判断播放暂停的状态有待商榷：可利用_status或者新属性
    if (self.player.rate == 0) {//rate == 0.0，暂停
        [self play];
    } else if (self.player.rate == 1) {//rate ==1.0，表示正在播放
        [self pause];
    }else if (self.player.rate == -1) {//rate == -1.0，播放失败
        
    }
    /*
     if (_state == PlayerStatePlaying) {
     [self pause];
     } else {
     [self play];
     }
     */
}

//播放
- (void)play {
    if ((self.currentTime && self.totalTime && self.currentTime >= self.totalTime)) {// 如果已播放完毕，则重新从头开始播放
        [self.player seekToTime:CMTimeMakeWithSeconds(0, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
    [self.player play];
    [self recordMediaProgress];
}

//暂停
- (void)pause {
    [self.player pause];
    [self recordMediaProgress];
}

//自定义播放时间，跳到某个时间进度
- (void)seekToTimePositionWithValue:(CGFloat)value completionHandler:(seekCompletionHandler)completionHandler {
    [self seekToTime:value goPlaying:YES completionHandler:completionHandler];
}

- (void)seekToTime:(CGFloat)value goPlaying:(BOOL)isGoplaying completionHandler:(seekCompletionHandler)completionHandler{
    NSTimeInterval slideTime = CMTimeGetSeconds(self.player.currentItem.duration) * value;
    if (slideTime == CMTimeGetSeconds(self.player.currentItem.duration)) {
        //slideTime -= 0.5; // 有没有必要
    }
    [self seekToPositiveTime:slideTime goPlaying:isGoplaying completionHandler:completionHandler];
}

- (void)seekToPositiveTime:(CGFloat)currentTime completionHandler:(seekCompletionHandler)completionHandler{
    [self seekToPositiveTime:currentTime goPlaying:YES completionHandler:completionHandler];
}

- (void)seekToPositiveTime:(CGFloat)currentTime goPlaying:(BOOL)isGoplaying completionHandler:(seekCompletionHandler)completionHandler {
    if (self.currentTime > self.totalTime) {
        return;
    }
    if (self.state == PlayerStatePlaying || self.state == PlayerStatePaused || self.state == PlayerStateFinished) {
        [self.player.currentItem cancelPendingSeeks]; // 要不要取消之前的seek操作
        CMTime seekTime = CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC);
        //CMTime seekTime = CMTimeMake(currentTime, 1);
        if (CMTIME_IS_INDEFINITE(seekTime) || CMTIME_IS_INVALID(seekTime)) {
            return; // 为了解决seek的bug？
        }
        [self.player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:completionHandler];
        if (isGoplaying) {
            //[self play]; // 不使用这个方法的原因：因为[self play]方法里面，有重新开始的方法（通常是播放按钮来调用的方法）；而快进快退方法不考虑重新从头开始这个因素
            [self.player play];
        } else {
            [self pause];
        }
        /*
         [self.player seekToTime:seekTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
         if (completionHandler) {
         completionHandler(finished);
         }
         if (isGoplaying) {
         [self.player play];
         } else {
         [self pause];
         }
         }];
         */
    }
}

//停止工作
- (void)stopPlayer {
    if (self.state == PlayerStateStopped) return;
    [self pause];//暂停
    [self removeObserver];//移除kvo
    [self initialValue];//初始默认值
    self.state = PlayerStateStopped;//置为停止状态
    NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateStopped)};//发送通知
    [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
}

//reset 播放器
- (void)resetPlayer {
    if (self.state == PlayerStateReset) {
        return;
    }
    [self stopPlayer];
    _urlString = nil;
    _mediaModel = nil;
    _currentIndex = -1;
    [[BPMediaDataSourceManager sharePlayerDataManager] clearMediaListArray];
    [_centerInfoDict removeAllObjects];
    [self removeNowPlayingInfoCenter];//控制中心信息置为nil
    [self initialValue];//拿初始值
    self.state = PlayerStateReset;//置为reset状态
    NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateReset)};//发送通知
    [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
}

- (UIImage *)getThumbnailImageAtTime:(NSInteger)second {
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:_asset];
    CMTime expectedTime = CMTimeMake(second, 1);
    
    CGImageRef cgImage = NULL;
    
    imageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    imageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    cgImage = [imageGenerator copyCGImageAtTime:expectedTime actualTime:NULL error:NULL];
    
    if (!cgImage) {
        imageGenerator.requestedTimeToleranceBefore = kCMTimePositiveInfinity;
        imageGenerator.requestedTimeToleranceAfter = kCMTimePositiveInfinity;
        cgImage = [imageGenerator copyCGImageAtTime:expectedTime actualTime:NULL error:NULL];
    }
    
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    return image;
}

#pragma mark - 以下为通知的回调方法

//通知-播放完成的回调
- (void)playerItemDidPlayToEndTimeCallback:(NSNotification *)notification {
    [self playerFinished];
    [self nextActionWithType:@(BPAVPlayerSwitchoverAutoNext)];
}

- (void)playerFinished {
    [self pause];//暂停播放
    _state = PlayerStateFinished;//置为播放完成状态
    NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateFinished)};
    [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic]; //发送播放完成通知方法
}

//通知-网络不好的时候，就会回调，但是回调方法不走
//在监听播放器状态中处理比较准确，
- (void)playerItemPlaybackStalled:(NSNotification *)notification {
    // 这里网络不好的时候，就会进入，不做处理，会在playbackBufferEmpty里面缓存之后重新播放
    BPLog(@"buffing");
}

//通知-耳机插入、拔出事件
- (void)audioRouteChangeListenerCallback:(NSNotification *)notification {
    NSDictionary *interuptionDict = notification.userInfo;
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // 耳机插入
            if (_state == PlayerStatePlaying ) {
                [self play];
            }
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable: {
            // 耳机拔掉
            if (_state == PlayerStatePlaying ) {
                [self play];
            }
        }
            break;
        case AVAudioSessionRouteChangeReasonCategoryChange:
            break;
    }
}

//通知-打断处理通知 - 暂未使用
//系统事件比如电话、闹铃打断处理通知方法
- (void)audioSessionInterruptionCallback:(NSNotification *)notification {
    //通知类型
    NSDictionary * info = notification.userInfo;
    if ([[info objectForKey:AVAudioSessionInterruptionTypeKey] integerValue] == 1) { //AVAudioSessionInterruptionTypeBegan:开始中断
        [self pause];
    }else { //AVAudioSessionInterruptionTypeEnded:中断结束
        [self play];
    }
    if ([[info objectForKey:AVAudioSessionInterruptionOptionKey] integerValue] == 1) { //表示此时也应该恢复继续播放和采集。
        [self play];
    }
}

//其他app打断处理通知方法
- (void)audioSessionSilenceSecondaryAudioHintCallback:(NSNotification *)notification {
    //通知类型
    NSDictionary * info = notification.userInfo;
    if ([[info objectForKey:AVAudioSessionSilenceSecondaryAudioHintTypeKey] integerValue] == 1) { //AVAudioSessionSilenceSecondaryAudioHintTypeBegin:开始中断
        [self pause];
    }else { //AVAudioSessionSilenceSecondaryAudioHintTypeEnd:中断结束
        [self play];
    }
}

#pragma mark - GET方法：提供给内部和外界的变量:当前播放时间、总时间、播放暂停状态、是否动画
- (CGFloat)playProgress {
    if (self.totalTime == 0) {
        _playProgress = 0;
    }else {
        _playProgress = self.currentTime*1.00/self.totalTime*1.00;
    }
    return _playProgress;
}

- (NSString *)totalTimeStr {
    return  BPTimeString(self.totalTime);
}

- (NSInteger)totalTime {
    NSTimeInterval totalTime = CMTimeGetSeconds(self.player.currentItem.duration);
    if (isnan(totalTime)) {
        return 0;
    }
    return totalTime;
}

- (NSString *)currentTimeStr {
    return  BPTimeString(self.currentTime);
}

- (NSInteger)currentTime {
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentTime);
    //两种写法
    //CMTime time = self.player.currentItem.currentTime;
    //float currentTime = time.value/time.timescale;
    if (isnan(currentTime)) {
        return 0;
    }
    return currentTime;
}

//获取播放或者暂停状态
- (BOOL)playButtonSelected {
    if (_state == PlayerStatePlaying) {
        return YES;
    }
    return NO;
}

- (CGFloat)rate {
    return _rate == 0 ? 1:_rate;
}

- (UIImage *)thumbnailImageAtCurrentTime {
    return [self getThumbnailImageAtTime:self.currentTime];
}

#pragma mark - SETTER方法

- (void)setRate:(CGFloat)rate {
    _rate = rate;
    if (self.player && fabsf(_player.rate) > 0.00001f) {
        self.player.rate = rate;
    }
}

- (void)setMuted:(BOOL)muted {
    _muted = muted;
    self.player.muted = muted;
}

- (void)setVolume:(CGFloat)volume {
    _volume = MIN(MAX(0, volume), 1);
    self.player.volume = volume;
}

#pragma mark - 发送给外界通知（播放器内部没有权限修改数据）
- (void)postNotificationName:(NSString *)name dic:(NSDictionary *)dic {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:dic];
}

#pragma mark -设置控制中心正在播放的信息
- (void)configNowPlayingInfoCenterWithArtistTitle:(NSString *)artistTitle albumTitle:(NSString *)albumTitle title:(NSString *)title image:(UIImage *)mediaImage {
    if (!_urlString || !BPValidateString(_urlString).length) return;
    
    if (!artistTitle) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];// app名称
        [self.centerInfoDict setObject:BPValidateString(app_Name) forKey:MPMediaItemPropertyArtist];//歌手名
    } else {
        [self.centerInfoDict setObject:BPValidateString(artistTitle) forKey:MPMediaItemPropertyArtist];//歌手名
    }
    
    [self.centerInfoDict setObject:BPValidateString(albumTitle) forKey:MPMediaItemPropertyAlbumTitle];//音频专辑
    [self.centerInfoDict setObject:BPValidateString(title) forKey:MPMediaItemPropertyTitle];//音频名
    [self.centerInfoDict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.player.currentItem.duration)] forKeyedSubscript:MPMediaItemPropertyPlaybackDuration];//歌曲的总时间
    [self.centerInfoDict setObject:[NSNumber numberWithDouble:CMTimeGetSeconds(self.player.currentTime)] forKeyedSubscript:MPNowPlayingInfoPropertyElapsedPlaybackTime];//歌曲的当前播放时间
    
    //设置歌曲图片
    if (!mediaImage) {
        mediaImage = [UIImage imageNamed:@"ic_launcher"];
    }
    if (mediaImage) {
        if (kiOS10) {
            //            MPMediaItemArtwork *imageItem = [[MPMediaItemArtwork alloc] initWithBoundsSize:CGSizeMake(80, 80) requestHandler:^UIImage * _Nonnull(CGSize size) {
            //                BPLog(@"%.2f,%.2f",size.width,size.height);
            //                return mediaImage;
            //            }];
        } else {
            
        }
        MPMediaItemArtwork *imageItem = [[MPMediaItemArtwork alloc] initWithImage:mediaImage];
        if (imageItem) {
            [self.centerInfoDict setObject:imageItem forKey:MPMediaItemPropertyArtwork];
        }
    }
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:self.centerInfoDict];//设置控制中心歌曲信息
}

//清除控制中心播放的信息
- (void)removeNowPlayingInfoCenter {
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
}

#pragma mark - 自定义控制中心按钮
// 在需要处理远程控制事件的具体控制器或其它类中实现
- (void)confirgRemoteControlEventHandler {
    // 直接使用sharedCommandCenter来获取MPRemoteCommandCenter的shared实例
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    // 启用播放命令 (锁屏界面和上拉快捷功能菜单处的播放按钮触发的命令)
    commandCenter.playCommand.enabled = YES;
    // 为播放命令添加响应事件, 在点击后触发
    [commandCenter.playCommand addTarget:self action:@selector(playActionInControl)];
    
    // 播放, 暂停, 上下曲的命令默认都是启用状态, 即enabled默认为YES
    // 为暂停, 上一曲, 下一曲分别添加对应的响应事件
    [commandCenter.pauseCommand addTarget:self action:@selector(pauseActionInControl)];
    
    [commandCenter.previousTrackCommand addTarget:self action:@selector(previousActionInControl)];
    [commandCenter.nextTrackCommand addTarget:self action:@selector(nextActionInControl)];
    
    // 启用耳机的播放/暂停命令 (耳机上的播放按钮触发的命令)
    commandCenter.togglePlayPauseCommand.enabled = YES;
    // 为耳机的按钮操作添加相关的响应事件
    [commandCenter.togglePlayPauseCommand addTarget:self action:@selector(playPauseAction)];
    
    // 前进,倒退
    //    [commandCenter.seekForwardCommand setEnabled:true];
    //    [commandCenter.seekForwardCommand addTarget:self action:@selector(seekForwardCommandInControl)];
    //    [commandCenter.seekBackwardCommand setEnabled:true];
    //    [commandCenter.seekBackwardCommand addTarget:self action:@selector(seekBackwardCommandInControl)];
    
    
    if(@available(iOS 9.1, *)) {
        __weak typeof(self) weakSelf = self;
        [commandCenter.changePlaybackPositionCommand setEnabled:true];
        //[commandCenter.changePlaybackPositionCommand addTarget:self action:@selector(changePlaybackPositionCommand:)];
        [commandCenter.changePlaybackPositionCommand addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
            CMTime totlaTime = weakSelf.player.currentItem.duration;
            MPChangePlaybackPositionCommandEvent *playbackPositionEvent = (MPChangePlaybackPositionCommandEvent *)event;
            [weakSelf.player seekToTime:CMTimeMake(totlaTime.value * playbackPositionEvent.positionTime / CMTimeGetSeconds(totlaTime), totlaTime.timescale) completionHandler:^(BOOL finished) {
                
            }];
            return MPRemoteCommandHandlerStatusSuccess;
        }];
    }
    
    // 添加"喜欢"按钮, 需要启用, 并且设置了相关Action后才会生效
    /*
     [MPRemoteCommandCenter sharedCommandCenter].likeCommand.enabled = YES;
     [[MPRemoteCommandCenter sharedCommandCenter].likeCommand addTarget:self action:@selector(likeItemActionControl)];
     [MPRemoteCommandCenter sharedCommandCenter].likeCommand.localizedTitle = @"喜欢";
     
     // 添加"不喜欢"按钮
     [MPRemoteCommandCenter sharedCommandCenter].dislikeCommand.enabled = YES;
     // 自定义该按钮的响应事件, 实现在点击"不喜欢"时去执行上一首的功能
     [[MPRemoteCommandCenter sharedCommandCenter].dislikeCommand
     addTarget:self action:@selector(previousActionInControl)];
     
     // 自定义"不喜欢"的标题, 伪装成"上一首"
     [MPRemoteCommandCenter sharedCommandCenter].dislikeCommand.localizedTitle = @"上一首";
     */
}
//控制中心：事件执行

- (void)changePlaybackPositionCommand:(MPRemoteCommandEvent *)command {
    
}

- (void)seekForwardCommandInControl {
    
}

- (void)seekBackwardCommandInControl {
    
}

- (void)playActionInControl {
    [self play];
}

- (void)pauseActionInControl {
    [self pause];
}

- (void)nextActionInControl {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(nextActionWithType:) object:nil];//取消
    [self performSelector:@selector(nextActionWithType:) withObject:@(BPAVPlayerSwitchoverNext) afterDelay:.5f];
}

- (void)previousActionInControl {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(previousActionWithType:) object:nil];//取消
    [self performSelector:@selector(previousActionWithType:) withObject:@(BPAVPlayerSwitchoverPrevious) afterDelay:.5f];
}

- (void)likeItemActionControl {
    
}

//下一首事件
- (void)nextActionWithType:(NSNumber *)type {
    if (self.mediaModel.mediaItemType == BPMediaItemAudio) {
        //    [self playerFinished];
        if (self.mediaModel.mediaItemDataSourceType == BPMediaItemDataSourceFromServer) {
            [self requestNextFromServerWithID:self.mediaModel.nextChapterId switchoverActionType:type.integerValue];
        } else if (self.mediaModel.mediaItemDataSourceType == BPMediaItemDataSourceFromArray) {
            [self requestNextFromArrayWithSwitchoverActionType:type.integerValue];
        }
    }
}

//上一首事件
- (void)previousActionWithType:(NSNumber *)type {
    if (self.mediaModel.mediaItemType == BPMediaItemAudio) {
        //    [self playerFinished];
        if (self.mediaModel.mediaItemDataSourceType == BPMediaItemDataSourceFromServer) {
            [self requestNextFromServerWithID:self.mediaModel.preChapterId switchoverActionType:type.integerValue];
        } else if (self.mediaModel.mediaItemDataSourceType == BPMediaItemDataSourceFromArray) {
            [self requestNextFromArrayWithSwitchoverActionType:type.integerValue];
        }
    }
}

#pragma mark - 切换多媒体文件接口
// 后台接口
- (void)requestNextFromServerWithID:(NSString *)chapterId switchoverActionType:(BPAVPlayerSwitchoverActionType)switchoverActionType {
    
}

// 本地数组
- (void)requestNextFromArrayWithSwitchoverActionType:(BPAVPlayerSwitchoverActionType)switchoverActionType {
    if (switchoverActionType == BPAVPlayerSwitchoverNext || switchoverActionType == BPAVPlayerSwitchoverAutoNext) {
        BPMediaDataSourceManager *manger = [BPMediaDataSourceManager sharePlayerDataManager];
        BPMediaModel *nextModel = [manger getNextModelWithCurrentIndex:self.currentIndex];
        if (nextModel.mediaItemType == BPMediaItemAudio) {
            NSInteger nextIndex = [manger getNextIndexWithCueentIndex:self.currentIndex];
            _state = PlayerStateNext;
            NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStateNext)};
            [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
            [self preparePlayWithMediaListArray:[BPMediaDataSourceManager sharePlayerDataManager].mediaListArray index:nextIndex];
            [self playPauseAction];
        }
    } else if (switchoverActionType == BPAVPlayerSwitchoverPrevious) {
        BPMediaDataSourceManager *manger = [BPMediaDataSourceManager sharePlayerDataManager];
        BPMediaModel *model = [manger getPreviousModelWithCurrentIndex:self.currentIndex];
        if (model.mediaItemType == BPMediaItemAudio) {
            NSInteger previousIndex  = [manger getPreviousIndexWithCurrentIndex:self.currentIndex];
            _state = PlayerStatePrevious;
            NSDictionary *dic = @{noti_userInfo_key_status:@(PlayerStatePrevious)};
            [self postNotificationName:BPAVplayerPlayStatusNotification dic:dic];
            [self preparePlayWithMediaListArray:[BPMediaDataSourceManager sharePlayerDataManager].mediaListArray index:previousIndex];
            [self playPauseAction];
        }
    }
}

#pragma mark - 监测网络抖动情况
- (void)configAFNetworkReachabilityManager {
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    //[self getNetworkReachabilityStatus:status];
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [weakSelf getNetworkReachabilityStatus:status];
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)getNetworkReachabilityStatus:(AFNetworkReachabilityStatus)status {
    // 一共有四种状态
    switch (status) {
        case AFNetworkReachabilityStatusNotReachable:
            BPLog(@"AFNetworkReachability Not Reachable = 未连接");
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:
            BPLog(@"AFNetworkReachability Reachable via WWAN = 蜂窝移动网络");
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:
            BPLog(@"AFNetworkReachability Reachable via WiFi = WiFi");
            break;
            
        case AFNetworkReachabilityStatusUnknown:
        default:
            BPLog(@"AFNetworkReachability Unknown = 未知状态");
            break;
    }
}

#pragma mark - 封堵alloc及copy
//重写allocWithZone，重写单例对象的alloc方法, 防止单例对象被重复创建
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if(playerManager == nil) {
            playerManager = [super allocWithZone:zone];
        }
    });
    return playerManager;
}

//保证copy时相同
- (instancetype)copyWithZone:(NSZone *)zone {
    return playerManager;
}

- (instancetype)copy {
    return self;
}

- (instancetype)mutableCopy {
    return self;
}

#pragma mark - lazy methods

//播放器AVPlayer
- (AVPlayer *)player {
    if (!_player) {
        _player = [[AVPlayer alloc] init];
    }
    return _player;
}

- (NSMutableDictionary *)centerInfoDict {
    if (!_centerInfoDict) {
        _centerInfoDict = @{}.mutableCopy;
    }
    return _centerInfoDict;
}

- (BPMediaModel *)mediaModel {
    if (!_mediaModel) {
        _mediaModel = [[BPMediaModel alloc] init];
    }
    return _mediaModel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除通知
    [self removeObserver];//移除kvo
    [self removeNowPlayingInfoCenter];//控制中心置为nil
}

@end

