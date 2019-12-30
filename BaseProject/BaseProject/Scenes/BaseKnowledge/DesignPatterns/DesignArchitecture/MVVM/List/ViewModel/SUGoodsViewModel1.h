//
//  SUGoodsViewModel1.h
//  MHDevelopExample
//
//  Created by senba on 2017/6/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  MVVM Without RAC 开发模式的 `商品首页的视图模型` -- VM

#import <Foundation/Foundation.h>
#import "SUGoodsItemViewModel.h"

@interface SUGoodsViewModel1 : NSObject

@property (nonatomic, readwrite, strong) NSMutableArray *dataSource;

/// 点赞商品
- (void)thumbGoodsWithGoodsItemViewModel:(SUGoodsItemViewModel *)viewModel
                                 success:(void (^)(id responseObject))success
                                 failure:(void (^)(NSError *))failure;

@end
