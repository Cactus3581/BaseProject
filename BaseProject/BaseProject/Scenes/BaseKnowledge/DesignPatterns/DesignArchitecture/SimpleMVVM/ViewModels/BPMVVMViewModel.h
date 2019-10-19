//
//  BPMVVMViewModel.h
//  BaseProject
//
//  Created by Ryan on 2019/1/16.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPMVVMModel;

NS_ASSUME_NONNULL_BEGIN

@interface BPMVVMViewModel : NSObject<UITableViewDataSource>

@property (nullable, nonatomic, readonly) NSArray<BPMVVMModel *> *data;

+ (instancetype)viewModel;

- (void)configTableviewCell:(UITableViewCell*(^)(UITableView *tableView, NSIndexPath *indexPath))cellConfig;

- (void)setDataLoadSuccessedConfig:(void (^)(NSArray *dataSource))successed failed:(dispatch_block_t)failed;


@end

NS_ASSUME_NONNULL_END
