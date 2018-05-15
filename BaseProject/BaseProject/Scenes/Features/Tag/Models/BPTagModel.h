//
//  BPTagModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPTagModel : NSObject

@property (nonatomic, strong) NSNumber *identifier;/**<活动标签id*/
@property (nonatomic, copy) NSString *name;/**<标签名称*/
@property (nonatomic, assign) BOOL isChoose;/**<是否被选择*/
@end
