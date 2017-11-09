//
//  BPBaseTableViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/9.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"
#import "BPBaseTableView.h"

@interface BPBaseTableViewController : BPBaseViewController
@property (nonatomic, strong) BPBaseTableView *tableView;
@property (nonatomic, assign)  UITableViewStyle tableViewStyle;

@property (nonatomic, assign)  BOOL openRefresh;
@property (nonatomic, assign)  BOOL openHeaderRefresh;
@property (nonatomic, assign)  BOOL openFooterRefresh;

- (instancetype)initWithTableStyle:(UITableViewStyle)tableViewStyle;

@end
