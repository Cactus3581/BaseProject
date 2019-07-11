//
//  KSDailySentenceModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSDailySentenceModel.h"

@implementation KSDailySentenceModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"array":[KSDailySentenceContentModel class]};
}

@end



@implementation KSDailySentenceContentModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"contentList":[KSDailySentenceContentItemModel class]};
}

@end


@implementation KSDailySentenceContentItemModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"item":[KSDailySentenceContentItemDetailModel class]};
}

@end


@implementation KSDailySentenceContentItemDetailModel

@end

