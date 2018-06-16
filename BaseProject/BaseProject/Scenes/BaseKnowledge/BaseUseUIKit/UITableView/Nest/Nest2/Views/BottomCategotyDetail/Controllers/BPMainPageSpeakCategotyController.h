//
//  BPMainPageSpeakCategotyController.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/12.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"
#import "BPNestLinkageBaseTableView.h"

@interface BPMainPageSpeakCategotyController : BPBaseViewController
//- (void)setIndexpath:(NSInteger)index;
@property (nonatomic,assign) NSInteger index;
@property (weak, nonatomic) IBOutlet BPNestLinkageBaseTableView *tableView;

@end
