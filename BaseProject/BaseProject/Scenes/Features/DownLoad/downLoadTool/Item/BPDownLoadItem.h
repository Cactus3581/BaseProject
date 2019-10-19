//
//  BPDownLoadItem.h
//  BaseProject
//
//  Created by Ryan on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

//下载文件类型

//完成情况
typedef NS_ENUM(NSInteger, BPDownLoadItemStatus) {
    BPDownLoadItemNone,//没有开始下载
    BPDownLoadItemWait,//准备下载||等待下载
    BPDownLoadItemDowning,//下载中
    BPDownLoadItemPause,//暂停中
    BPDownLoadItemFinish,//已完成
    BPDownLoadItemFail,//下载失败
    BPDownLoadItemCancel,//取消
};


@interface BPDownLoadItem : NSObject

@property (copy, nonatomic) NSString *downLoadUrl;
@property (copy, nonatomic) NSString *filepath;
@property (assign, nonatomic) BPDownLoadItemStatus status;

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask; //下载任务

@property (assign, nonatomic) CGFloat progress;
@property (copy, nonatomic) NSString *completedUnitCount;
@property (copy, nonatomic) NSString *totalUnitCount;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *identify;

@end
