//
//  UIImage+RemoteSize.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JKUIImageSizeRequestCompleted) (NSURL* imgURL, CGSize size);

@interface UIImage (JKRemoteSize)
/**
 *  @brief 获取远程图片的大小
 *
 *  @param imgURL     图片url
 *  @param completion 完成回调
 */
+ (void)bp_requestSizeNoHeader:(NSURL*)imgURL completion:(JKUIImageSizeRequestCompleted)completion;
/**
 *  @brief  从header中获取远程图片的大小 (服务器必须支持)
 *
 *  @param imgURL     图片url
 *  @param completion 完成回调
 */
//+ (void)requestSizeWithHeader:(NSURL*)imgURL completion:(UIImageSizeRequestCompleted)completion;

@end
