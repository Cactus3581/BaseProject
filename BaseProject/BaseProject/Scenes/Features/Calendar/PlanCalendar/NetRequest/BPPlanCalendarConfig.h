//
//  BPPlanCalendarConfig.h
//  BaseProject
//
//  Created by Ryan on 2017/11/23.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BPPlanCalendarModel;

@interface BPPlanCalendarConfig : NSObject

@property (nonatomic,assign) NSInteger courseid;

- (void)handleDataWithId:(NSInteger)courseid success:(void(^)(BPPlanCalendarModel *model))successBlock failure:(void (^)(NSString *error))failBlock;

@end
