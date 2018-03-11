//
//  BPFeatureViewModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/10.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPFeatureViewModel.h"
#import "BPSimpleModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+YYModel.h"
#import <YYModel.h>
#import "YYModel.h"

typedef void(^successed)(NSArray *);

@interface BPFeatureViewModel ()
@property (readwrite) NSArray *data;

@end

@implementation BPFeatureViewModel{
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
    for (NSDictionary *dic in [self readInDocuments]) {
        BPSimpleModel *model = [BPSimpleModel yy_modelWithDictionary:dic];
        [array addObject:model];
    }
    return array.copy;
}

- (NSArray *)readInDocuments{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FeatureCatalog" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

- (void)dealloc{

}

@end

