//
//  BPArchiverModel.h
//  BaseProject
//
//  Created by Ryan on 2017/2/17.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPArchiverSubModel.h"

@interface BPArchiverModel : NSObject <NSCoding,NSSecureCoding>
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,strong) BPArchiverSubModel *model;

- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age;
@end
