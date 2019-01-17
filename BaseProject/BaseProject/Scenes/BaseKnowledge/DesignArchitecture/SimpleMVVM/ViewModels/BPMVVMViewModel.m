//
//  BPMVVMViewModel.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/1/16.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPMVVMViewModel.h"
#import "BPMVVMModel.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "NSObject+YYModel.h"
#import <YYModel.h>
#import "YYModel.h"

typedef void(^successed)(NSArray *);

@interface BPMVVMViewModel ()

@property (nonatomic, copy, readwrite) NSArray *data;
@property (nonatomic, copy) UITableViewCell*(^tableviewCellConfig)(UITableView *tableView, NSIndexPath *indexPath);

@end


@implementation BPMVVMViewModel {
    dispatch_block_t _failed;
    successed _successed;
}

+ (instancetype)viewModel {
    return [[self alloc] init];
}

#pragma mark - 获取数据
- (void)setDataLoadSuccessedConfig:(void (^)(NSArray *dataSource))successed failed:(dispatch_block_t)failed {
    _successed = successed;
    _failed = failed;
    [self handleData];
}

- (void)handleData {
    self.data = [self getArrayData];
    if (!self.data.count) {
        doBlock(_failed);
        return;
    }
    if (_successed) {
        _successed(self.data);
    }
}

- (NSArray *)getArrayData {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *data = @[@{@"title":@"i am mvvm"}];
    for (NSDictionary *dic in data) {
        BPMVVMModel *model = [BPMVVMModel yy_modelWithDictionary:dic];
        [array addObject:model];
    }
    return array.copy;
}

#pragma mark - TableView DataSource 回调
- (void)configTableviewCell:(UITableViewCell * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))cellConfig {
    _tableviewCellConfig = cellConfig;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableviewCellConfig) {
        return _tableviewCellConfig(tableView, indexPath);
    };
    return nil;
}



- (void)dealloc {
    
}

@end

