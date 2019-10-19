//
//  BPMediaModel.m
//  WPSExcellentClass
//
//  Created by Ryan on 2018/12/11.
//  Copyright © 2018 Kingsoft. All rights reserved.
//

#import "BPMediaModel.h"
#import "SDWebImageManager.h"

@interface BPMediaModel ()
@property (nonatomic, readwrite,strong) UIImage *image;
@property (nonatomic, assign) BOOL imageDownloading; // 防止重复下载
@end

@implementation BPMediaModel

- (UIImage *)image {
    if (!_image) {
        if (!_imageUrl || !_imageUrl.length) {
            return nil;
        }
//        NSString *path = [BPFileManager getDirectoryForLibrary:@"MediaImages"];
//        NSString *imageFilePath = [path stringByAppendingPathComponent:[self.imageUrl md5]];
//        BOOL exist = [BPFileManager isFileExists:imageFilePath];
//        if (exist) {
//            UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
//            _image = image;
//        } else {
//            if (!self.imageDownloading) {
//                __weak typeof(self) weakSelf = self;
//                weakSelf.imageDownloading = YES;
//                [self downLoadImageWithUrlString:_imageUrl result:^(UIImage *image) {
//                    BOOL success;
//                    success = [UIImageJPEGRepresentation(image, 0.5) writeToFile:imageFilePath  atomically:YES];
//                    //success = [UIImagePNGRepresentation(image) writeToFile:imageFilePath atomically:YES];
//                    if (success){
//                        [weakSelf setImage:image];
//                        weakSelf.imageDownloading = NO;
//                    }
//                }];
//            }
//        }
    }
    return _image;
}

- (void)downLoadImageWithUrlString:(NSString *)urlString result:(void (^)(UIImage *image))resultBlk {
    NSURL *url = [NSURL URLWithString:BPValidateString(urlString)];
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (!error) {
            if (image && finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (resultBlk) {
                        resultBlk(image);
                    }
                });
            }
        }
    }];
}

@end
