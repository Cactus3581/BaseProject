//
//  PHAsset+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/5.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Photos/Photos.h>
NS_ASSUME_NONNULL_BEGIN
/*iOS8.0之后，获取系统相册最后一张照片*/

@interface PHAsset (BPAdd)

- (void)latestAsset:(void (^)(UIImage *image, NSError *_Nullable))block;

@end
NS_ASSUME_NONNULL_END
