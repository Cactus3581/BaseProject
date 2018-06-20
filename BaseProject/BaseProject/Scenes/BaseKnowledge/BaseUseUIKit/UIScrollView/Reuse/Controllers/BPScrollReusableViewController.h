//
//  BPScrollReusableViewController.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

@interface BPScrollReusableViewController : BPBaseViewController
@property (assign, nonatomic) NSInteger numberOfInstance;
@property (assign, nonatomic) NSNumber *page;

- (void)reloadData;

@end
