//
//  BPDownloadManager.m
//  BaseProject
//
//  Created by Ryan on 2019/5/18.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPDownloadManager.h"
#import "NSFileManager+BPPaths.h"
#import "NSString+BPAdd.h"
#import "NSFileManager+BPAdd.h"

NSString *const BPDownloadManagerProgressNotification = @"BPDownloadManagerProgressNotification";
NSString *const BPDownloadManagerFinishNotification = @"BPDownloadManagerFinishNotification";

@interface BPDownloadManager ()<NSURLSessionDownloadDelegate,NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, copy) NSString *resumeDataCachePath;

@property (nonatomic, strong) BPDownLoadItem *item;

@end

// 一般单个下载->断点下载->（后台下载）->批量下载->与TableView结合

static BPDownloadManager *downloadManager = nil;

@implementation BPDownloadManager

+ (BPDownloadManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloadManager = [[BPDownloadManager alloc] init];
    });
    return downloadManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _resumeDataCachePath = [documentsPath stringByAppendingPathComponent:@"resumeDataCache"];
        [NSFileManager creatDirectoryWithPath:_resumeDataCachePath];
        
        //进入前台通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        //退到后台通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        
        //程序被杀死时调用,保存数据。
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillTerminateNotification:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - 系统活跃通知
// 程序被杀死
- (void)applicationWillTerminateNotification:(NSNotification*)notification {
    if (_item && _item.status == BPDownLoadItemDowning) {
        BPLog(@"程序将要退出wx");

        [self cancelWithItem:_item cancelBlk:^(NSData * _Nonnull resumeData) {
            
        }];
    }
}

// 进入前台
- (void)applicationWillEnterForegroundNotification:(NSNotification*)notification {
    
}

// 进入后台
- (void)applicationDidEnterBackgroundNotification:(NSNotification*)notification {
    
}

#pragma mark - 获取初始值（页面一进来的时候）
- (BPDownLoadItem *)getInitializeValues:(BPDownLoadItem *)item {
    
    if (!item || !BPValidateString(item.downLoadUrl).length) {
        return nil;
    }
    
    
    if (_item) {
        
        if ([item.downLoadUrl isEqualToString:_item.downLoadUrl]) {
            item = _item;
            return item;
        }
        
    } else {
        
        NSString *path = [item.filepath stringByAppendingPathComponent:[item.downLoadUrl md5String]];
        BOOL isExecutable =  [NSFileManager fileIsExistOfPath:path];
        if (isExecutable) {
            item.status = BPDownLoadItemFinish;
            return item;
        } else {
            // 查找本地resumate
            NSString *resumeDataCachePath = [_resumeDataCachePath stringByAppendingPathComponent:[item.downLoadUrl md5String]];
            BOOL isResumate = [NSFileManager fileIsExistOfPath:resumeDataCachePath];
            if (isResumate) {
                item.status = BPDownLoadItemPause;
                return item;
            }
        }
    }

    return nil;
}

#pragma mark - 下载任务
- (void)downloadWithItem:(BPDownLoadItem *)item {
    
    if (!item || !BPValidateString(item.downLoadUrl).length) {
        return;
    }
    
    
    if (_item) {
        
        if ([item.downLoadUrl isEqualToString:_item.downLoadUrl]) {
            item = _item;
        }
        
    } else {
        NSString *path = [item.filepath stringByAppendingPathComponent:[item.downLoadUrl md5String]];
        BOOL isExecutable =  [NSFileManager fileIsExistOfPath:path];
        if (isExecutable) {
            item.status = BPDownLoadItemFinish;
        } else {
            // 查找本地resumate
            NSString *resumeDataCachePath = [_resumeDataCachePath stringByAppendingPathComponent:[item.downLoadUrl md5String]];
            BOOL isResumate =  [NSFileManager fileIsExistOfPath:resumeDataCachePath];
            if (isResumate) {
                item.status = BPDownLoadItemPause;
            }
        }
    }
    
    _item = item;
    
    if (item.status == BPDownLoadItemPause) { // [继续下载]
        NSString *resumeDataCachePath = [_resumeDataCachePath stringByAppendingPathComponent:[_item.downLoadUrl md5String]];
        BOOL isResumate =  [NSFileManager fileIsExistOfPath:resumeDataCachePath];
        if (isResumate) {
            // 传入上次暂停下载返回的数据，就可以恢复下载
            item.downloadTask = [_session downloadTaskWithResumeData:[NSFileManager getFileData:resumeDataCachePath]];
            [item.downloadTask resume];
//            [NSFileManager removeFileOfPath:resumeDataCachePath];
        }
        
    } else {
        // 从0开始下载
        NSURL *url = [NSURL URLWithString:item.downLoadUrl];
        item.downloadTask = [_session downloadTaskWithURL:url];
        [item.downloadTask resume];
    }
}

#pragma mark - 在APP关闭的时候取消所有下载任务，为的是获取resumeData
- (void)cancelWithItem:(BPDownLoadItem *)item cancelBlk:(cancelBlk)cancelBlk {
    _item.status = BPDownLoadItemPause;
    __weak typeof(self) weakSelf = self;
    // 暂停下载
    BPLog(@"程序将要退出1w");

    [_item.downloadTask cancelByProducingResumeData:^(NSData *resumeData) {
        BPLog(@"程序将要退出w");
        NSString *resumeDataCachePath = [weakSelf.resumeDataCachePath stringByAppendingPathComponent:[item.downLoadUrl md5String]];
        [NSFileManager saveFile:resumeDataCachePath withData:resumeData];
        
         weakSelf.item.downloadTask = nil;

        if (cancelBlk) {
            cancelBlk(resumeData);
        }
    }];
}

- (void)deleteFileWithItem:(BPDownLoadItem *)item {
    NSString *path = [item.filepath stringByAppendingPathComponent:[item.downLoadUrl md5String]];
    NSString *resumeDataCachePath = [_resumeDataCachePath stringByAppendingPathComponent:[item.downLoadUrl md5String]];

    [NSFileManager removeFileOfPath:path];
    [NSFileManager removeFileOfPath:resumeDataCachePath];
    
    _item = nil;
    _item.downloadTask = nil;
}

#pragma mark - Task Delegate

// 下载进度
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    CGFloat progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
    _item.progress = progress;
    _item.status = BPDownLoadItemDowning;
    [[NSNotificationCenter defaultCenter] postNotificationName:BPDownloadManagerProgressNotification
                                                        object:_item];
}

// 恢复下载
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    BPLog(@"恢复下载，从文件的%lld开发下载 该文件数据的总大小 = %lld",fileOffset,expectedTotalBytes);
}

// 下载完成
- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    // 移动文件到新路径
    [NSFileManager creatDirectoryWithPath:_item.filepath];
    NSString *path = [_item.filepath stringByAppendingPathComponent:[_item.downLoadUrl md5String]];

    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:path error:nil];
    _item.status = BPDownLoadItemFinish;
    [[NSNotificationCenter defaultCenter] postNotificationName:BPDownloadManagerFinishNotification
                                                        object:_item];
}

// cancel 时保存数据
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    BPLog(@"pause-caccel");
}

// 后台session下载完成
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    
}

#pragma mark - Lazy Methods

@end
