//
//  BPS1STManualInsideTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPMultiLevelCatalogueModel.h"

@interface BPS1STManualInsideTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray *wordMarkColorArray;
- (void)setModel:(BPMultiLevelCatalogueModel3rd *)model indexPath:(NSIndexPath *)indexPath;

@end
