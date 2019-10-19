//
//  UITableView+BPAdd.h
//  BaseProject
//
//  Created by Ryan on 16/5/17.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BPAdd)

- (void)bp_updateWithBlock:(void (^)(UITableView *tableView))block;

@end
