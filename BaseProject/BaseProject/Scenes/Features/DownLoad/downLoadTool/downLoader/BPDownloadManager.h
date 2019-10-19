//
//  BPDownloadManager.h
//  BaseProject
//
//  Created by Ryan on 2019/5/18.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPDownLoadItem.h"

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN  NSString * const BPDownloadManagerProgressNotification;//下载进度
UIKIT_EXTERN  NSString * const BPDownloadManagerFinishNotification;//下载完成

typedef void(^cancelBlk)(NSData *resumeData);

@interface BPDownloadManager : NSObject

+ (BPDownloadManager *)shareManager;

- (BPDownLoadItem *)getInitializeValues:(BPDownLoadItem *)item;

- (void)downloadWithItem:(BPDownLoadItem *)item;

- (void)cancelWithItem:(BPDownLoadItem *)item cancelBlk:(cancelBlk)cancelBlk;

- (void)deleteFileWithItem:(BPDownLoadItem *)item;

@end

NS_ASSUME_NONNULL_END
