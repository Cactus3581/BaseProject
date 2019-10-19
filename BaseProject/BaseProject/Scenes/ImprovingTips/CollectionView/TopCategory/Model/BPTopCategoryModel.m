//
//  BPTopCategoryModel.m
//  BaseProject
//
//  Created by Ryan on 2018/5/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryModel.h"

@implementation BPTopCategoryModel

@end

@implementation BPTopCategoryFirstCategoryModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"sub":[BPTopCategorySecondCategoryModel class]};
}
@end

@implementation BPTopCategorySecondCategoryModel
@end

@implementation BPTopCategoryThirdCategoryModel
@end

@implementation BPTopCategoryThirdCategoryUpperModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[BPTopCategoryThirdCategoryModel class]};
}
@end


