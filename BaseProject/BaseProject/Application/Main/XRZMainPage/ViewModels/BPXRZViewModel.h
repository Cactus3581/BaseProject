//
//  BPXRZViewModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseViewModel.h"
@class BPMasterCatalogueModel;

NS_ASSUME_NONNULL_BEGIN

@interface BPXRZViewModel : BPBaseViewModel

@property (nullable, nonatomic, readonly) NSArray<BPMasterCatalogueModel *> *data;

+ (instancetype)viewModel;

- (void)setDataLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed;

- (void)footerRefresh;

- (void)headerRefresh;

@end

NS_ASSUME_NONNULL_END
