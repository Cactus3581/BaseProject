//
//  UITableView+BPAdd.m
//  BaseProject
//
//  Created by Ryan on 16/5/17.
//  Copyright © 2016年 cactus. All rights reserved.
//

#import "UITableView+BPAdd.h"
#import "BPAppMacro.h"

BPSYNTH_DUMMY_CLASS(UITableView_BPAdd)

@implementation UITableView (BPAdd)

- (void)bp_updateWithBlock:(void (^)(UITableView *tableView))block {
    [self beginUpdates];
    block(self);
    [self endUpdates];
}
@end
