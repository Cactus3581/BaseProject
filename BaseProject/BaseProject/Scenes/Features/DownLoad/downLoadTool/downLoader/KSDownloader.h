//
//  KSDownloader.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPDownLoadItem;


@protocol BPDownloaderDelegate <NSObject>

@optional
- (void)downloadItemStatusChanged:(BPDownLoadItem *)item;
- (void)downloadItem:(BPDownLoadItem *)item downloadedSize:(int64_t)downloadedSize totalSize:(int64_t)totalSize;
- (void)downloadItem:(BPDownLoadItem *)item speed:(NSUInteger)speed speedDesc:(NSString *)speedDesc;
@end

@interface KSDownloader : NSObject

//获取下载管理对象（单例）
+ (KSDownloader *)shareDownloader;

//开始下载:以单个的形式
- (void)downloadItem:(BPDownLoadItem *)item;

//批量下载
- (void)downloadItems:(NSArray<BPDownLoadItem*> *)items;

//暂停下载
- (void)pauseDownloadForItem:(id<NSCopying>)itemId;

//恢复下载
- (void)resumeDownloadForItem:(id<NSCopying>)itemId;

//取消下载
- (void)cancelDownloadForItem:(id<NSCopying>)itemId;

//获取下载中的任务
- (NSArray<BPDownLoadItem *> *)downloadingItems;

//获取已下载的任务
- (NSArray<BPDownLoadItem*> *)downloadedItems;

//根据id获取已下载的item
- (BPDownLoadItem *)downloadedItemForItem:(BPDownLoadItem *)item;

//是否下载过指定id的item
- (BOOL)didDownloadedItem:BPDownLoadItem;

//限制最大并行下载数量
@property (nonatomic,assign) NSInteger maxCount;

@property (nonatomic, weak) id <BPDownloaderDelegate> delegate;

@end
