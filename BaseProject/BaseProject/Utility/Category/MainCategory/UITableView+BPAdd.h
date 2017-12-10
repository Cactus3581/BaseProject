//
//  UITableView+BPAdd.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BPAdd)

- (void)bp_updateWithBlock:(void (^)(UITableView *tableView))block;

@end
