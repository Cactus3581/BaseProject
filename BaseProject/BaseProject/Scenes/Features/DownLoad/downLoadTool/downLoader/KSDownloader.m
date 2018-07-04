//
//  KSDownloader.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSDownloader.h"
#import <AFNetworking.h>

@interface KSDownloader()
@property (nonatomic,strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSOperationQueue  *loadWordOperationQueue;
@end

@implementation KSDownloader

+ (KSDownloader *)shareDownloader {
    static KSDownloader *downloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [[KSDownloader alloc] init];
    });
    return downloader;
}

- (NSOperationQueue *)loadWordOperationQueue {
    if (_loadWordOperationQueue == nil) {
        _loadWordOperationQueue = [[NSOperationQueue alloc] init];
        _loadWordOperationQueue.maxConcurrentOperationCount = 1;
        _loadWordOperationQueue.name = @"";
    }
    return _loadWordOperationQueue;
}

- (void)startDownLoadWithModel:(NSString *)url  {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

@end
