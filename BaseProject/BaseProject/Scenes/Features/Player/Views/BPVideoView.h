//
//  BPVideoView.h
//  WPSExcellentClass
//
//  Created by Ryan on 2018/10/21.
//  Copyright © 2018 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BPMediaModel;
@class BPVideoView;

NS_ASSUME_NONNULL_BEGIN

static CGFloat kPlayerViewHeight = 193.f;

@protocol BPVideoViewDelegate <NSObject>

- (void)playerView:(BPVideoView *)playerView fullScreen:(BOOL)isFullScreen orientation:(UIInterfaceOrientation)orientation; //全屏手势代理

@optional

- (void)playerView:(BPVideoView *)playerView finishedUrlString:(NSString *)urlString;//播放完成代理

@end

@interface BPVideoView : UIView
@property (nonatomic, strong) BPMediaModel *mediaModel; //为了判断，并不会给播放器赋值
@property (assign, nonatomic,readonly)  BOOL isFullScreen; //获取是否全屏
@property (nonatomic,weak)  id<BPVideoViewDelegate> delegate;

- (void)fullScreen;

@end

NS_ASSUME_NONNULL_END
