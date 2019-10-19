//
//  ALAssetsLibrary+BPAdd.m
//  BaseProject
//
//  Created by Ryan on 2018/3/5.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "ALAssetsLibrary+BPAdd.h"

@implementation ALAssetsLibrary (BPAdd)

- (void)latestAsset:(void (^)(UIImage *image,ALAsset * _Nullable, NSError *_Nullable))block {
    [self enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            [group enumerateAssetsWithOptions:NSEnumerationReverse/*遍历方式-反向*/ usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    ALAssetRepresentation *assetRep = [result defaultRepresentation];
                    CGImageRef imgRef = [assetRep fullResolutionImage];
                    UIImage *image = [[UIImage alloc] initWithCGImage:imgRef];
                    if (block) {
                        block(image,result,nil);
                    }
                    *stop = YES;
                }
            }];
            *stop = YES;
        }
    } failureBlock:^(NSError *error) {
        if (error) {
            if (block) {
                block(nil,nil,error);
            }
        }
    }];
}

@end
