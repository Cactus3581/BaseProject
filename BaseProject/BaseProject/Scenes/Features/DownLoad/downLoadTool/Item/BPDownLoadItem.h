//
//  BPDownLoadItem.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

//下载文件类型

//完成情况
typedef NS_ENUM(NSInteger, BPDownLoadItemStatus) {
    BPDownLoadItemNone,//没有开始写
    BPDownLoadItemPrepary,//准备下载||等待下载
    BPDownLoadItemDowning,//下载中
    BPDownLoadItemPause,//暂停中
    BPDownLoadItemSuccess,//已完成
    BPDownLoadItemFail,//下载失败
};

@interface BPDownLoadItem : NSObject
@property (copy, nonatomic) NSString *identify;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *downLoadUrl;
@property (copy, nonatomic) NSString *filepath;
@property (assign, nonatomic) BPDownLoadItemStatus status;
@property (copy, nonatomic) NSString *progress;
@property (copy, nonatomic) NSString *completedUnitCount;
@property (copy, nonatomic) NSString *totalUnitCount;
@end
