//
//  BPDownLoadGeneralView.h
//  BaseProject
//
//  Created by Ryan on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPDownLoadMacro.h"
#import "BPAudioModel.h"
#import "BPDownLoadItem.h"

@class BPDownLoadGeneralView;

@protocol BPDownLoadGeneralViewDelegate <NSObject>
@optional

- (void)downLoad:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model;
- (void)pause:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model;
- (void)resume:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model;
- (void)stop:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model;

@end


@interface BPDownLoadGeneralView : UIView

- (void)setModel:(BPAudioModel *)model;
- (void)setItem:(BPDownLoadItem *)item;

@property (nonatomic,weak) id <BPDownLoadGeneralViewDelegate> delegate;

@end
