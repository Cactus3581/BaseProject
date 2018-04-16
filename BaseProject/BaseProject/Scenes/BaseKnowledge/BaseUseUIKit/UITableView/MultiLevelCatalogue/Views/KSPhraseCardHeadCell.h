//
//  KSPhraseCardHeadCell.h
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSMultiLevelCatalogueModel.h"

@interface KSPhraseCardHeadCell : UITableViewCell
- (void)setModel:(KSMultiLevelCatalogueModel2nd *)model indexPath:(NSIndexPath *)indexPath;
@end
