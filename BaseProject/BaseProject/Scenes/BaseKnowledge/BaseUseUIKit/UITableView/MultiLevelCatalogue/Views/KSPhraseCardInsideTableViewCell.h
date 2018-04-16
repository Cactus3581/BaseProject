//
//  KSPhraseCardInsideTableViewCell.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSMultiLevelCatalogueModel.h"

@interface KSPhraseCardInsideTableViewCell : UITableViewCell
- (void)setModel:(KSMultiLevelCatalogueModel3rd *)model indexPath:(NSIndexPath *)indexPath;
@end
