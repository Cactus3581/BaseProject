//
//  BPMediaDataSourceManager.m
//  PowerWord7
//
//  Created by Ryan on 2017/9/6.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#import "BPMediaDataSourceManager.h"
#import "BPMediaModel.h"
#import "BPMediaPlayer.h"

@interface BPMediaDataSourceManager()

@property (nonatomic,strong) NSArray *mediaListArray;//播放列表用的数据

@end

static BPMediaDataSourceManager *audioManager = nil;

@implementation BPMediaDataSourceManager

+ (BPMediaDataSourceManager *)sharePlayerDataManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioManager = [[BPMediaDataSourceManager alloc] init];
    });
    return audioManager;
}

#pragma mark - 从服务端拉取数据
//- (void)requestMediaItemDataWithChapterId:(NSString *)chapterId isBrief:(BOOL)isBrief success:(void (^)(BPMediaModel *model,BPCourseChapterDetailInfo * _Nonnull result))successBlock fail:(void (^)(NSString *error))failBlock {
//    __weak typeof(self) weakSelf = self;
//
//    [BPHttpRequest getChapterDetailWithID:chapterId isBrief:isBrief success:^(id  _Nonnull responseData, BPCourseChapterDetailInfo * _Nonnull result) {
//        BPMediaModel *mediaModel = [[BPMediaPlayer sharePlayer] toMediaModelWithData:result];
//        if (successBlock && mediaModel) {
//            successBlock(mediaModel,result);
//        }
//    } failure:^(NSError * _Nonnull error, NSInteger code) {
//        if(code == -2) {
//            //登录过期
//        } else {
//            /*
//             if([weakSelf mediaFileCachePath].length > 0) {//有缓存
//             [weakSelf preparePlayWithAutoPlay:YES];
//             }
//             */
//        }
//    }];
//}

//warning 不用数组了

#pragma mark 数组列表的下一首播放
- (BPMediaModel *)getNextModelWithCurrentIndex:(NSInteger)index {
    return BPValidateArrayObjAtIdx(self.mediaListArray, [self getNextIndexWithCueentIndex:index]);
}

- (NSInteger)getNextIndexWithCueentIndex:(NSInteger)index {
    
    if (!self.mediaListArray.count) {
        return -1;
    }
    
    NSInteger nextIndex = ++index;
    
    /* 重复播放
    if (index == self.mediaListArray.count-1) {
        nextIndex = 0;
    }
     */
    
    if (nextIndex < 0 || nextIndex > self.mediaListArray.count-1) {
        return -1;
    }
    return nextIndex;
}

#pragma mark 数组列表的上一首播放
- (BPMediaModel *)getPreviousModelWithCurrentIndex:(NSInteger)index {
    return BPValidateArrayObjAtIdx(self.mediaListArray, [self getPreviousIndexWithCurrentIndex:index]);
}

- (NSInteger)getPreviousIndexWithCurrentIndex:(NSInteger)index {
    if (!self.mediaListArray.count) {
        return -1;
    }
    
    NSInteger previousIndex = --index;
    /* 重复播放
     if (index == 0) {
        previousIndex = self.mediaListArray.count-1;
     }
     */
    if (previousIndex < 0 || previousIndex > self.mediaListArray.count-1) {
        return -1;
    }
    return previousIndex;
}

#pragma mark 其他方法

// 根据下标获取model
- (BPMediaModel *)getModelWithIndex:(NSInteger)index {
    return BPValidateArrayObjAtIdx(self.mediaListArray,index);
}

// 根据model获取下标
- (NSInteger)getIndexWithModel:(BPMediaModel *)model {
    __block NSInteger index = -1;
    [self.mediaListArray enumerateObjectsUsingBlock:^(BPMediaModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model.urlString isEqualToString:obj.urlString]) {
            index = idx;
            *stop = YES;
        }
        
    }];
    return index;
}

- (void)setMediaListArrayWithArray:(NSArray <BPMediaModel *> *)array {
    _mediaListArray = array.copy;
}

- (void)clearMediaListArray {
    _mediaListArray = nil;
}

@end
