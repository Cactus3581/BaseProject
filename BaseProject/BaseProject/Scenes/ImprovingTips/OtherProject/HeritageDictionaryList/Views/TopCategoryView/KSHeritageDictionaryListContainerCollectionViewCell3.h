//
//  KSHeritageDictionaryListContainerCollectionViewCell3.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KSHeritageDictionaryModel.h"

@interface KSHeritageDictionaryListContainerCollectionViewCell3 : UICollectionViewCell
- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) NSArray *array;

@end

