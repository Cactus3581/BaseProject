//
//  SUGoodsItemViewModel.m
//  MHDevelopExample
//
//  Created by senba on 2017/6/16.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//  MVVM Without RAC 和 MVVM With RAC的 开发模式的 `商品的视图模型` -- VM

#import "SUGoodsItemViewModel.h"

@interface SUGoodsItemViewModel ()

@property (nonatomic, readwrite, strong) SUGoods *goods;
@property (nonatomic, readwrite, copy) NSAttributedString *goodsTitleAttributedString;
@property (nonatomic, readwrite, assign) CGFloat cellHeight;

@end


@implementation SUGoodsItemViewModel

- (instancetype)initWithGoods:(SUGoods *)goods {
    self = [super init];
    if (self) {
        self.goods = goods;
        self.cellHeight =70;
    }
    return self;
}

@end
