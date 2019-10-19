//
//  ClassModel.h
//  BaseProject
//
//  Created by Ryan on 2017/5/15.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "DataBaseModel.h"

@interface ClassModel : DataBaseModel

+ (instancetype)initializeWithName:(NSString *)name Sex:(NSString *)sex Age:(NSNumber *)age Score:(NSNumber *)score;

@end
