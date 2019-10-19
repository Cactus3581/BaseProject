//
//  BPArchiverSubModel.h
//  BaseProject
//
//  Created by Ryan on 2017/2/17.
//  Copyright © 2017年 Ryan. All rights reserved.
//


@interface BPArchiverSubModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) NSInteger age;
- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age;
@end
