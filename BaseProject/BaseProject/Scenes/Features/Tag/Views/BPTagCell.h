//
//  BPTagCell.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPTagModel.h"

typedef NS_ENUM(NSInteger, BPTagCellType) {
    BPTagCellTypeNormal,/**<正常*/
    BPTagCellTypeSelected1,/**<选中状态1，带背景颜色*/
    BPTagCellTypeSelected2/**<选中状态2*/
};

@interface BPTagCell : UICollectionViewCell

@property (nonatomic, strong) BPTagModel *model;
@property (nonatomic, assign) BPTagCellType type;
@property (nonatomic, strong) UILabel *textLabel;

+ (NSString *)cellReuseIdentifier;

@end
