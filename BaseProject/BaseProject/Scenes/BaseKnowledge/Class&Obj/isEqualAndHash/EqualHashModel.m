//
//  EqualHashModel.m
//  BaseProject
//
//  Created by Ryan on 2019/1/18.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "EqualHashModel.h"

@implementation EqualHashModel

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[EqualHashModel class]]) {
        return NO;
    }
    
    return [self isEqualToPerson:(EqualHashModel *)object];
}

- (BOOL)isEqualToPerson:(EqualHashModel *)model {
    if (!model) {
        return NO;
    }
    
    BOOL haveEqualVar1 = (!self.var1 && !model.var1) || [self.var1 isEqualToString:model.var1];
    BOOL haveEqualVar2 = (!self.var2 && !model.var2) || [self.var2 isEqualToString:model.var2];

    return haveEqualVar1 && haveEqualVar2;
}

- (NSUInteger)hash {
    NSLog(@"hash = %ld", [super hash]);
    return [self.var1 hash] ^ [self.var2 hash];
}

@end
