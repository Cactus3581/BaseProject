//
//  BPXRZViewModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseViewModel.h"
@class BPSimpleModel;

NS_ASSUME_NONNULL_BEGIN

@interface BPXRZViewModel : BPBaseViewModel

@property (nullable, nonatomic, readonly) NSArray<BPSimpleModel *> *data;

+ (instancetype)viewModel;

- (void)setDataLoadSuccessedConfig:(void (^)(NSArray *dataSource))successed failed:(dispatch_block_t)failed;

- (void)footerRefresh;

- (void)headerRefresh;

@end

NS_ASSUME_NONNULL_END
