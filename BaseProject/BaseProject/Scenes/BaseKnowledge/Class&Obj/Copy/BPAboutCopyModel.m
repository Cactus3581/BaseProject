//
//  BPAboutCopyModel.m
//  BaseProject
//
//  Created by Ryan on 2019/6/15.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPAboutCopyModel.h"

@implementation BPAboutCopyModel

- (id)copyWithZone:(NSZone *)zone {
    BPAboutCopyModel *model = [[[self class] allocWithZone:zone] init];
    model.age = self.age;
    model.title = self.title;
    model.array = [self.array copyWithZone:zone];
    return model;
}

@end
