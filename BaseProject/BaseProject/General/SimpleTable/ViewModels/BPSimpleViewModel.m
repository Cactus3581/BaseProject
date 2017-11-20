//
//  BPSimpleViewModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPSimpleViewModel.h"
#import "BPSimpleModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+YYModel.h"

typedef void(^successed)(NSArray *);

@interface BPSimpleViewModel ()
@property (readwrite) NSArray *data;

@end

@implementation BPSimpleViewModel{
    dispatch_block_t _failed;
    successed _successed;
}

@dynamic data;

+ (instancetype)viewModel {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = [self getArrayData];
    }
    return self;
}

- (void)setDataLoadSuccessedConfig:(void (^)(NSArray *dataSource))successed failed:(dispatch_block_t)failed {
    _successed = successed;
    _failed = failed;
    [self getNetData];
}

- (void)headerRefresh {
    [self getNetData];
}

- (void)footerRefresh {
    [self getNetData];
}

- (void)getNetData{
    [self handleSuccessedData:[self getArrayData]];
}

- (void)handleSuccessedData:(NSArray *)data{
    if (!data.count) {
        doBlock(_failed);
        return;
    }
    if (_successed) {
        _successed(self.data);
    }
    //    doBlock(_successed(self.data));
}

- (void)handleFailed{
    doBlock(_failed);
}

- (NSArray *)getArrayData {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in [self handleData]) {
        BPSimpleModel *model = [BPSimpleModel modelWithDictionary:dic];
        [array addObject:model];
    }
    return array.copy;
}

- (NSArray *)handleData {
    //_dataArray = @[@"缓存设计",@"数字增长动画",@"KVO封装",];
    NSArray *array = @[
                       @{@"title":@"NaviBar",
                         @"fileName":@"BPNaviAnimaViewController",
                         @"briefIntro":@"导航栏基本属性及动画/自定义Tabbar",
                         },
                       @{@"title":@"Tabbar",
                         @"fileName":@"",
                         @"briefIntro":@"计算cell高度",
                         },
                       ];
    return array;
}

- (void)dealloc{
    NSLog(@"viewmodel销毁了");
}

@end


