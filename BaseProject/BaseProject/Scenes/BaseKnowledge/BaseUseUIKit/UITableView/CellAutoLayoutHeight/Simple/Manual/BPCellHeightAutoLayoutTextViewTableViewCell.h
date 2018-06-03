//
//  BPCellHeightAutoLayoutTextViewTableViewCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPCellAutoLayoutHeightModel.h"

@interface BPCellHeightAutoLayoutTextViewTableViewCell : UITableViewCell
- (void)set1stModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath;
- (void)set2ndModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath;
- (void)set3rdModel:(BPCellAutoLayoutHeightModel *)model indexPath:(NSIndexPath *)indexPath;

+ (CGFloat)height3rdWithModel:(BPCellAutoLayoutHeightModel *)model;
@end
