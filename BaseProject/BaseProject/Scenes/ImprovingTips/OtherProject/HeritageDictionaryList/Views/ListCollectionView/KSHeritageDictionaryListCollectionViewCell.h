//
//  KSHeritageDictionaryListCollectionViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHeritageDictionaryModel.h"

@class KSHeritageDictionaryListTableViewCell;

@protocol KSHeritageDictionaryListTableViewCellDelegate<NSObject>
@optional

// 点击添加按钮单词写入数据库成功或者失败
- (void)heritageDictionaryListTableViewCell:(KSHeritageDictionaryListTableViewCell *)cell didReceiveWriteDBResultNotificationWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//点击添加按钮
- (void)heritageDictionaryListTableViewCell:(KSHeritageDictionaryListTableViewCell *)cell didBeginClickAddButtonWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
//点击cell 推入到详情页
- (void)heritageDictionaryListTableViewCell:(KSHeritageDictionaryListTableViewCell *)cell didClickCellWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model;
@end


@interface KSHeritageDictionaryListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addButtonBottomConstraint;
@property(nonatomic,weak) id<KSHeritageDictionaryListTableViewCellDelegate> delegate;
@property(nonatomic,assign) BOOL hiddenLine;
@property(nonatomic, assign) BOOL showOnHomePage;

- (void)setModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
@end

