//
//  BPTestCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTestCollectionViewCell.h"
#import "KSHeritageDictionaryListTableViewCell.h"

@interface BPTestCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) KSWordBookAuthorityDictionaryFirstCategoryModel *model;
@end

@implementation BPTestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    [self configTableView];
}

- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel = self.model.sub[0];
    self.array = secondCategoryModel.thirdCategoryModel.data;
    [self.tableView reloadData];
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
    return 1;
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
