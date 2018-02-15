//
//  BPBaseKnowledgeViewModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/2/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewModel.h"

@class BPSimpleModel;

NS_ASSUME_NONNULL_BEGIN

@interface BPBaseKnowledgeViewModel : BPBaseViewModel

@property (nullable, nonatomic, readonly) NSArray<BPSimpleModel *> *data;

+ (instancetype)viewModel;

- (void)setDataLoadSuccessedConfig:(void (^)(NSArray *dataSource))successed failed:(dispatch_block_t)failed;

- (void)footerRefresh;

- (void)headerRefresh;

@end

NS_ASSUME_NONNULL_END
