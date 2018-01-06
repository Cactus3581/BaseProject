//
//  ArchiverModel.h
//  BaseProject
//
//  Created by xiaruzhen on 2017/2/17.
//  Copyright © 2017年 xiaruzhen. All rights reserved.
//

#import "ArchiverSubModel.h"

@interface ArchiverModel : NSObject <NSCoding>
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,strong) ArchiverSubModel *model;

- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age;
@end
