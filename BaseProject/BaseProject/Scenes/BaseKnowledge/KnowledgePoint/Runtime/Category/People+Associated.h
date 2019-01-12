//
//  People+Associated.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/6.
//  Copyright © 2018 cactus. All rights reserved.
//

#import "People.h"

typedef void (^CodingCallBack)();

NS_ASSUME_NONNULL_BEGIN

@interface People (Associated)

@property (nonatomic, strong) NSNumber *associatedBust; // 胸围
@property (nonatomic, copy) CodingCallBack associatedCallBack;  // 写代码
@property (nonatomic,assign) NSInteger phoneNumber;
@property (nonatomic,copy) NSString *unfinishIvar; //如果不用关联对象，直接用属性的话，会报错

@end

NS_ASSUME_NONNULL_END
