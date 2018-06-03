//
//  KSPhraseCardViewController.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "KSPhraseCardViewController.h"
#import "KSPhraseCardHeadCell.h"
#import "KSPhraseCardHeaderView.h"
#import "KSDictionaryPhrase.h"
#import "KSDictionaryPhrase+KSCardHeight.h"

static NSInteger limitNumber = 2;
@interface KSPhraseCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *arraySource;//显示的数据
@property (nonatomic,strong) KSDictionaryPhrase *data;//显示的数据
@property (nonatomic,assign) BOOL isShowAll;

@end

@implementation KSPhraseCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowAll = YES;
    [self handleData];
    [self configTableView];
    [self.tableView reloadData];
}

- (void)handleData {
    KSDictionaryPhrase *dictionaryPhrase = [[KSDictionaryPhrase alloc] init];
    
    NSArray *array1 = @[@"all the go",@"as fra as it goes",@"as go",@"from the word go",@"get someone going",@"go figure!"];
    NSArray *array2 = @[@"考虑到它的局限性(在找理由表扬某事物时)",@"与一般的相比"];
    NSArray *array3 = @[@"to travel or move to a place that is away from where you are or where you live",@"There’s nothing more we can do here. Let’s go home "];

    NSArray *array4 = @[@"十英里路我们用了一个多小时。",@"这车开得太快了。"];
    
//    NSArray *array1 = @[@"all the go"];
//    NSArray *array2 = @[@"考虑到它的局限性(在找理由表扬某事物时)"];
//    NSArray *array3 = @[@"to travel or move to a place that is away from where you are or where you live"];
//
//    NSArray *array4 = @[@"十英里路我们用了一个多小时。"];
    NSMutableArray *muArray1 = @[].mutableCopy;
    [array1 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx1, BOOL * _Nonnull stop) {
        KSDictionarySubItemPhrase *model = [[KSDictionarySubItemPhrase alloc] init];
        model.cizu_name = title;
        NSMutableArray *tagArray = @[].mutableCopy;
        [array2 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx2, BOOL * _Nonnull stop) {
            KSDictionarySubItemPhraseJx *tagModel = [[KSDictionarySubItemPhraseJx alloc] init];
            tagModel.jx_en_mean = title;
            tagModel.jx_cn_mean = title;
            NSMutableArray *cellArray = @[].mutableCopy;
            [array3 enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx3, BOOL * _Nonnull stop) {
                KSDictionarySubItemPhraseJxLj *cellModel = [[KSDictionarySubItemPhraseJxLj alloc] init];
                cellModel.lj_ly = title;
                cellModel.lj_ls = array4[idx3];
                [cellArray addObject:cellModel];
            }];
            tagModel.lj = cellArray;
            [tagArray addObject:tagModel];
        }];
        model.jx = tagArray;
        [muArray1 addObject:model];
    }];
    
    dictionaryPhrase.phrases = muArray1.copy;
    
    self.data = dictionaryPhrase;
    
    self.arraySource = BPValidateArray(_data.phrases);
}

- (void)configTableView {
    self.tableView.backgroundColor = kLevelColor5;
    
    _tableView.estimatedRowHeight = 50;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedSectionHeaderHeight = 50;
    _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.sectionFooterHeight = 0;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tableView.bounces = NO;
//    self.tableView.scrollEnabled = NO;
}

#pragma mark - TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isShowAll) {
        return BPValidateArray(self.arraySource).count;
    }else {
        return BPValidateArray(self.arraySource).count > limitNumber ?  limitNumber : BPValidateArray(self.arraySource).count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    KSDictionarySubItemPhrase *model = BPValidateArrayObjAtIdx(self.arraySource, section);
//    if (self.isShowAll) {
//        return BPValidateArray(model.jx).count;
//    }else {
//        return BPValidateArray(model.jx).count > limitNumber ?  limitNumber : BPValidateArray(model.jx).count;
//    }
    return BPValidateArray(model.jx).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"KSPhraseCardHeadCell";
    KSPhraseCardHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[KSPhraseCardHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    KSDictionarySubItemPhrase *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    KSDictionarySubItemPhraseJx *model2 = BPValidateArrayObjAtIdx(model1.jx, indexPath.row);
    cell.wordExchangeArray = self.wordExchangeArray;
    [cell setModel:model2 indexPath:indexPath showAll:self.isShowAll];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *identifier = @"KSPhraseCardHeaderView";
    KSPhraseCardHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (!header) {
        header = [[[NSBundle mainBundle] loadNibNamed:@"KSPhraseCardHeaderView" owner:nil options:nil] firstObject];
    }
    KSDictionarySubItemPhrase *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    [header setModel:sectionModel section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static KSPhraseCardHeadCell *cell;
    static dispatch_once_t onceToken;
    //必须使用
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:@"KSPhraseCardHeadCell"];
    });
    KSDictionarySubItemPhrase *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    KSDictionarySubItemPhraseJx *model2 = BPValidateArrayObjAtIdx(model1.jx, indexPath.row);
    cell.wordExchangeArray = self.wordExchangeArray;
    [cell setModel:model2 indexPath:indexPath showAll:self.isShowAll];
    // 根据当前数据，计算Cell的高度，注意+1是contentview和cell之间的分割线高度
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kOnePixel;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    KSDictionarySubItemPhrase *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
//    self.sectionHeight = sectionModel.headerHeight;
//    return sectionModel.headerHeight;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    KSDictionarySubItemPhrase *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,indexPath.section);
//    KSDictionarySubItemPhraseJx *model = BPValidateArrayObjAtIdx(sectionModel.jx, indexPath.row);
//    return model.cellHeight;
//}

// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)cardViewHeightWithMaxWidth:(CGFloat)maxWidth {
    [self.view layoutIfNeeded];
    return self.tableView.contentSize.height ;
}

- (NSArray *)arraySource {
    if (!_arraySource) {
        _arraySource = [NSArray array];
    }
    return _arraySource;
}

//旋转事件，需要重新计算cell高度
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self handleData];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
    }];
}

- (void)dealloc {
    
}

@end
