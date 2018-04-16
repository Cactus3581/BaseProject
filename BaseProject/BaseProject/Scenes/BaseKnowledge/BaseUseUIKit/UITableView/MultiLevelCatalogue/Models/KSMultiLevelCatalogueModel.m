//
//  KSMultiLevelCatalogueModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSMultiLevelCatalogueModel.h"

@implementation KSMultiLevelCatalogueModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array" : [KSMultiLevelCatalogueModel1st class],
             };
}
@end

@implementation KSMultiLevelCatalogueModel1st : NSObject

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array_1st" : [KSMultiLevelCatalogueModel2nd class],
             };
}
@end

@implementation KSMultiLevelCatalogueModel2nd : NSObject

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"array_2nd" : [KSMultiLevelCatalogueModel3rd class],
             };
}
@end

@implementation KSMultiLevelCatalogueModel3rd : NSObject

@end
