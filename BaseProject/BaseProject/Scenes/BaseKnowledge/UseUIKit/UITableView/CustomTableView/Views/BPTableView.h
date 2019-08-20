//
//  BPTableView.h
//  BaseProject
//
//  Created by xiaruzhen on 2019/8/20.
//  Copyright © 2019 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPTableView;
@class BPCustomTableViewCell;

NS_ASSUME_NONNULL_BEGIN

@protocol BPTableViewDelegate<NSObject, UIScrollViewDelegate>

- (NSInteger)tableView:(BPTableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (BPCustomTableViewCell *)tableView:(BPTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableView:(BPTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface BPTableView : UIScrollView

@property (weak, nonatomic) id <BPTableViewDelegate> dataSource;

@property (strong, nonatomic) NSArray <BPCustomTableViewCell *>*visibleCells;

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (BPCustomTableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
