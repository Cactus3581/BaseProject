//
//  BPSimpleViewModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseViewModel.h"

@class BPSimpleModel;

NS_ASSUME_NONNULL_BEGIN

@interface BPSimpleViewModel : BPBaseViewModel

@property (nullable, nonatomic, readonly) NSArray<BPSimpleModel *> *data;

+ (instancetype)viewModelWithArray:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
