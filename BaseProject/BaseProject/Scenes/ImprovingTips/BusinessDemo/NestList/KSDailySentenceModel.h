//
//  KSDailySentenceModel.h
//  BaseProject
//
//  Created by Ryan on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSDailySentenceModel : NSObject

@property (nonatomic,strong) NSArray *array;

@end


@interface KSDailySentenceContentModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSArray *contentList;

@property (nonatomic,strong) NSArray *customArray;// 自己重组的数组

@end


@interface KSDailySentenceContentItemModel : NSObject

@property (nonatomic,strong) NSArray *item;

@end


@interface KSDailySentenceContentItemDetailModel : NSObject

@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *customIndex;// 自己重组的数组
@property (nonatomic,assign) BOOL hiddenIndexLabel;// 自己重组的数组

@end

NS_ASSUME_NONNULL_END
