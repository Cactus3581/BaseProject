//
//  KSHeritageDictionaryListContainerCollectionViewCell2.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/14.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSHeritageDictionaryListContainerCollectionViewCell3.h"
#import "KSHeritageDictionaryListTagView.h"
#import "KSHeritageDictionaryListCollectionView.h"
#import "KSHeritageDictionaryListTableViewCell.h"
#import "KSHeritageDictionaryMacro.h"


static NSString *kHeritageDictionaryList  = @"KSHeritageDictionaryList";

@interface KSHeritageDictionaryListContainerCollectionViewCell3()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) KSWordBookAuthorityDictionaryFirstCategoryModel *model;

@end

@implementation KSHeritageDictionaryListContainerCollectionViewCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    [self configTableView];
}

- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    if (!model.sub.count) { //没有tag
        if (model.thirdCategoryModel) {
            self.array = model.thirdCategoryModel.data;
            [self.tableView reloadData];
            
        }else {
            [self requestWithID:model.classId firstCategoryModel:model secondCategoryModel:nil];
        }
    }else {
        [self handleListData];
    }
}

- (void)handleListData {
    __block NSInteger showNumber = 0;
    [self.model.sub enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionarySecondCategoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isSelected) {
            showNumber = idx;
        }
    }];
    KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel = self.model.sub[showNumber];
    if (secondCategoryModel.thirdCategoryModel) {
        self.array = secondCategoryModel.thirdCategoryModel.data;
        [self.tableView reloadData];
    }else {
        [self requestWithID:secondCategoryModel.classId firstCategoryModel:self.model secondCategoryModel:secondCategoryModel];
    }
}

- (void)requestWithID:(NSString *)classID firstCategoryModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)firstCategoryModel secondCategoryModel:(KSWordBookAuthorityDictionarySecondCategoryModel *)secondCategoryModel {

}

#pragma tagView delegate
- (void)getHeight:(CGFloat)height {
    if (self.model.sub.count) {
        if (self.model.tagHeight != height) {
            self.model.tagHeight = height;
        }
    }else {
    }
}

- (void)didSelectWithModel:(KSWordBookAuthorityDictionarySecondCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    if (model.thirdCategoryModel) {
        self.array = model.thirdCategoryModel.data;
        [self.tableView reloadData];
    }else {

    }
}

- (void)setHeaderView:(UIView *)headerView {
    _headerView = headerView;
    self.tableView.tableHeaderView = headerView;
}


- (void)configTableView {
    self.backgroundColor = kWhiteColor;
    [_tableView registerNib:[UINib nibWithNibName:@"KSHeritageDictionaryListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KSHeritageDictionaryListTableViewCell"];
    _tableView.backgroundColor = kWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 165.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.array.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BPValidateArray(self.array).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"KSHeritageDictionaryListTableViewCell";
    KSHeritageDictionaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    KSWordBookAuthorityDictionaryThirdCategoryModel *thirdCategoryModel = self.array[indexPath.row];
    [cell setModel:thirdCategoryModel indexPath:indexPath];

    return cell;
}

@end

