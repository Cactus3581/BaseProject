//
//  KSPhraseCardHeadCell.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSPhraseCardHeadCell.h"
#import "KSPhraseCardInsideTableViewCell.h"
#import "KSPhraseCardInsideHeaderView.h"

@interface KSPhraseCardHeadCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *arraySource;//显示的数据
@property (weak, nonatomic)  UITableView *tableView;
@property (nonatomic,strong) KSMultiLevelCatalogueModel2nd *model2nd;//显示的数据
@end

@implementation KSPhraseCardHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.arraySource = [NSMutableArray array];
        [self configTableView];
    }
    return self;
}

- (void)setModel:(KSMultiLevelCatalogueModel2nd *)model indexPath:(NSIndexPath *)indexPath {
    _model2nd = model;
    [self.arraySource removeAllObjects];
    self.arraySource = model.array_2nd.mutableCopy;
    [self.tableView reloadData];
}

#pragma mark -初始化Tableview及delagate
- (void)configTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView = tableView;
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = kWhiteColor;
    self.backgroundView = backView;
    [_tableView registerNib:[UINib nibWithNibName:@"KSPhraseCardInsideHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"KSPhraseCardInsideHeaderView"];
    [_tableView registerNib:[UINib nibWithNibName:@"KSPhraseCardInsideTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KSPhraseCardInsideTableViewCell"];
//    _tableView.backgroundColor = kGreenColor;
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return BPValidateArray(self.arraySource).count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KSPhraseCardInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KSPhraseCardInsideHeaderView"];
    [header setModel:_model2nd section:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"KSPhraseCardInsideTableViewCell";
    KSPhraseCardInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    KSMultiLevelCatalogueModel3rd *model3rd = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    [cell setModel:model3rd indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return _model2nd.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSMultiLevelCatalogueModel3rd *model3rd = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    return model3rd.cellHeight;
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
