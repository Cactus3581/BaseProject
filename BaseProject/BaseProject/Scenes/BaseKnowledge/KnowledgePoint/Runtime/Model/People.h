//
//  People.h
//  BaseProject
//
//  Created by xiaruzhen on 2018/12/6.
//  Copyright © 2018 cactus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject <NSCoding> {
    NSString *_address;
}

@property (nonatomic, copy) NSString *name; // 姓名
@property (nonatomic) NSUInteger age;  // 年龄
@property (nonatomic, copy) NSString *occupation; // 职业
@property (nonatomic, copy) NSString *nationality; // 国籍

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

// 生成model
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// 转换成字典
- (NSDictionary *)covertToDictionary;

- (void)sing; // 只有声明，没有实现

- (void)hello;
+ (void)hi;

@end

NS_ASSUME_NONNULL_END
