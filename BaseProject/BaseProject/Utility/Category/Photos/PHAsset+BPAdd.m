//
//  PHAsset+BPAdd.m
//  BaseProject
//
//  Created by Ryan on 2018/3/5.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "PHAsset+BPAdd.h"

@implementation PHAsset (BPAdd)

- (void)latestAsset:(void (^)(UIImage *image, NSError *_Nullable))block {
    // 列出所有相册智能相册
    //PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 列出所有用户创建的相册
    //PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
//    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
      PHFetchResult *assetsFetchResults = [PHAssetCollection fetchMomentsWithOptions:nil];

    NSMutableArray *_assets = [NSMutableArray new];
    
    PHFetchResult *fr = [PHAssetCollection fetchMomentsWithOptions:options];
    for (PHAssetCollection *collection in fr) {
        
        PHFetchResult *_fr = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        for (PHAsset *asset in _fr) {
            
            [_assets addObject:asset];
        }
    }
    
    // 在资源的集合中获取第一个集合，并获取其中的图片

//    PHAsset *asset = assetsFetchResults.firstObject;
    PHAsset *asset = _assets.firstObject;

    // 使用PHImageManager从PHAsset中请求图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
//    PHImageManager *imageManager = [[PHImageManager alloc] init];
    [imageManager requestImageForAsset:asset
                            targetSize:PHImageManagerMaximumSize
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             if (block) {
                                 if (result) {
                                     // result 即为查找到的图片,也是此时的截屏图片
                                     block(result,nil);
                                 }else {
                                     
                                 }
                             }

                         }];
}

@end
