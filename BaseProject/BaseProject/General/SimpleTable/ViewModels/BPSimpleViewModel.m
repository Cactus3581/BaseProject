//
//  BPSimpleViewModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPSimpleViewModel.h"
#import "NSObject+YYModel.h"

typedef void(^successed)(NSArray *);

@interface BPSimpleViewModel ()
@property (readwrite) NSArray *data;
@end

@implementation BPSimpleViewModel

@dynamic data;

+ (instancetype)viewModelWithArray:(NSArray *)array {
    return [[self alloc] initWithArray:array];
}

- (instancetype)initWithArray:(NSArray *)array {
    self = [super init];
    if (self) {
        self.data = array;
    }
    return self;
}

- (void)dealloc{

}

@end


