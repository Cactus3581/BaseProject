//
//  BPIncludeTableManualHeaderView.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMultiLevelCatalogueModel.h"

@interface BPIncludeTableManualHeaderView : UITableViewHeaderFooterView
- (void)setModel:(BPMultiLevelCatalogueModel1st *)model section:(NSInteger)indexPath;
@end
