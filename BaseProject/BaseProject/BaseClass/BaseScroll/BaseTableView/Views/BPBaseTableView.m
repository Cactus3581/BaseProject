//
//  BPBaseTableView.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseTableView.h"

@implementation BPBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self config];
}

- (void)config {
    self.backgroundColor = kWhiteColor;
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableHeaderView = [[UIView alloc]init];
    self.tableFooterView = [[UIView alloc]init];
    //self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    //self.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    //warning: 注意不能是CGFLOAT_MIN
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}

@end
