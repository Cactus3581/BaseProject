//
//  KSDownloader.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSDownloader : NSObject
+ (KSDownloader *)shareDownloader;
////开始下载
//- (void)startDownLoadWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//
////检查表
//+ (BOOL)checkDataInDBWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//
////检查本地有无文件
//+ (BOOL)checkFileInDocumentsWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//
////处理文件，把文件写入数据库
//- (void)handleFileWhenFileExistWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//
//+ (void)startDownLoadWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model tableViewCell:(KSHeritageDictionaryListTableViewCell *)cell indexPath:(NSIndexPath *)indexPath success:(void (^)(KSWordBookAuthorityDictionaryThirdCategoryModel *model))success;
//
////暂停下载
//- (void)stopDownloadWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//
////继续下载
//- (void)keepDownloadWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//
////网络监控
//- (void)networkReachabilityManager;

@end

