//
//  KSHeritageDictionaryListTagView.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHeritageDictionaryModel.h"

@protocol KSHeritageDictionaryListTagViewDelegate<NSObject>
@optional
- (void)didSelectWithModel:(KSWordBookAuthorityDictionarySecondCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
- (void)getHeight:(CGFloat)height;
@end

@interface KSHeritageDictionaryListTagView : UIView

@property (nonatomic,assign,readonly,getter = getHeight) CGFloat cardHeight;

@property (nonatomic,strong) KSWordBookAuthorityDictionaryFirstCategoryModel *model;
@property(nonatomic,weak) id<KSHeritageDictionaryListTagViewDelegate> delegate;
@end
