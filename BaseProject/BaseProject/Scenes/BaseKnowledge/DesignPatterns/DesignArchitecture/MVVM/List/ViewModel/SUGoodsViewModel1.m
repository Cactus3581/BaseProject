//
//  SUGoodsViewModel1.m
//  MHDevelopExample
//
//  Created by senba on 2017/6/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  MVVM Without RAC 开发模式的 `商品首页的视图模型` -- VM

#import "SUGoodsViewModel1.h"
#import "SUGoods.h"

@interface SUGoodsViewModel1 ()

@end


@implementation SUGoodsViewModel1

// 加载数据
- (void)loadData:(void (^)(NSArray *array))success failure:(void (^)(NSError *error))failure {
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.75f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (int i = 0; i < 10 ;i++) {
            SUGoods *model = [SUGoods new];
            model.title = @(i).stringValue;
            model.isLike = NO;
            SUGoodsItemViewModel *itemViewModel = [[SUGoodsItemViewModel alloc] initWithGoods:model];
            [_dataSource addObject:itemViewModel];
        }
        !success?:success(nil);
    });
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray *dataSource = @[].mutableCopy;
        _dataSource = dataSource;
    }
    return _dataSource;
}

- (void)thumbGoodsWithGoodsItemViewModel:(SUGoodsItemViewModel *)viewModel success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // 模拟网络
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // data
        SUGoods *goods = viewModel.goods;
        // update data
        goods.isLike = !goods.isLike;
        NSInteger likes = (goods.isLike)?(goods.likes.integerValue+1):(goods.likes.integerValue-1);
        goods.likes = [NSString stringWithFormat:@"%zd",likes];
        !success?:success(@(goods.isLike));
    });
}

@end
