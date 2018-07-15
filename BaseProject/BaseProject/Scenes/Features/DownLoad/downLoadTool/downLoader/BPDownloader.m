//
//  BPDownloader.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownloader.h"
#import <AFNetworking.h>
#import "BPDownLoad.h"
#import "BPDownLoadItem.h"
//#import "Foundation+Log.h"
#import "NSObject+Log.h"

static NSInteger maxCount = 3;

@interface BPDownloader()
@property (nonatomic,strong) NSMutableArray *allItems; // 存放外界提供所有对象的数组；
@property (nonatomic,strong) NSMutableArray *needDownLoadArray; // 存放需要下载对象的数组，过滤掉已经下载的；BPDownLoadItemNone||BPDownLoadItemFail
@property (nonatomic,strong) NSMutableArray *downLoadingArray; // 存放马上执行任务对象的数组；
@property (nonatomic,strong) NSMutableDictionary *tasksDict; // 存放task的字典
@end

static BPDownloader *downloader = nil;
static dispatch_group_t downloadGroup;

@implementation BPDownloader

+ (BPDownloader *)shareDownloader {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [[BPDownloader alloc] init];
        downloader.maxCount = maxCount;
        downloadGroup = dispatch_group_create();
    });
    return downloader;
}

#pragma mark - 私有方法
//分析处理对象
- (void)p_analyzeItems:(NSArray<BPDownLoadItem *> *)items {
    [self p_filteringItems:items];
    [self p_addIntoNeedDownLoadArray];
    [self p_addIntoDownLoadingArray];
}

- (void)p_filteringItems:(NSArray<BPDownLoadItem *> *)items {
    //初次处理对象去重：如果下载队列里已经包含某对象，对该对象进行过滤
    [items enumerateObjectsUsingBlock:^(BPDownLoadItem * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (self.allItems.count) {
            
            __block BOOL isExist = NO;
            [self.allItems enumerateObjectsUsingBlock:^(BPDownLoadItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.downLoadUrl isEqualToString:item.downLoadUrl] && item.status == BPDownLoadItemNone) {
                    isExist = YES;
                    *stop = YES;
                }
            }];
            if (!isExist) {
                BPLog(@"初次处理对象去重");
                [self.allItems addObject:obj];
            }
        }else {
            [self.allItems addObject:obj];
            BPLog(@"初次处理对象去重");
        }
    }];
}

- (void)p_addIntoNeedDownLoadArray {
    
    // 进一步处理对象：将未为下载或者下载失败的对象放到下载队列里
    [self.allItems enumerateObjectsUsingBlock:^(BPDownLoadItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (item.status == BPDownLoadItemNone || item.status == BPDownLoadItemFail) {
            [self p_handleItem:item status:BPDownLoadItemWait notification:kDownloadStatusNotification];
            [self.needDownLoadArray addObject:item];
            BPLog(@"将未为下载或者下载失败的对象放到下载队列里");
        }
    }];
}

- (void)p_addIntoDownLoadingArray {
    
    // 处理对象：将对象放到马上执行的队列里
    [self.needDownLoadArray enumerateObjectsUsingBlock:^(BPDownLoadItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 限制下载数量
        if (self.downLoadingArray.count > self.maxCount-1) {
            *stop = YES;
            return;
        }
        
        //如果下一个是待下载，将它放到正在下载的队列里
        if (item.status == BPDownLoadItemWait) {
            BPLog(@"将对象放到马上执行的队列里");
            [self.downLoadingArray addObject:item];
        }
    }];
}

- (void)p_handleMission {
    // 执行下载任务
    for (BPDownLoadItem *item in self.downLoadingArray) {
        if (item.status == BPDownLoadItemWait ) { //如果是待下载里面去下载
            
            NSURLSessionDownloadTask *downloadTask = self.tasksDict[[BPDownloadUtils md5ForString:item.identify]];
            if (downloadTask) {
                if (downloadTask.state == NSURLSessionTaskStateSuspended) {
                    [downloadTask resume];;
                }
            } else {
                dispatch_group_enter(downloadGroup);
                [self p_downLoadWithItem:item completionHandler:^(BOOL result) {
                    // 任务完成：将对象从数据源里移除,并移除任务
                    [self.tasksDict removeObjectForKey:[BPDownloadUtils md5ForString:item.downLoadUrl]];
                    [self.needDownLoadArray removeObject:item];
                    [self.downLoadingArray removeObject:item];
                    dispatch_group_leave(downloadGroup);
                    //如果待下载的队列里还有任务，继续添加
                    [self p_nextDownLoadWhenLastEnd];
                    BPLog(@"如果待下载的队列里还有任务，继续添加");
                }];
            }
        }
    }
    
    //所有子任务均完成
    dispatch_group_notify(downloadGroup, dispatch_get_global_queue(0, 0), ^{
        
    });
}

//下载任务
- (void)p_downLoadWithItem:(BPDownLoadItem *)item completionHandler:(void (^)(BOOL result))result {
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.cactus.BaseProject"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.allowsCellularAccess = YES;

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:item.downLoadUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat downLoadProgress = downloadProgress.completedUnitCount * 1.00 / downloadProgress.totalUnitCount;
            
            item.progress = @(downLoadProgress).stringValue;
            item.completedUnitCount = @(downloadProgress.completedUnitCount).stringValue;
            item.totalUnitCount = @(downloadProgress.totalUnitCount).stringValue;
            
            [self p_handleItem:item status:BPDownLoadItemDowning notification:kDownloadStatusNotification];
            [self p_handleItem:item status:BPDownLoadItemDowning notification:kDownloadDownLoadProgressNotification];
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[BPDownloadUtils md5ForString:item.downLoadUrl]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"File downloaded to: %@", filePath);
        
        if(error) {
            if (error.code == NSURLErrorCancelled) {
            }
            item.status = BPDownLoadItemFail;
            if (result) {
                result(0);
            }
        }else {
            item.status = BPDownLoadItemSuccess;
            if (result) {
                result(1);
            }
        }
        [self p_handleItem:item status:item.status notification:kDownloadStatusNotification];
    }];
    
    [downloadTask resume];
    [self.tasksDict setObject:downloadTask forKey:[BPDownloadUtils md5ForString:item.downLoadUrl]];
    BPLog(@"%@",downloadTask);
    
}

//当上一个任务完成或者暂停之后：如果待下载的队列里还有任务，继续添加并执行下载或者恢复
- (void)p_nextDownLoadWhenLastEnd {
    if (self.needDownLoadArray.count) {
        BPLog(@"继续下载");
        [self p_addIntoDownLoadingArray];
        [self p_handleMission];
    }else {
        BPLog(@"全部下载完毕");
    }
}

//单个下载
- (void)downloadItem:(BPDownLoadItem *)item {
    [self downloadItems:@[item]];
}

//批量下载
- (void)downloadItems:(NSArray<BPDownLoadItem*> *)items {

    // 分析对象，并处理
    [self p_analyzeItems:items];
    
    // 执行任务
    [self p_handleMission];
}

//暂停下载
- (void)pauseDownloadForItem:(id<NSCopying>)itemId {

    NSURLSessionDownloadTask *downloadTask = self.tasksDict[[BPDownloadUtils md5ForString:itemId]];
    
    if (downloadTask) {
        
        if (downloadTask.state == NSURLSessionTaskStateSuspended) {
            return;
        }
        [downloadTask suspend];

        BPLog(@"暂停下载");

        [self.allItems enumerateObjectsUsingBlock:^(BPDownLoadItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.downLoadUrl isEqualToString:(NSString *)itemId]) {//找到这个item
                [self.downLoadingArray removeObject:item];//从正在下载的队列里去除
                [self p_handleItem:item status:BPDownLoadItemPause notification:kDownloadStatusNotification];
                [self p_nextDownLoadWhenLastEnd];//查找下一个需要下载的item
                *stop = YES;
            }
        }];
    }
}

//恢复下载
- (void)resumeDownloadForItem:(id<NSCopying>)itemId {
    
    NSURLSessionDownloadTask *downloadTask = self.tasksDict[[BPDownloadUtils md5ForString:itemId]];
    
    if (downloadTask) {
        if (downloadTask.state == NSURLSessionTaskStateRunning) {
            return;
        }
        [self.allItems enumerateObjectsUsingBlock:^(BPDownLoadItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.downLoadUrl isEqualToString:(NSString *)itemId]) { // 找到这个item
                *stop = YES;
                [self p_handleItem:item status:BPDownLoadItemWait notification:kDownloadStatusNotification];
                
                // 如果下载队列不足，则加入下载队列，进行下载；如果足了，等待下载任务完成
                [self p_addIntoDownLoadingArray]; // 加入下载队列
                
                [self.downLoadingArray enumerateObjectsUsingBlock:^(BPDownLoadItem *downLoadItem, NSUInteger idx, BOOL * _Nonnull stop) {
                    // 如果存在了立即下载的队列里
                    if ([downLoadItem.downLoadUrl isEqualToString:(NSString *)itemId]) {
                        [downloadTask resume];
                        *stop = YES;
                        BPLog(@"恢复下载:正在下载");
                    }
                }];
            }
        }];
    }
}

//取消下载
- (void)cancelDownloadForItem:(id<NSCopying>)itemId {
    NSURLSessionDownloadTask *downloadTask = self.tasksDict[[BPDownloadUtils md5ForString:itemId]];
    if (downloadTask) {
        [downloadTask cancel];
        __block BPDownLoadItem *item1;
        [self.allItems enumerateObjectsUsingBlock:^(BPDownLoadItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([item.downLoadUrl isEqualToString:(NSString *)itemId]) {
                item1 = item;
            }
        }];
        [self p_handleItem:item1 status:BPDownLoadItemNone notification:kDownloadStatusNotification];
    }
}

//获取下载中的任务
- (NSArray<BPDownLoadItem *> *)downloadingItems {
    return self.downLoadingArray.copy;
}

//获取已下载的任务
- (NSArray<BPDownLoadItem*> *)downloadedItems {
    return self.downLoadingArray.copy;
}

//根据id获取item
- (BPDownLoadItem *)ItemForItem:(BPDownLoadItem *)item {
    __block BPDownLoadItem *item1;
    [self.allItems enumerateObjectsUsingBlock:^(BPDownLoadItem *item2, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([item2.downLoadUrl isEqualToString:item.downLoadUrl]) { // 找到这个item
            *stop = YES;
            item1 = item2;

        }
    }];
    return item1;
}

//根据id获取已下载的item
- (BPDownLoadItem *)downloadedItemForItem:(BPDownLoadItem *)item {
    return nil;
}

//是否下载过指定id的item
- (BOOL)didDownloadedItem:BPDownLoadItem {
    return nil;
}

- (void)p_handleItem:(BPDownLoadItem *)item status:(BPDownLoadItemStatus)status notification:(NSString *)notification {
    item.status = status;
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:item userInfo:nil];
}

#pragma mark - 懒加载
- (NSMutableArray *)allItems {
    if (!_allItems) {
        _allItems = @[].mutableCopy;
    }
    return _allItems;
}

- (NSMutableArray *)needDownLoadArray {
    if (!_needDownLoadArray) {
        _needDownLoadArray = @[].mutableCopy;
    }
    return _needDownLoadArray;
}

- (NSMutableArray *)downLoadingArray {
    if (!_downLoadingArray) {
        _downLoadingArray = @[].mutableCopy;
    }
    return _downLoadingArray;
}

- (NSMutableDictionary *)tasksDict {
    if (!_tasksDict) {
        _tasksDict = @{}.mutableCopy;
    }
    return _tasksDict;
}

@end
