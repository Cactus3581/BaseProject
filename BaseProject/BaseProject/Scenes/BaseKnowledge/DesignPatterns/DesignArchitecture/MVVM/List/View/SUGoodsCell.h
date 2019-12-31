//
//  SUGoodsCell.h
//  SenbaUsed
//
//  Created by shiba_iOSRB on 16/7/26.
//  Copyright © 2016年 曾维俊. All rights reserved.
//
// Goods cell

#import <UIKit/UIKit.h>
#import "SUGoodsItemViewModel.h"
@class SUGoodsCell;

//以下 MVC 和 MVVM without RAC 的事件回调的使用的场景，如果使用MVVM With RAC的请自行ignore
typedef void(^SUGoodsCellAvatarClickedHandler)(SUGoodsCell *goodsCell);
typedef void(^SUGoodsCellReplyClickedHandler)(SUGoodsCell *goodsCell);
typedef void(^SUGoodsCellThumbClickedHandler)(SUGoodsCell *goodsCell);


@interface SUGoodsCell : UITableViewCell

//// 以下 MVC 和 MVVM without RAC 的事件回调的使用的场景，如果使用MVVM With RAC的请自行ignore
@property (nonatomic, readwrite, copy) SUGoodsCellAvatarClickedHandler avatarClickedHandler;
@property (nonatomic, readwrite, copy) SUGoodsCellReplyClickedHandler replyClickedHandler;
@property (nonatomic, readwrite, copy) SUGoodsCellThumbClickedHandler thumbClickedHandler;

@property (nonatomic, strong) SUGoodsItemViewModel *itemViewModel;

@end
