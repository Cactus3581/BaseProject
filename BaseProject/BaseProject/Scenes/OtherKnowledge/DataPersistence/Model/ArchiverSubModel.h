//
//  ArchiverSubModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//


@interface ArchiverSubModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger age;
- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age;
@end
