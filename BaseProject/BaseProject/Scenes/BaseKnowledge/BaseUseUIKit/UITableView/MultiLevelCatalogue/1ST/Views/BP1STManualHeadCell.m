//
//  BP1STManualHeadCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP1STManualHeadCell.h"
#import "BP1STManualInsideHeaderView.h"
#import "BPS1STManualInsideTableViewCell.h"


static NSInteger limitNumber = 2;

@interface BP1STManualHeadCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *arraySource;//显示的数据
@property (nonatomic,strong) BPMultiLevelCatalogueModel2nd *model;
@property (nonatomic,assign) BOOL isShowAll;
@property (strong, nonatomic)  UITableView *tableView;
@end

@implementation BP1STManualHeadCell

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
    _isShowAll = showAll;
    [self.arraySource removeAllObjects];
    self.arraySource = model.array_2nd.mutableCopy;
    if (self.tableView) {
        [self.tableView reloadData];
    }
}

#pragma mark -初始化Tableview及delagate
- (void)configTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView = tableView;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kWhiteColor;
    self.backgroundView = backView;
    [_tableView registerNib:[UINib nibWithNibName:@"BP1STManualInsideHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BP1STManualInsideHeaderView"];
    [_tableView registerNib:[UINib nibWithNibName:@"BPS1STManualInsideTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BPS1STManualInsideTableViewCell"];
    _tableView.backgroundColor = kWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    BP1STManualInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BP1STManualInsideHeaderView"];
    [header setModel:_model section:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPS1STManualInsideTableViewCell";
    BPS1STManualInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    cell.wordMarkColorArray = self.wordMarkColorArray;
    [cell setModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _model.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMultiLevelCatalogueModel3rd *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.section);
    return model.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 1000;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
