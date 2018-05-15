//
//  KSHeritageDictionaryListTableViewCell.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSHeritageDictionaryModel.h"

@interface KSHeritageDictionaryListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property(nonatomic, assign) BOOL showOnHomePage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addButtonBottomConstraint;
- (void)setModel:(KSWordBookAuthorityDictionaryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
@end
