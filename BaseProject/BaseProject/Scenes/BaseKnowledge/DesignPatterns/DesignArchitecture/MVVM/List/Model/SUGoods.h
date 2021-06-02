//
//  SUGoods.h
//  MHDevelopExample
//
//  Created by senba on 2017/6/9.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  首页商品模型 data-model -- M

#import <Foundation/Foundation.h>


@interface SUGoods : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *likes;// 喜欢次数
@property (nonatomic, assign) BOOL isLike;

@end
