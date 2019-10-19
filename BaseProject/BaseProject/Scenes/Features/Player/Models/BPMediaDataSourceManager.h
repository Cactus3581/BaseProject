//
//  BPMediaDataSourceManager.h
//  PowerWord7
//
//  Created by Ryan on 2017/9/6.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPMediaModel;

@interface BPMediaDataSourceManager : NSObject

/**
 单例

 @return BPMediaDataSourceManager
 */
+ (BPMediaDataSourceManager *)sharePlayerDataManager;


// 通过接口切换多媒体资源

//- (void)requestMediaItemDataWithChapterId:(NSString *)chapterId isBrief:(BOOL)isBrief success:(void (^)(BPMediaModel *model,BPCourseChapterDetailInfo * _Nonnull result))successBlock fail:(void (^)(NSString *error))failBlock;

// 通过数组切换多媒体资源

- (void)setMediaListArrayWithArray:(NSArray <BPMediaModel *> *)array;
- (void)clearMediaListArray;

- (BPMediaModel *)getNextModelWithCurrentIndex:(NSInteger)index;

- (NSInteger)getNextIndexWithCueentIndex:(NSInteger)index;

- (BPMediaModel *)getPreviousModelWithCurrentIndex:(NSInteger)index;

- (NSInteger)getPreviousIndexWithCurrentIndex:(NSInteger)index;

- (BPMediaModel *)getModelWithIndex:(NSInteger)index;

@property (nonatomic,readonly,strong) NSArray *mediaListArray;

@end
