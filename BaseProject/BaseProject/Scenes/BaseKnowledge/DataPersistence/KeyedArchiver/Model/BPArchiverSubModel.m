//
//  BPArchiverSubModel.m
//  BaseProject
//
//  Created by Ryan on 2017/2/17.
//  Copyright © 2017年 Ryan. All rights reserved.
//

#import "BPArchiverSubModel.h"

@implementation BPArchiverSubModel

- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    
    return self;
}

//解析
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInteger:_age forKey:@"age"];
}

@end
