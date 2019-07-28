//
//  BPTableViewNestGestureDetailViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

#import "BPGestureRecognizerTableView.h"

@interface BPTableViewNestGestureDetailViewController : BPBaseViewController
@property (weak, nonatomic) IBOutlet BPGestureRecognizerTableView *tableView;

@property (nonatomic,assign) NSInteger index;

@end
