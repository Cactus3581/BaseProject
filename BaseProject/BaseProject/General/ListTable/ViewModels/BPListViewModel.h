//
//  BPListViewModel.h
//  BaseProject
//
//  Created by Ryan on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BPListModel;

NS_ASSUME_NONNULL_BEGIN

@interface BPListViewModel : NSObject<UITableViewDataSource, UICollectionViewDataSource>

@property (nullable, nonatomic, readonly) NSArray<BPListModel *> *data;

+ (instancetype)viewModel;

+ (instancetype)viewModelWithArray:(NSArray *)array;

- (void)setDataLoadWithUrl:(NSString *)url successed:(void (^)(NSArray *dataSource))successed failed:(dispatch_block_t)failed;

- (void)configTableviewCell:(UITableViewCell*(^)(UITableView *tableView, NSIndexPath *indexPath))cellConfig;

- (void)configCollectionViewCell:(UICollectionViewCell*(^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellConfig;

@end

NS_ASSUME_NONNULL_END
