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
#import <YYModel.h>
#import "YYModel.h"

typedef void(^successed)(NSArray *);

@interface BPSimpleViewModel ()

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong,readwrite) NSArray *data;
@property (nonatomic, copy) UITableViewCell*(^tableviewCellConfig)(UITableView *tableView, NSIndexPath *indexPath);
@property (nonatomic, copy) UICollectionViewCell*(^collectionViewCellConfig)(UICollectionView *collectionView, NSIndexPath *indexPath);

@end

@implementation BPSimpleViewModel{
    dispatch_block_t _failed;
    successed _successed;
}

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

+ (instancetype)viewModel {
    return [[self alloc] init];
}

- (void)configTableviewCell:(UITableViewCell * _Nonnull (^)(UITableView * _Nonnull, NSIndexPath * _Nonnull))cellConfig {
    _tableviewCellConfig = cellConfig;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

#pragma mark - <UITableViewDataSource>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableviewCellConfig) {
        return _tableviewCellConfig(tableView, indexPath);
    };
    return nil;
}

- (void)setDataLoadWithUrl:(NSString *)url successed:(void (^)(NSArray *dataSource))successed failed:(dispatch_block_t)failed {
    _url = url;
    _successed = successed;
    _failed = failed;
    [self handleData];
}

- (void)handleData {

    NSString *path = [[NSBundle mainBundle] pathForResource:_url ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        BPSimpleModel *model = [BPSimpleModel yy_modelWithDictionary:dic];
        [muArray addObject:model];
    }
    self.data = muArray.copy;
    if (!self.data.count) {
        doBlock(_failed);
        return;
    }
    if (_successed) {
        _successed(self.data);
    }
}

#pragma mark - <UICollectionViewDataSouce>

- (void)configCollectionViewCell:(UICollectionViewCell * _Nonnull (^)(UICollectionView * _Nonnull, NSIndexPath * _Nonnull))cellConfig {
    _collectionViewCellConfig = cellConfig;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_collectionViewCellConfig) {
        return _collectionViewCellConfig(collectionView, indexPath);
    }
    return nil;
}


- (void)dealloc {
    
}

@end
