//
//  BPMediaModel.h
//  WPSExcellentClass
//
//  Created by xiaruzhen on 2018/12/11.
//  Copyright © 2018 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 多媒体文件状态
typedef NS_ENUM(NSInteger, BPMediaItemType) {
    BPMediaItemNone,
    BPMediaItemVideo,//视频
    BPMediaItemAudio,//音频
    BPMediaItemLive,//直播
};

// 多媒体文件状态
typedef NS_ENUM(NSInteger, BPMediaItemDataSourceType) {
    BPMediaItemDataSourceFromServer,//通过接口获取数据
    BPMediaItemDataSourceFromArray,//通过数组获取全部数据
};


@interface BPMediaModel : NSObject

@property (nonatomic, copy) NSString *urlString;// 跟后台同学沟通，这儿不需要判断是否购买直播等其他，只要有值就可以播放
@property (nonatomic, copy) NSString *title;//音频名
@property (nonatomic, copy) NSString *albumTitle;//音频专辑
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *artistTitle;//歌手名
@property (nonatomic, assign) BPMediaItemType mediaItemType;//多媒体类型
@property (nonatomic, assign) BPMediaItemDataSourceType mediaItemDataSourceType;//数据来源
@property (nonatomic, copy) NSString *cachePath;//缓存路径
@property (nonatomic, copy) NSString *chapterId;//当前多媒体文件ID
@property (nonatomic, copy) NSString *preChapterId;//上一个多媒体文件ID
@property (nonatomic, copy) NSString *nextChapterId;//下一个多媒体文件ID
@property (nonatomic, assign) BOOL tryListenAudio; // 是否是试听的
@property (nonatomic, readonly,strong) UIImage *image;
@property (nonatomic, assign) BOOL isBrief; // 是否是简讯

@end

NS_ASSUME_NONNULL_END
