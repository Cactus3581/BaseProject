//
//  KSHeritageDictionaryListView.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHeritageDictionaryModel.h"

@protocol KSHeritageDictionaryListViewDelegate<NSObject>
@optional
// 点击cell回调
- (void)didSelectWithModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
@end

@interface KSHeritageDictionaryListView : UIView
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSArray *array;
@property(nonatomic,weak) id<KSHeritageDictionaryListViewDelegate> delegate;
@end
