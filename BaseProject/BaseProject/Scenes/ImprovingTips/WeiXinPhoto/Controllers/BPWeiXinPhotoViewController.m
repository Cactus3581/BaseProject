//
//  BPWeiXinPhotoViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/3/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPWeiXinPhotoViewController.h"
#import <Photos/Photos.h>
#import "PHAsset+BPAdd.h"
@interface BPWeiXinPhotoViewController ()

@end

@implementation BPWeiXinPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScreenshotObserver];
}

/**
 *  为<Home + Power键>添加监听
 *  selector 为监听到截屏后调用的方法
 */
- (void)addScreenshotObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(latestAssetImage)
                                                 name:UIApplicationUserDidTakeScreenshotNotification object:nil];
}

/**
 *  相册中最新的一张图片
 */
- (void)latestAssetImage {
    PHAsset *asset = [[PHAsset alloc] init];
    [asset latestAsset:^(UIImage * _Nonnull image, NSError * _Nullable error) {
        self.view.layer.contents = (__bridge id)image.CGImage;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
