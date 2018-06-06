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
#import "MJExtension.h"
#import "KSDictionaryPhrase+KSCardHeight.h"
static NSInteger limitNumber = 2;

@interface KSPhraseCardHeadCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *arraySource;//显示的数据
@property (nonatomic,strong) KSDictionarySubItemPhraseJx *model;
@property (nonatomic,assign) BOOL isShowAll;
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

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setModel:(KSDictionarySubItemPhraseJx *)model indexPath:(NSIndexPath *)indexPath showAll:(BOOL)showAll {
    _model = model;
    _isShowAll = showAll;
    [self.arraySource removeAllObjects];
    self.arraySource = model.lj.mutableCopy;
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
//    [self.contentView layoutIfNeeded];
//    [self layoutIfNeeded];

//    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(self.tableView.contentSize.height);
//    }];

    
    dispatch_async(dispatch_get_main_queue(), ^{
        //刷新完成

//        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(self.tableView.contentSize.height);
//        }];
//        [self.contentView layoutIfNeeded];

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

//    [_tableView registerNib:[UINib nibWithNibName:@"KSPhraseCardInsideHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"KSPhraseCardInsideHeaderView"];
//    [_tableView registerNib:[UINib nibWithNibName:@"KSPhraseCardInsideTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"KSPhraseCardInsideTableViewCell"];
    _tableView.backgroundColor = kLevelColor3;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
//    _tableView.bounces = NO;
//    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.estimatedSectionHeaderHeight = 30;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedRowHeight = 80;
    _tableView.rowHeight = UITableViewAutomaticDimension;

//    _tableView.estimatedRowHeight = 0;
//    _tableView.rowHeight = 0;
//
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.sectionHeaderHeight = 0;
    
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.sectionFooterHeight = 0;

    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
//        make.top.with.with.left.with.right.mas_equalTo(self.contentView);
//
//        make.bottom.equalTo(self.contentView).priorityLow();
//        make.height.mas_equalTo(self.tableView.contentSize.height);
    }];
}

#pragma mark - TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
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
//    KSPhraseCardInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KSPhraseCardInsideHeaderView"];
    
    static NSString *identifier = @"KSPhraseCardInsideHeaderView";
    KSPhraseCardInsideHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:@"KSPhraseCardInsideHeaderView" owner:nil options:nil] firstObject];
    }
    
    [header setModel:_model section:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"KSPhraseCardInsideTableViewCell";
//    KSPhraseCardInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    KSPhraseCardInsideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KSPhraseCardInsideTableViewCell" owner:nil options:nil] firstObject];
    }

    KSDictionarySubItemPhraseJxLj *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    cell.wordExchangeArray = self.wordExchangeArray;
    [cell setModel:model indexPath:indexPath];
    return cell;
}

// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static KSPhraseCardInsideTableViewCell *cell;
    static dispatch_once_t onceToken;
    //必须使用
    dispatch_once(&onceToken, ^{
//        cell = [tableView dequeueReusableCellWithIdentifier:@"KSPhraseCardInsideTableViewCell" forIndexPath:indexPath];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KSPhraseCardInsideTableViewCell" owner:nil options:nil] firstObject];

    });
    KSDictionarySubItemPhraseJxLj *model = BPValidateArrayObjAtIdx(self.arraySource,indexPath.row);
    cell.wordExchangeArray = self.wordExchangeArray;
    [cell setModel:model indexPath:indexPath];
    NSInteger height = ceil([cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kOnePixel);
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    static KSPhraseCardInsideHeaderView *header;
    static dispatch_once_t onceToken;
    //必须使用
    dispatch_once(&onceToken, ^{
//        header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KSPhraseCardInsideHeaderView"];
        header = [[[NSBundle mainBundle] loadNibNamed:@"KSPhraseCardInsideHeaderView" owner:nil options:nil] firstObject];

    });
    [header setModel:_model section:section];
    NSInteger height = ceil([header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
