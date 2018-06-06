//
//  BPIncludeTableSelfSizeHeadCell.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
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

@implementation BPIncludeTableSelfSizeHeadCell

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

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setModel:(BPMultiLevelCatalogueModel2nd *)model indexPath:(NSIndexPath *)indexPath showAll:(BOOL)showAll {
    _model = model;
    [self.arraySource removeAllObjects];
    self.arraySource = model.array_2nd.mutableCopy;
    [self.tableView reloadData];
    BPLog(@"setModel1 = %.2f,%d",self.tableView.contentSize.height,indexPath.row);
    [self.tableView layoutIfNeeded];
    [self.contentView layoutIfNeeded];
    [self layoutIfNeeded];
    BPLog(@"setModel2 = %.2f,%d",self.tableView.contentSize.height,indexPath.row);

    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.tableView.contentSize.height);
    }];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新完成
        BPLog(@"setModel3 = %.2f,%d",self.tableView.contentSize.height,indexPath.row);

        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.tableView.contentSize.height);
        }];
        [self.contentView layoutIfNeeded];
    });
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
    
    _tableView.estimatedSectionHeaderHeight = 30;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedRowHeight = 80;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedSectionFooterHeight = CGFLOAT_MIN;
    _tableView.sectionFooterHeight = 0;

    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.with.with.left.with.right.mas_equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).priorityLow();
        make.height.mas_equalTo(self.tableView.contentSize.height);
    }];
}

#pragma mark - TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BPValidateArray(self.arraySource).count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *identifier = @"BPIncludeTableSelfSizeInsideHeaderView";
    BPIncludeTableSelfSizeInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:@"BPIncludeTableSelfSizeInsideHeaderView" owner:nil options:nil] firstObject];
    }
    [header setModel:_model section:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPIncludeTableSelfSizeInsideTableViewCell";
    BPIncludeTableSelfSizeInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BPIncludeTableSelfSizeInsideTableViewCell" owner:nil options:nil] firstObject];
    }
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    [cell setModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
