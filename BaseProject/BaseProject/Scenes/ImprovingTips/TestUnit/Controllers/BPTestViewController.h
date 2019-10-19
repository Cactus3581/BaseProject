//
//  BPTestViewController.h
//  BaseProject
//
//  Created by Ryan on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPBaseViewController.h"

typedef void(^successDataSource)(NSString *str);

@protocol BPTestViewControllerDelegate<NSObject>
@optional
- (void)pop;
@end
@interface BPTestViewController : BPBaseViewController
@property (nonatomic,copy) successDataSource successDataSource;
@property (nonatomic,weak) id<BPTestViewControllerDelegate> delegate;

@end
