//
//  BPIncludeTableManualHeadCell.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "BPIncludeTableManualHeadCell.h"
#import "BPIncludeTableManualInsideTableViewCell.h"
#import "BPIncludeTableManualInsideHeaderView.h"
#import "MJExtension.h"
#import "BPMultiLevelCatalogueModel+BPHeight.h"

@interface BPIncludeTableManualHeadCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *arraySource;//显示的数据
@property (nonatomic,strong) BPMultiLevelCatalogueModel2nd *model;
@property (nonatomic,assign) BOOL isShowAll;
@end

static NSInteger limitNumber = 2;

@implementation BPIncludeTableManualHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.arraySource = [NSMutableArray array];
        [self configTableView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configTableView];
}

- (void)setModel:(BPMultiLevelCatalogueModel2nd *)model indexPath:(NSIndexPath *)indexPath showAll:(BOOL)showAll {
    _model = model;
    [self.arraySource removeAllObjects];
    self.arraySource = model.array_2nd.mutableCopy;
    [self.tableView reloadData];
}

#pragma mark -初始化Tableview及delagate
- (void)configTableView {
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
    
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedRowHeight = 0;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.sectionFooterHeight = 0;

    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - TableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //    return self.arraySource.count ? 1 : 0;
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (self.isShowAll) {
//        return BPValidateArray(self.arraySource).count;
//    }else {
//        return BPValidateArray(self.arraySource).count > limitNumber ? limitNumber :BPValidateArray(self.arraySource).count;
//    }
    return BPValidateArray(self.arraySource).count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *identifier = @"BPIncludeTableManualInsideHeaderView";
    BPIncludeTableManualInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:@"BPIncludeTableManualInsideHeaderView" owner:nil options:nil] firstObject];
    }
    [header setModel:_model section:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPIncludeTableManualInsideTableViewCell";
    BPIncludeTableManualInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BPIncludeTableManualInsideTableViewCell" owner:nil options:nil] firstObject];
    }
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    [cell setModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _model.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    return model.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 1000;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
