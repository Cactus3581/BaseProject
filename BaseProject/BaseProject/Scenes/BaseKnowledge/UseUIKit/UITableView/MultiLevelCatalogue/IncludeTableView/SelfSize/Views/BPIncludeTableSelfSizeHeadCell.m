//
//  BPIncludeTableSelfSizeHeadCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIncludeTableSelfSizeHeadCell.h"
#import "BPIncludeTableSelfSizeInsideTableViewCell.h"
#import "BPIncludeTableSelfSizeInsideHeaderView.h"
#import "MJExtension.h"
#import "BPMultiLevelCatalogueModel+BPHeight.h"

@interface BPIncludeTableSelfSizeHeadCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *arraySource;//显示的数据
@property (nonatomic,strong) BPMultiLevelCatalogueModel2nd *model;
@end

static NSString *cellIdentifier = @"BPIncludeTableSelfSizeInsideTableViewCell";
static NSString *headerIdentifier = @"BPIncludeTableSelfSizeInsideHeaderView";

@implementation BPIncludeTableSelfSizeHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.arraySource = [NSMutableArray array];
        [self initializeViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initializeViews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

//- (CGSize)intrinsicContentSize {
//    CGSize size = [super intrinsicContentSize];
//    return CGSizeMake(size.width, self.tableView.size.height);
//}
//
//- (CGSize)sizeThatFits:(CGSize)size {
//    [super sizeThatFits:size];
//    return CGSizeMake(size.width, self.tableView.size.height);
//}

- (void)setModel:(BPMultiLevelCatalogueModel2nd *)model indexPath:(NSIndexPath *)indexPath showAll:(BOOL)showAll {
//    if (_model != model) {
        _model = model;
        [self.arraySource removeAllObjects];
        self.arraySource = model.array_2nd.mutableCopy;
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];//刷新完成
        [self.contentView layoutIfNeeded];
        //    [self invalidateIntrinsicContentSize];
        BPLog(@"setModel = %.2f,%d",self.tableView.contentSize.height,indexPath.row);
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.tableView.contentSize.height);
        }];
        //    [self.tableView layoutIfNeeded];//刷新完成
        //    [self.contentView layoutIfNeeded];
        //    dispatch_async(dispatch_get_main_queue(), ^{
        //        BPLog(@"setModel3 = %.2f,%d",self.tableView.contentSize.height,indexPath.row);
        //        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.height.mas_equalTo(self.tableView.contentSize.height);
        //        }];
        //    });
//    }
}

#pragma mark -初始化Tableview及delagate
- (void)initializeViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView = tableView;
    [self.contentView addSubview:self.tableView];
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kLevelColor3;
    self.backgroundView = backView;
    self.contentView.backgroundColor = kLevelColor3;
    _tableView.backgroundColor = kLevelColor6;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.estimatedSectionHeaderHeight = 30;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedRowHeight = 80;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.sectionFooterHeight = 0;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).priorityLow();
        make.height.mas_equalTo(self.tableView.contentSize.height);
    }];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BPValidateArray(self.arraySource).count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPIncludeTableSelfSizeInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [BPIncludeTableSelfSizeInsideHeaderView bp_loadInstanceFromNib];
    }
    [header setModel:_model section:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPIncludeTableSelfSizeInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [BPIncludeTableSelfSizeInsideTableViewCell bp_loadInstanceFromNib];
    }
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    [cell setModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
