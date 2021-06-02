//
//  SUGoodsItemViewModel.h
//  MHDevelopExample
//
//  Created by senba on 2017/6/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  MVVM Without RAC 和 MVVM With RAC的 开发模式的 `商品的视图模型` -- VM

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "SUGoods.h"

@interface SUGoodsItemViewModel : NSObject

@property (nonatomic, readonly, strong) SUGoods *goods;
@property (nonatomic, readonly, assign) CGFloat cellHeight;

// 以下属性只是针对使用 MVVM With RAC 这种情况的有效
@property (nonatomic, readwrite, strong) RACSubject *didClickedAvatarSubject;
@property (nonatomic, readwrite, strong) RACSubject *didClickedReplySubject;//回复按钮被点击
@property (nonatomic, readwrite, strong) RACCommand *operationCommand;//点赞被点击

// 初始化
- (instancetype)initWithGoods:(SUGoods *)goods;

@end
