//
//  BPAudioView.h
//  WPSExcellentClass
//
//  Created by 余凯 on 2018/10/17.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMediaModel.h"

@class BPAudioView;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BPFloatingAudioPlayerType) {
    BPFloatingAudioPlayerNone,
    BPFloatingAudioPlayerGlobal,//是否作为全局播放器
    BPFloatingAudioPlayerBriefReport,
};

static CGFloat floatingPlayerHeight = 70;

@protocol BPAudioViewDelegate <NSObject>

- (void)onClickList;

@end

@interface BPAudioView : UIView

@property (nonatomic, weak) id<BPAudioViewDelegate> delegate;

@property (nonatomic,assign) BPFloatingAudioPlayerType type;

@property (nonatomic,strong) BPMediaModel *model;

@property (nonatomic,assign) NSInteger lastTime;

- (void)getInitializeValue;

@end

NS_ASSUME_NONNULL_END
