//
//  BPTableViewModel.m
//  BaseProject
//
//  Created by Ryan on 2019/8/12.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPTableViewModel.h"
#import "MJExtension.h"

@implementation BPTableViewModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"array":[BPTableViewItemModel class]};
}

@end

@implementation BPTableViewItemModel

@end

