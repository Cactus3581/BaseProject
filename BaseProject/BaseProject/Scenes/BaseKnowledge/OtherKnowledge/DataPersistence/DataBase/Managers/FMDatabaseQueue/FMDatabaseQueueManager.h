//
//  FMDatabaseQueueManager.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/7.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "DataBaseModel.h"
@interface FMDatabaseQueueManager : NSObject
+ (void)insertAction:(DataBaseModel *)model;
+ (void)modifyAction:(DataBaseModel *)model;
+ (void)deleteAction:(DataBaseModel *)model;
+ (void)quaryAction_one:(DataBaseModel *)model;
+ (void)transactionByQueue;
@end
