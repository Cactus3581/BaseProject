//
//  BPBaseViewModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface BPBaseViewModel : NSObject<UITableViewDataSource, UICollectionViewDataSource>

@property (nullable, nonatomic, readonly) NSArray *data;

- (void)configTableviewCell:(UITableViewCell*(^)(UITableView *tableView, NSIndexPath *indexPath))cellConfig;
- (void)configCollectionViewCell:(UICollectionViewCell*(^)(UICollectionView *collectionView, NSIndexPath *indexPath))cellConfig;

@end

NS_ASSUME_NONNULL_END

