//
//  BPListViewController.h
//  BaseProject
//
//  Created by Ryan on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

@interface BPListViewController : BPBaseViewController

@property (nonatomic,copy) NSString *url; // 作为主导航用的
@property (nonatomic,strong) NSArray *dataArray;// 其他业务页面

@end
