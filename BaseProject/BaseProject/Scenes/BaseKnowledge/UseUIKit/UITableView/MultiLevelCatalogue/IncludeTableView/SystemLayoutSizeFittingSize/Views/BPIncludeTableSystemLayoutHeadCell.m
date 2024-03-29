//
//  BPIncludeTableSystemLayoutHeadCell.m
//  BaseProject
//
//  Created by Ryan on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPIncludeTableSystemLayoutHeadCell.h"
#import "BPIncludeTableSystemLayoutInsideTableViewCell.h"
#import "BPIncludeTableSystemLayoutInsideHeaderView.h"
#import "MJExtension.h"
#import "BPMultiLevelCatalogueModel+BPHeight.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface BPIncludeTableSystemLayoutHeadCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *arraySource;//显示的数据
@property (nonatomic,strong) BPMultiLevelCatalogueModel2nd *model;
@property (nonatomic,assign) BOOL isShowAll;
@end

static NSString *cellIdentifier = @"BPIncludeTableSystemLayoutInsideTableViewCell";
static NSString *headerIdentifier = @"BPIncludeTableSystemLayoutInsideHeaderView";

@implementation BPIncludeTableSystemLayoutHeadCell

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

- (void)setModel:(BPMultiLevelCatalogueModel2nd *)model indexPath:(NSIndexPath *)indexPath showAll:(BOOL)showAll {
    if (_model != model) {
        _model = model;
        _isShowAll = showAll;
        [self.arraySource removeAllObjects];
        self.arraySource = model.array_2nd.mutableCopy;
        [self.tableView reloadData];
        [self.tableView layoutIfNeeded];
        [self.contentView layoutIfNeeded];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.tableView.contentSize.height);
        }];
    }
}

#pragma mark -初始化Tableview及delagate
- (void)initializeViews {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView = tableView;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kLevelColor3;
    self.backgroundView = backView;
    self.contentView.backgroundColor = kLevelColor3;
    _tableView.backgroundColor = kLevelColor3;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
//    _tableView.estimatedSectionHeaderHeight = 30;
//    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
//
//    _tableView.estimatedRowHeight = 190;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//
//    _tableView.estimatedSectionFooterHeight = CGFLOAT_MIN;
//    _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    
    
    _tableView.estimatedRowHeight = 0;
    _tableView.rowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.sectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.sectionFooterHeight = 0;

    [self.contentView addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView);
//        make.height.mas_equalTo(self.tableView.contentSize.height);
//    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).priorityLow();
        make.height.mas_equalTo(self.tableView.contentSize.height);
    }];
    
    //fd需要注册
    //[self.tableView registerNib:[BPIncludeTableSystemLayoutInsideTableViewCell bp_loadNib] forCellReuseIdentifier:cellIdentifier];
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BPValidateArray(self.arraySource).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    if (model.cellHeight) {
        return model.cellHeight;
    }else {
        static BPIncludeTableSystemLayoutInsideTableViewCell *cell;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            cell = [BPIncludeTableSystemLayoutInsideTableViewCell bp_loadInstanceFromNib];
        });
        BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
        [cell setModel:model indexPath:indexPath];
        NSInteger height = ceil([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kOnePixel);
        model.cellHeight = height;
        return height;
    }

    /*
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell setModel:model indexPath:indexPath];
    }];
     */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPIncludeTableSystemLayoutInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [BPIncludeTableSystemLayoutInsideTableViewCell bp_loadInstanceFromNib];
    }
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    [cell setModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_model.headerHeight) {
        return _model.headerHeight;
    }else {
        static BPIncludeTableSystemLayoutInsideHeaderView *header;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            header = [BPIncludeTableSystemLayoutInsideHeaderView bp_loadInstanceFromNib];
        });
        [header setModel:_model section:section];
        NSInteger height = ceil([header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kOnePixel);
        _model.headerHeight = height;
        return height;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPIncludeTableSystemLayoutInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [BPIncludeTableSystemLayoutInsideHeaderView bp_loadInstanceFromNib];
    }
    [header setModel:_model section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
