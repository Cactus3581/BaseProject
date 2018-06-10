//
//  BPTopCategoryListTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/25.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPTopCategoryModel.h"

@interface BPTopCategoryListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property(nonatomic, assign) BOOL showOnHomePage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverImageViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addButtonBottomConstraint;
- (void)setModel:(BPTopCategoryThirdCategoryModel *)model indexPath:(NSIndexPath *)indexPath;
@end
