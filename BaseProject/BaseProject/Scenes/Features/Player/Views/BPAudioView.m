//
//  BPAudioView.m
//  WPSExcellentClass
//
//  Created by 余凯 on 2018/10/17.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "BPAudioView.h"
#import "UIView+BPShadow.h"
#import "BPMediaPlayer.h"
#import "BPGradualAnimationButton.h"

static NSString *kPlayerAudioLastMediaCacheName   = @"PlayerAudioLastMediaCache.data";
static NSString *kPlayerAudioLastCourseModelCacheName   = @"PlayerAudioLastCourseModelCache.data";

@interface BPAudioView ()
@property (weak, nonatomic) IBOutlet UIView *playerContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *courseName;
@property (weak, nonatomic) IBOutlet BPGradualAnimationButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playButtonTrailingConstraint;
@property (strong, nonatomic) BPMediaPlayer *player;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@end

@implementation BPAudioView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeViews];
    [self registerNotification]; //注册消息，拿动态消息
}

- (void)setType:(BPFloatingAudioPlayerType)type {
    
    _type = type;
    
    switch (type) {
            
        case BPFloatingAudioPlayerNone:{
            [_tap removeTarget:self action:@selector(tapSwitchEvent)];
        }
            break;
            
        case BPFloatingAudioPlayerGlobal:{
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSwitchEvent)];
            _tap = tap;
            [self addGestureRecognizer:tap];
            self.playButtonTrailingConstraint.constant = 15;
        }
            break;
            
        case BPFloatingAudioPlayerBriefReport:{
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSwitchEvent)];
            _tap = tap;
            [self addGestureRecognizer:tap];
            self.playButtonTrailingConstraint.constant = 15;
        }
            break;
    }
}

- (void)setModel:(BPMediaModel *)model {
//    _chapterModel = chapterModel;
//    self.headImage.imageUrl = chapterModel.teacherImage;
//    self.courseName.text = chapterModel.chapterTitle; //大标题显示章节名
//    self.progressLabel.text = [NSString stringWithFormat:@"00:00 | %@  ", BPTimeString([BPValidateString(chapterModel.mediaLength) integerValue])];
//    self.progressView.progress = 0;
//    self.chapterLabel.text = chapterModel.courseName;
}

/**
 拿初值：
 */
- (void)getInitializeValue {
    if (self.player.playButtonSelected) {
        [self.playButton setImage:[UIImage imageNamed:@"icon_hiddenplay_newplay"] forState:UIControlStateNormal];
        self.closeButton.hidden = YES;
    } else {
        [self.playButton setImage:[UIImage imageNamed:@"icon_hiddenPlay_pause"] forState:UIControlStateNormal];
        self.closeButton.hidden = NO;
    }
    
    if (self.player.totalTime == 0) {
//        self.progressLabel.text = [NSString stringWithFormat:@"%@ | %@  ",self.player.currentTimeStr ,BPTimeString([BPValidateString(_chapterModel.mediaLength) integerValue])];
    } else {
        self.progressLabel.text = [NSString stringWithFormat:@"%@ | %@  ",self.player.currentTimeStr ,self.player.totalTimeStr];
    }


    if (self.player.bufferingState == BPPLayerBufferingStartAnimation && self.player.state == PlayerStatePlaying) {
        [_playButton startLoading];
    } else {
        [_playButton stopLoading];
    }
    /*
     self.headImage.imageUrl = self.player.chapterModel.teacherImage;
     self.courseName.text = self.player.chapterModel.chapterTitle; //大标题显示章节名
     [self setProgress:self.player.currentTimeStr totalTime:_player.totalTimeStr progress:self.player.playProgress];
     self.chapterLabel.text = self.player.chapterModel.courseName;
     
     if (self.player.state == BPPLayerBufferingStartAnimation) {
     [_playButton startLoading];
     } else {
     [_playButton stopLoading];
     }
     */
}

#pragma mark -播放状态消息
- (void)didReceivePlayStatusNotification:(NSNotification *)notification {
    NSDictionary *dic  = [notification valueForKey:@"userInfo"];
    BPAVPlayerState status  = [BPValidateDict(dic)[noti_userInfo_key_status] integerValue];
    if (status == PlayerStatePlaying) {
        //show pause icon
        self.closeButton.hidden = YES;
        [self.playButton setImage:[UIImage imageNamed:@"icon_hiddenplay_newplay"] forState:UIControlStateNormal];
    }else {
        if (_type == BPFloatingAudioPlayerBriefReport || _type == BPFloatingAudioPlayerGlobal) {
            self.closeButton.hidden = NO;
        } else {
            self.closeButton.hidden = YES;
        }
        [self.playButton setImage:[UIImage imageNamed:@"icon_hiddenPlay_pause"] forState:UIControlStateNormal];
    }


}

- (void)didReceivePlayProgressNotification:(NSNotification *)notification {
    NSDictionary *dic  = [notification valueForKey:@"userInfo"];
    NSString *totalTime  = BPValidateString(BPValidateDict(dic)[noti_userInfo_key_totalTime]);
    NSString *currentTime  = BPValidateString(BPValidateDict(dic)[noti_userInfo_key_currentTime]);
    CGFloat value  = [BPValidateNumber(BPValidateDict(dic)[noti_userInfo_key_progress]) doubleValue];
    
    if (self.player.totalTime == 0) {
//        self.progressLabel.text = [NSString stringWithFormat:@"%@ | %@  ",currentTime ,BPTimeString([BPValidateString(_chapterModel.mediaLength) integerValue])];
    } else {
        self.progressLabel.text = [NSString stringWithFormat:@"%@ | %@  ",currentTime ,totalTime];
    }
}

- (void)didReceivePlayBufferingAnimationNotification:(NSNotification *)notification {
    NSDictionary *dic = [notification valueForKey:@"userInfo"];
    BPAVPlayerBufferingAnimation status = [BPValidateDict(dic)[noti_userInfo_key_bufferingAnimation] integerValue];
    if (status == BPPLayerBufferingStartAnimation && self.player.state == PlayerStatePlaying) {
        [_playButton startLoading];
    } else {
        [_playButton stopLoading];
    }
}

- (IBAction)onLIstButtonClicked:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(onClickList)]) {
        [self.delegate onClickList];
    }
}

- (IBAction)onPlayButtonClicked:(id)sender {
 
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    BPMediaModel *mediaModel = nil;
    
    [self.player prepareWithMediaModel:mediaModel];
//    [self.player playerWithCourseModel:_courseModel chapterModel:_chapterModel];
    
    [self registerNotification]; //注册消息，拿动态消息

    [self.player playPauseAction];// 播放暂停事件

    
   
}

#pragma mark - 点击事件
- (void)tapSwitchEvent {
    [self showContentViewController];
}

- (IBAction)closeAction:(id)sender {
    [self.player resetPlayer];

}

#pragma mark - 跳往详情
- (void)showContentViewController {


}

#pragma mark - 初始化其他
- (void)initializeViews {
    self.backgroundColor = kClearColor;
//    [self.playerContainerView configShadow:[UIColor colorWithHexString:@"0x8B98A1"] withOffset:CGSizeMake(0, 1) radius:10 opacity:0.5];
//    self.playerContainerView.layer.cornerRadius = 5;
//    self.headImage.layer.cornerRadius = 5;
//    self.courseName.textColor = [UIColor colorWithHexString:@"0x333333"];
//    self.progressLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
//    self.chapterLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
//
//    self.progressView.progressTintColor = [UIColor colorWithHexString:@"0xF48F00"];
//    self.progressView.progress = 0.0;
//    [self.playButton setImage:[UIImage imageNamed:@"icon_hiddenplay_newplay"] forState:UIControlStateNormal];
//
//    self.listButton.layer.cornerRadius = 16;
//    self.listButton.layer.borderWidth = 1;
//    self.listButton.layer.borderColor = [UIColor colorWithHexString:@"0xEBEBEB"].CGColor;
//    self.closeButton.hidden = YES;
//    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
//    self.headImage.layer.masksToBounds = YES;
}


- (void)registerNotification {
    //注册接收消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePlayStatusNotification:) name:BPAVplayerPlayStatusNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePlayProgressNotification:) name:BPAVplayerPlayProgressNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivePlayBufferingAnimationNotification:) name:BPAVplayerBufferingAnimationNotification object:nil];
}

- (BPMediaPlayer *)player {
    if (!_player) {
        _player = [BPMediaPlayer sharePlayer];
    }
    return _player;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
