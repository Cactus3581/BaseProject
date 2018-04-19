//
//  BPMultiLevelCatalogueModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPMultiLevelCatalogueModel.h"

@implementation BPMultiLevelCatalogueModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array" : [BPMultiLevelCatalogueModel1st class],
             };
}
@end

@implementation BPMultiLevelCatalogueModel1st : NSObject

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array_1st" : [BPMultiLevelCatalogueModel2nd class],
             };
}
@end

@implementation BPMultiLevelCatalogueModel2nd : NSObject

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array_2nd" : [BPMultiLevelCatalogueModel3rd class],
             };
}
@end

@implementation BPMultiLevelCatalogueModel3rd : NSObject

@end
