//
//  BPVideoView.m
//  WPSExcellentClass
//
//  Created by xiaruzhen on 2018/10/21.
//  Copyright © 2018 Kingsoft. All rights reserved.
//

#import "BPVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SDWebImageManager.h"
#import "BPMediaPlayer.h"
#import "UIDevice+BPAdd.h"
#import "BPDeviceOrientation.h"
#import "UIImageView+WebCache.h"
#import "UIView+BPShadow.h"
#import "UIColor+BPAdd.h"
#import "Reachability.h"
#import "UIButton+BPEnlargeEdge.h"
#import "BPMediaModel.h"
#import "BPAppDelegate.h"
#import "UIView+BPSafeArea.h"


static CGFloat topToolViewHeight = 50;
static CGFloat bottomToolViewHeight = 40;
static CGFloat bottomToolViewSafeAreaHeight = 40;
static NSInteger bottomToolViewTime = 8;

typedef NS_ENUM(NSUInteger, Direction) {
    DirectionLeftOrRight,//左右手势
    DirectionUpOrDown,//上下手势
    DirectionNone//没有手势
};

typedef NS_ENUM(NSUInteger, BPMiddlePlayButtonStyle) {
    BPMiddlePlayButtonStyle_WIFIPlay,//正常的播放按钮样式
    BPMiddlePlayButtonStyle_WWANPlay,//用流量的播放样式
    BPMiddlePlayButtonStyle_NoNetPlay,//无网无缓存（不能播放时）的样式
};

@interface BPVideoView() <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *panGesureView;

@property (weak, nonatomic) AVPlayerLayer *playerLayer;//播放界面（layer）

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UIView *centerToolMaskView;
@property (weak, nonatomic) IBOutlet UIButton *middlePlayButton;
@property (weak, nonatomic) IBOutlet UILabel *middleCurrrentTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *topToolView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToolViewTopConstraint;

@property (weak, nonatomic) IBOutlet UIView *bottomToolView;
@property (weak, nonatomic) IBOutlet UIView *bottomContentView;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenButton;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderTrailingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomToolViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonTooViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *wwanLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) BPMediaPlayer *player;
@property (nonatomic, assign) BOOL isOriginationPlaying; // seek的参数 关乎之后的是否播放
@property (nonatomic, assign) BOOL isdragging; //记住滑杆的滑动中的状态，当滑动时，既不让播放器暂停，也不让slider接受播放器的播放中状态信息。

//以下为快进快退功能
@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@property (assign, nonatomic) Direction direction;
@property (nonatomic, assign) CGFloat sumTime;//注意类型的正确性（CGFloat/int）
@end

@implementation BPVideoView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeViews];
    [self configNetworkReachabilityManager];
}

- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
//    BPLog(@"BPHomeBarBottom = %.2f",BPHomeBarBottom(self));
    CGFloat homeBarBottom = BPSafeAreaHomeBarBottom(self);
    bottomToolViewSafeAreaHeight = homeBarBottom ? homeBarBottom + bottomToolViewHeight : bottomToolViewHeight;
    self.bottonTooViewHeightConstraint.constant = bottomToolViewSafeAreaHeight;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_playerLayer) {
        self.playerLayer.frame = self.bounds;
    }
}

- (void)setMediaModel:(BPMediaModel *)mediaModel {
    _mediaModel = mediaModel;
    
    if (BPValidateString(mediaModel.imageUrl).length) {
        self.coverImageView.hidden = NO;
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:mediaModel.imageUrl] placeholderImage:nil];
    }
    
    if (BPValidateString(mediaModel.cachePath).length) {
        Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        [self getNetworkReachabilityStatus:[reachability currentReachabilityStatus]];
    }

    [self initializePlayer];
}

- (BOOL)isFullScreen {
    return self.fullScreenButton.selected;
}

- (void)initializePlayer {
    [_playerLayer removeFromSuperlayer];
    _playerLayer = nil;
    if (BPValidateString(self.mediaModel.urlString).length && [BPValidateString(self.player.urlString) isEqualToString:BPValidateString(self.mediaModel.urlString)]) {
        [self addAVPlayerLayer];
        [self getInitializeValue]; //拿初值
        [self registerNotification:YES]; //注册消息，拿动态消息
        [self performSelector:@selector(hideBottomControllView) withObject:nil afterDelay:bottomToolViewTime];
    } else {
        [self registerNotification:NO];
        [self resetInitializeValue];
    }
}

- (void)addAVPlayerLayer {
    if (!_playerLayer) {
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player.player];
        _playerLayer = playerLayer;
        //BOOL readyForDisplay = playerLayer.isReadyForDisplay;// 判断是否准备好显示
        //CGRect videoRect = playerLayer.videoRect;//当前视频图像的大小位置
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.layer addSublayer:self.playerLayer];
        self.playerLayer.frame = self.bounds;
        // 注意一下展示的层级顺序
        [self bringSubviewToFront:self.coverImageView];
        [self bringSubviewToFront:self.centerToolMaskView];
        [self bringSubviewToFront:self.topToolView];
        [self bringSubviewToFront:self.bottomToolView];
        [self bringSubviewToFront:self.activityView];
        [self addPanGestureRecognizer];
    }
}

#pragma button action
- (IBAction)playAction:(id)sender {
    [self playButtonClick:sender];
}

- (IBAction)middlePlayAction:(id)sender {
    [self playButtonClick:sender];
}

#pragma 播放键 点击事件
- (void)playButtonClick:(UIButton *)sender {
    if (!self.mediaModel.urlString || !BPValidateString(self.mediaModel.urlString).length) {
        return;
    }
    self.centerToolMaskView.hidden = self.middlePlayButton.hidden = YES;// 第一次播放后，以后就不让它显示了
    self.coverImageView.hidden = YES;
    [self showBottomControllViewWithDelayHide:YES];
    [self registerNotification:YES]; //注册消息，拿动态消息
    [self.player prepareWithMediaModel:self.mediaModel];
    [self addAVPlayerLayer];
    [self.player playPauseAction];// 播放暂停事件
    

}

#pragma mark - Slider点击/滑动动作
//按下
- (void)sliderPause:(UISlider *)sender {
    if ([BPValidateString([BPMediaPlayer sharePlayer].urlString) isEqualToString:BPValidateString(self.mediaModel.urlString)]) {
        self.isdragging = YES;
        [self showBottomControllViewWithDelayHide:NO];
        if (self.player.state == PlayerStatePlaying) {
            self.isOriginationPlaying = YES;
        } else {
            self.isOriginationPlaying = NO;
        }
    }
}

//取消滑动
- (void)sliderCancel:(UISlider *)sender {
    if ([BPValidateString([BPMediaPlayer sharePlayer].urlString) isEqualToString:BPValidateString(self.mediaModel.urlString)]) {
        self.isdragging = NO;
    }
}

//抬起
- (void)sliderPlay:(UISlider *)sender {
    if ([BPValidateString([BPMediaPlayer sharePlayer].urlString) isEqualToString:BPValidateString(self.mediaModel.urlString)]) {
        __weak typeof(self) weakSelf = self;
        [self.player seekToTime:sender.value goPlaying:self.isOriginationPlaying completionHandler:^(BOOL finished) {
            if (finished) {
                weakSelf.isdragging = NO;
            }
        }];
        [self performSelector:@selector(hideBottomControllView) withObject:nil afterDelay:bottomToolViewTime];
    }
}

//value改变
- (void)sliderValueChanged:(UISlider *)sender {
    if ([BPValidateString([BPMediaPlayer sharePlayer].urlString) isEqualToString:BPValidateString(self.mediaModel.urlString)]) {
        self.isdragging = YES;
        CGFloat seconds = self.player.totalTime * sender.value;
        self.timeLabel.text = [NSString stringWithFormat:@"%@/%@",BPTimeString(seconds), self.player.totalTimeStr];
        [self setTimeLabelsWidthWithSeconds:seconds totalTime:_player.totalTime];
    }
}

#pragma 全屏事件
- (IBAction)backAction:(id)sender {
    [self fullScreen];
}

#pragma 全屏事件
- (IBAction)fullScreenAction:(id)sender {
    [self showBottomControllViewWithDelayHide:YES];
    [self fullScreen];
}

- (void)fullScreen {
    self.fullScreenButton.selected = !self.fullScreenButton.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(playerView:fullScreen:orientation:)]) {
        UIInterfaceOrientation orientation;
        [self setStatusBarHidden:NO];
        BPAppDelegate * appDelegate = (BPAppDelegate *)[UIApplication sharedApplication].delegate;
        if (self.fullScreenButton.selected ) {
            [self showTopControllViewWithHide:NO];
//            appDelegate.allowRotation = YES;//允许转成横屏
            [[BPDeviceOrientation shareInstance] screenExChangeView:nil forOrientation:UIInterfaceOrientationLandscapeRight animation:YES];
            orientation = UIInterfaceOrientationLandscapeRight;
        } else {
            [self showTopControllViewWithHide:YES];
//            appDelegate.allowRotation = NO;//不允许转成横屏
            [[BPDeviceOrientation shareInstance] screenExChangeView:nil forOrientation:UIInterfaceOrientationPortrait animation:YES];
            orientation = UIInterfaceOrientationPortrait;
        }
        [_delegate playerView:self fullScreen:self.fullScreenButton.selected orientation:orientation];
    }
}

#pragma 展示工具栏
- (void)showHideBottomControllView {
    if ([self isDisplayBottomControllView]) {
        [self hideBottomControllView]; //立即隐藏
    } else {
        [self showBottomControllViewWithDelayHide:YES];
    }
}

- (void)showBottomControllViewWithDelayHide:(BOOL)cancelHide {

    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideBottomControllView) object:nil];

    if (cancelHide) {
        [self performSelector:@selector(hideBottomControllView) withObject:nil afterDelay:bottomToolViewTime];
    }

    if (self.bottomToolViewBottomConstraint.constant == 0) {
        return;
    }
    
    [self setStatusBarHidden:NO];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomToolViewBottomConstraint.constant = 0;
        [self showTopControllViewWithHide:NO];
        [self layoutIfNeeded];
    }];
}

- (void)hideBottomControllView {
    if (self.bottomToolViewBottomConstraint.constant == -bottomToolViewSafeAreaHeight) {
        return;
    }
    [self setStatusBarHidden:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomToolViewBottomConstraint.constant = -bottomToolViewSafeAreaHeight;
        [self showTopControllViewWithHide:YES];
        [self layoutIfNeeded];
    }];
}

- (void)showTopControllViewWithHide:(BOOL)hide {
    //self.topToolView.hidden = hide;
    if (hide) {
        self.topToolViewTopConstraint.constant = -topToolViewHeight;
    } else {
        self.topToolViewTopConstraint.constant = 0;
    }
    if (self.fullScreenButton.selected) { //即将全屏
        self.backButton.hidden = NO;
    } else {
        self.backButton.hidden = YES;
    }
}

- (void)setStatusBarHidden:(BOOL)hidden {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (self.fullScreenButton.selected) {
        [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationSlide];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
#pragma clang diagnostic pop
}

- (BOOL)isDisplayBottomControllView {
    CGFloat constant = self.bottomToolViewBottomConstraint.constant;
    if (constant == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - 手势
// 添加平移手势，用来控制音量、亮度、快进快退
- (void)addPanGestureRecognizer {
    if (_pan) {
        return;
    }
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panDirection:)];
    self.pan.delegate  = self;
    [self.panGesureView addGestureRecognizer:self.pan];
    [_tap requireGestureRecognizerToFail:_pan];//只有当_pan识别失败的时候，_tap才能开始识别
}

- (void)panDirection:(UIPanGestureRecognizer *)pan {
    if (!_middlePlayButton.hidden) {
        return;
    }
    //根据在view上Pan的位置，确定是调音量还是亮度
    //获取当前页面手指触摸的点
    CGPoint locationPoint = [pan locationInView:self];
    // 根据上次和本次移动的位置，算出一个速率的point
    //这个很关键,这个速率直接决定了平移手势的快慢
    CGPoint veloctyPoint = [pan velocityInView:self];//返回拖拽手势的速度，值是每秒移过的point值，被分成水平和垂直两个分量。

    // 判断是垂直移动还是水平移动
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{ // 开始移动
            // 使用绝对值来判断移动的方向
            CGFloat x = fabs(veloctyPoint.x);
            CGFloat y = fabs(veloctyPoint.y);
            if (x > y) { // 水平移动
                self.centerToolMaskView.hidden = self.middleCurrrentTimeLabel.hidden = NO;
                self.direction = DirectionLeftOrRight;
                self.sumTime = self.player.currentTime;//记录滑动时播放器的时间
                [self.player pause];// 暂停视频播放
                [self showBottomControllViewWithDelayHide:NO];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged:{ // 正在移动
            switch (self.direction){
                case DirectionLeftOrRight:{
                    [self horizontalMoved:veloctyPoint.x]; // 水平移动的方法只要x方向的值
                    break;
                }
            }
            break;
        }
            
        case UIGestureRecognizerStateEnded:{ // 移动停止
            switch (self.direction) {
                case DirectionLeftOrRight:{//水平
                    self.centerToolMaskView.hidden = self.middleCurrrentTimeLabel.hidden = YES;
                    __weak typeof(self) weakSelf = self;
                    [self.player seekToTimePositionWithValue:_slider.value completionHandler:^(BOOL finished) {
                        if (finished) {
                        }
                    }];
                    [self showBottomControllViewWithDelayHide:YES];
                    self.sumTime = 0;//把sumTime滞空，不然会越加越多
                    break;
                }
            }
        }
    }
}

- (void)horizontalMoved:(CGFloat)value {
    // 快进快退的方法
    NSString *style = @"没有移动";
    if (value < 0) {//向左移动
        style = @"向左移动";
    }
    if (value > 0) {//向右移动
        style = @"向右移动";
    }
    if (value == 0) {
        return;
    }

    self.sumTime += value / 200;// 每次滑动需要叠加时间

    // 需要限定sumTime的范围
    NSTimeInterval totalMovieDuration = self.player.totalTime;
    if (totalMovieDuration == 0) {
        return;
    }
    if (self.sumTime > totalMovieDuration) {
        self.sumTime = totalMovieDuration;
    }
    if (self.sumTime < 0) {
        self.sumTime = 0;
    }

    CGFloat changingValue = self.sumTime/totalMovieDuration;//即将进行的播放的进度
    [self sliderValueChangingValue:changingValue isForward:style];
}

- (void)sliderValueChangingValue:(CGFloat)value isForward:(BOOL)forward {
    _slider.value = value;
    CGFloat seconds = self.player.totalTime * value;
    self.middleCurrrentTimeLabel.text = BPTimeString(seconds);
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@",BPTimeString(seconds), self.player.totalTimeStr];
    [self setTimeLabelsWidthWithSeconds:seconds totalTime:_player.totalTime];
}

- (void)verticalMoved:(CGFloat)value {

}

#pragma mark -  屏幕旋转操作
//强制转屏
- (void)setInterfaceOrientation {
    [self setInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
}

- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        // 从2开始是因为前两个参数已经被selector和target占用
        [invocation setArgument:&orientation atIndex:2];
        [invocation invoke];
    }
}

#pragma mark - 消息接收
/**
 拿初值：
 */
- (void)getInitializeValue {
    self.middlePlayButton.selected = self.playButton.selected = self.player.playButtonSelected;
    if (self.player.state == PlayerStatePlaying) {
        self.centerToolMaskView.hidden = self.middlePlayButton.hidden = YES;
        _coverImageView.hidden = YES;
    } else {
        self.centerToolMaskView.hidden = self.middlePlayButton.hidden = NO;
    }
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", _player.currentTimeStr, _player.totalTimeStr];
    [self setTimeLabelsWidthWithSeconds:_player.currentTime totalTime:_player.totalTime];
    self.slider.value = self.player.playProgress;
    self.progressView.progress = self.player.cacheProgress;
    if (self.player.bufferingState == BPPLayerBufferingStartAnimation) {
        [self.activityView startAnimating];
        self.activityView.hidden = NO;
    }else {
        [self.activityView stopAnimating];
        self.activityView.hidden = YES;
    }
}

- (void)resetInitializeValue {
    self.middlePlayButton.selected = self.playButton.selected = NO;
    self.centerToolMaskView.hidden = self.middlePlayButton.hidden = NO;
    _coverImageView.hidden = NO;
    self.timeLabel.text = [NSString stringWithFormat:@"00:00/00:00"];
    [self setTimeLabelsWidthWithSeconds:0 totalTime:0]; //改变timeLabel的宽度约束
    self.slider.value = .0f;
    self.progressView.progress = 0.f;
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
}

- (void)setTimeLabelsWidthWithSeconds:(NSInteger)curendSeconds totalTime:(NSInteger)totalTimeSeconds {
    NSInteger constraint = 110;
    if (totalTimeSeconds >= 3600) {
        constraint += 15;
    }
    
    if (curendSeconds >= 3600) {
        constraint += 15;
    }
    if (self.sliderTrailingConstraint.constant != constraint) {
        self.sliderTrailingConstraint.constant = constraint;
    }
}

/**
 注册消息，拿动态消息
 */
- (void)registerNotification:(BOOL)needRegisterNotification {
    if (needRegisterNotification) {
        //注册接收消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePlayStatusNotification:) name:BPAVplayerPlayStatusNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePlayProgressNotification:) name:BPAVplayerPlayProgressNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveBufferingAnimationNotification:) name:BPAVplayerBufferingAnimationNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveCachesProgressNotification:) name:BPAVplayerCachesProgressNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:BPAVplayerPlayStatusNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:BPAVplayerPlayProgressNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:BPAVplayerBufferingAnimationNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:BPAVplayerCachesProgressNotification object:nil];
    }
}

#pragma mark - 以下为通知方法回调
//播放状态消息
- (void)didReceivePlayStatusNotification:(NSNotification *)notification {
    NSDictionary *dic  = [notification valueForKey:@"userInfo"];
    BPAVPlayerState status  = [BPValidateDict(dic)[noti_userInfo_key_status] integerValue];
    if (status == PlayerStatePlaying) {
        self.playButton.selected = YES;
        self.coverImageView.hidden = YES;
    }else {
        self.playButton.selected = NO;
    }
    self.middlePlayButton.selected = self.playButton.selected;
    if (status == PlayerStatePaused) {
        //self.centerToolMaskView.hidden = self.middlePlayButton.hidden = NO;// 暂时根据自己的需求先不让它显示了
        [self showBottomControllViewWithDelayHide:NO];
    } else {
        self.centerToolMaskView.hidden = self.middlePlayButton.hidden = YES;
    }
    [self bringSubviewToFront:self.middlePlayButton];
    
    if (status == PlayerStateFinished) {
        if (_delegate && [_delegate respondsToSelector:@selector(playerView:finishedUrlString:)]) {
            [_delegate playerView:self finishedUrlString:self.mediaModel.urlString];
        }
    }
}

//播放进度，当前时间，总时间
- (void)didReceivePlayProgressNotification:(NSNotification *)notification {
    NSDictionary *dic  = [notification valueForKey:@"userInfo"];
    NSString *totalTime = BPValidateString(BPValidateDict(dic)[noti_userInfo_key_totalTime]);
    NSString *currentTime  = BPValidateString(BPValidateDict(dic)[noti_userInfo_key_currentTime]);
    CGFloat value  = [BPValidateNumber(BPValidateDict(dic)[noti_userInfo_key_progress]) doubleValue];
    if (!self.isdragging) {
        self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", currentTime,totalTime];
        [self setTimeLabelsWidthWithSeconds:_player.currentTime totalTime:_player.totalTime];
        _slider.value = value;
    }
}

//缓冲动画通知
- (void)didReceiveBufferingAnimationNotification:(NSNotification *)notification {
    NSDictionary *dic = [notification valueForKey:@"userInfo"];
    BPAVPlayerBufferingAnimation status = [BPValidateDict(dic)[noti_userInfo_key_bufferingAnimation] integerValue];
    if (status == BPPLayerBufferingStartAnimation) {
        [_activityView startAnimating];
        _activityView.hidden = NO;
    }else {
        [_activityView stopAnimating];
        _activityView.hidden = YES;
    }
}

//缓冲进度
- (void)didReceiveCachesProgressNotification:(NSNotification *)notification {
    NSDictionary *dic = [notification valueForKey:@"userInfo"];
    CGFloat progress = [BPValidateNumber(BPValidateDict(dic)[noti_userInfo_key_cachesProgress]) doubleValue];
    self.progressView.progress = progress;
}

#pragma mark - 初始化方法
- (void)initializeViews {
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor blackColor];
    UIColor *blackColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    _panGesureView.backgroundColor = [UIColor blackColor];
    
    //_topToolView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"player_top"].CGImage);
    //_bottomToolView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"player_bottom"].CGImage);
    
    _topToolView.backgroundColor = kClearColor;
    //_topToolView.userInteractionEnabled = NO;
    _backButton.showsTouchWhenHighlighted = NO;

    _bottomToolView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.bottomToolView.userInteractionEnabled = YES;
    self.bottomToolView.layer.masksToBounds = YES;
    
    self.centerToolMaskView.backgroundColor = [blackColor colorWithAlphaComponent:0.5];
    self.middleCurrrentTimeLabel.hidden = YES;
    
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
    
    [self showTopControllViewWithHide:YES];

    _middlePlayButton.showsTouchWhenHighlighted = NO;
    [_middlePlayButton setImage:[UIImage imageNamed:@"player_middlePlay"] forState:UIControlStateNormal];
    [_middlePlayButton setTitle:kPlacedString forState:UIControlStateNormal];
    [_middlePlayButton setImage:[UIImage imageNamed:@"player_middlePause"] forState:UIControlStateSelected];
    [_middlePlayButton setTitle:kPlacedString forState:UIControlStateSelected];
    
    //检测
    Reachability *reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self getNetworkReachabilityStatus:[reachability currentReachabilityStatus]];
    
    _playButton.showsTouchWhenHighlighted = NO;
    [_playButton setImage:[UIImage imageNamed:@"play_player"] forState:UIControlStateNormal];
    [_playButton setImage:[UIImage imageNamed:@"pause_player"] forState:UIControlStateSelected];
    
    _slider.userInteractionEnabled = YES;
    _slider.value = .0f;
    [_slider addTarget:self action:@selector(sliderPause:) forControlEvents:UIControlEventTouchDown];//按下
    [_slider addTarget:self action:@selector(sliderPlay:) forControlEvents:UIControlEventTouchUpInside];//抬起
    [_slider addTarget:self action:@selector(sliderPlay:) forControlEvents:UIControlEventTouchUpOutside];//在控件边界范围外抬起
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderCancel:) forControlEvents:UIControlEventTouchCancel];
    [_slider setThumbImage:[UIImage imageNamed:@"player_slider"] forState:UIControlStateNormal];
    _slider.minimumTrackTintColor = [UIColor blackColor];
    _slider.maximumTrackTintColor = [UIColor blackColor];
    _slider.minimumTrackTintColor = kThemeColor;//小于滑块当前值滑块条的颜色
    _slider.maximumTrackTintColor = [UIColor clearColor];//大于滑块当前值滑块条的颜色

    [_progressView setProgressTintColor:[UIColor lightGrayColor]];//填充部分的颜色 左边的颜色
    [_progressView setTrackTintColor:[UIColor whiteColor]];//未填充部分的颜色 右边的颜色
    _progressView.progress = 0.f;
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    _timeLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _timeLabel.textColor = [UIColor whiteColor];
    
    _fullScreenButton.showsTouchWhenHighlighted = NO;
    [_fullScreenButton setImage:[UIImage imageNamed:@"player_unFullScreen"] forState:UIControlStateNormal];
    [_fullScreenButton setImage:[UIImage imageNamed:@"player_fullScreen"] forState:UIControlStateSelected];
    [self.fullScreenButton bp_setEnlargeEdgeWithTop:3 right:0 bottom:0 left:3];
    
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _activityView.color = kThemeColor;
    CGAffineTransform transform = CGAffineTransformMakeScale(.7f, .7f);
//    _activityView.transform = transform;
    _activityView.hidden = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHideBottomControllView)];
    _tap = tap;
    [self.panGesureView addGestureRecognizer:tap];
}

#pragma lazy methods
- (BPMediaPlayer *)player {
    if (!_player) {
        _player = [BPMediaPlayer sharePlayer];
    }
    return _player;
}

#pragma 网络监测
- (void)configNetworkReachabilityManager {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkReachabilityStatus:) name:kChangedNotification object:nil];
}

- (void)networkReachabilityStatus:(NSNotification *)notification {
    Reachability *reach = notification.object;
    [self getNetworkReachabilityStatus:reach.currentReachabilityStatus];
}

- (void)getNetworkReachabilityStatus:(NetworkStatus)status {

    // 一共有四种状态
    switch (status) {
        case ReachableViaWWAN: //流量播放
            BPLog(@"ReachableViaWWAN = 蜂窝移动网络");
//            if ([BPFileManager isFileExists:self.mediaModel.cachePath]) {    //有缓存播放缓存文件
//                [self setMiddlePlayButtonStyle:BPMiddlePlayButtonStyle_WIFIPlay];
//            } else {
                [self.player pause];
                [self setMiddlePlayButtonStyle:BPMiddlePlayButtonStyle_WWANPlay];
//            }
            break;
            
        case ReachableViaWiFi:
            BPLog(@"ReachableViaWiFi = WiFi");
            [self setMiddlePlayButtonStyle:BPMiddlePlayButtonStyle_WIFIPlay];
            break;
            
        case NotReachable:
            BPLog(@"NotReachable = 未连接");
            break;
    }
}

- (void)setMiddlePlayButtonStyle:(BPMiddlePlayButtonStyle)style {
    switch (style) {
        case BPMiddlePlayButtonStyle_WIFIPlay: { //WIFI播放
            _wwanLabel.hidden = YES;
        }
            break;
            
        case BPMiddlePlayButtonStyle_WWANPlay: { // 流量播放
            _wwanLabel.hidden = self.centerToolMaskView.hidden = self.middlePlayButton.hidden = NO;
        }
            break;
            
        case BPMiddlePlayButtonStyle_NoNetPlay: {// 无网
            //self.centerToolMaskView.hidden = self.middlePlayButton.hidden = NO;
            //[_middlePlayButton setImage:[UIImage imageNamed:@"player_middlePlay"] forState:UIControlStateNormal];
            //[_middlePlayButton setTitle:@"无网络" forState:UIControlStateNormal];
        }
            break;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
