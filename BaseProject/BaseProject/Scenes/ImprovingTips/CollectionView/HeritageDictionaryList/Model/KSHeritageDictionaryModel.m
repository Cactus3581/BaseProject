//
//  KSHeritageDictionaryModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSHeritageDictionaryModel.h"

@implementation KSHeritageDictionaryModel

@end

@implementation KSWordBookAuthorityDictionaryFirstCategoryModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"sub":[KSWordBookAuthorityDictionarySecondCategoryModel class]};
}
@end

@implementation KSWordBookAuthorityDictionarySecondCategoryModel
@end

@implementation KSWordBookAuthorityDictionaryThirdCategoryModel
@end

@implementation KSWordBookAuthorityDictionaryThirdCategoryUpperModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data":[KSWordBookAuthorityDictionaryThirdCategoryModel class]};
}
@end


