//
//  DataBaseModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/7.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//


@interface DataBaseModel : NSObject
@property (nonatomic,copy) NSString * name;
@property (nonatomic,strong) NSString * strongName;
@property (nonatomic,copy) NSString * sex;
@property (nonatomic,copy) NSNumber * age;
@property (nonatomic,copy) NSNumber *score ;
+ (instancetype)initializeWithName:(NSString *)name Sex:(NSString *)sex Age:(NSNumber *)age Score:(NSNumber *)score;

@end
