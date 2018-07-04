//
//  BPDownLoadGeneralView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPDownLoadMacro.h"
#import "BPAudioModel.h"
#import "BPDownLoadItem.h"

@class BPDownLoadGeneralView;

@protocol BPDownLoadGeneralViewDelegate <NSObject>
@optional

- (void)downLoad:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)item;

@end


@interface BPDownLoadGeneralView : UIView

- (void)setItem:(BPAudioModel *)item status:(BPDownLoadItemStatus)status;

@property (nonatomic,weak) id <BPDownLoadGeneralViewDelegate> delegate;

@end
