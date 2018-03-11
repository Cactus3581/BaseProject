//
//  ALAssetsLibrary+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/5.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
NS_ASSUME_NONNULL_BEGIN

/*iOS9.0之前，获取系统相册最后一张照片*/
@interface ALAssetsLibrary (BPAdd)

- (void)latestAsset:(void (^)(UIImage *image,ALAsset * _Nullable, NSError *_Nullable))block;

@end
NS_ASSUME_NONNULL_END
