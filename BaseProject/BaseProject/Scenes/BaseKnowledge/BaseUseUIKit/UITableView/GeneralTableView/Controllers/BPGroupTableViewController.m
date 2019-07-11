//
//  BPGroupTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/3.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPGroupTableViewController.h"
#import "BPTableViewCell.h"

/*
 1. cgfloat_min 待商榷
 2. table及cell样式，及点击颜色
 3. 编辑cell
 4. 缺少nib
 */

static NSString *cell_identifier = @"BPTableViewCell";
static NSString *header_identifier = @"header";
static NSString *footer_identifier = @"footer";

static CGFloat headerH = 100;
static CGFloat footerH = 100;
static CGFloat section_headerH = 80;
static CGFloat section_footerH = 60;
static CGFloat cellH = 50;

@interface BPGroupTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation BPGroupTableViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"获取";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
        make.trailing.equalTo(self.view);
    }];
    
    _tableView.contentInset = UIEdgeInsetsMake(30, 0, 30, 0);
}

- (void)rightBarButtonItemClickAction:(id)sender {
    
    // 根据指定 index 获取 cell
    BPTableViewCell *visibleCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    BPLog(@"visibleCell text = %@",visibleCell.textLabel.text);

    // 根据指定 cell 获取 index
    NSIndexPath *indexPath = [_tableView indexPathForCell:visibleCell];
    BPLog(@"visibleCell section = %ld,row = %ld",(long)indexPath.section,(long)indexPath.row);

    // 获取 cell 在self.view上的位置
    CGRect rect = [_tableView convertRect:visibleCell.frame toView:self.view];
    BPLog(@"rect = %@",NSStringFromCGRect(rect));
    
    // 根据指定 index 获取 cell 相对于 tableView 的 Rect
    CGRect visibleCellRect = [_tableView rectForRowAtIndexPath:indexPath];
    BPLog(@"visibleCellRect = %@",NSStringFromCGRect(visibleCellRect));

    CGRect visibleCellRect1 = [_tableView rectForRowAtIndexPath:indexPath];
    BPLog(@"y = %.2f",visibleCellRect1.origin.y +_tableView.contentInset.top);
    
    BPTableViewCell *lastVisibleCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:4]];
    BPLog(@"lastVisibleCell text = %@",lastVisibleCell.textLabel.text);
    
    // 根据指定 cell 获取 index
    NSIndexPath *lastIndexPath = [_tableView indexPathForCell:lastVisibleCell];
    BPLog(@"lastVisibleCell section = %ld,row = %ld",(long)lastIndexPath.section,(long)lastIndexPath.row);
    
    // 根据指定 index 获取 cell 的 Rect
    CGRect lastVisibleCellRect = [_tableView rectForRowAtIndexPath:lastIndexPath];
    BPLog(@"lastVisibleCellRect = %@",NSStringFromCGRect(lastVisibleCellRect));
    
    // 获取可见的 IndexPaths 数组
    NSArray *visibleCellIndexPaths = [_tableView indexPathsForVisibleRows];
    [visibleCellIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        BPLog(@"section = %ld,row = %ld",(long)indexPath.section,(long)indexPath.row);
    }];
    
    // 获取可见的 cell 数组
    NSArray *visibleCells = [_tableView visibleCells];
    [visibleCells enumerateObjectsUsingBlock:^(BPTableViewCell *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        BPLog(@"text = %@",cell.textLabel.text);
    }];
}

#pragma mark - 注册cell
- (void)register_tableView_nib {
    [self.tableView registerNib:[BPTableViewCell bp_loadNib] forCellReuseIdentifier:cell_identifier];
    //[self.tableView registerNib:[UITableViewHeaderFooterView bp_loadNib] forCellReuseIdentifier:header_identifier];
    //[self.tableView registerNib:[UITableViewHeaderFooterView bp_loadNib] forCellReuseIdentifier:footer_identifier];
}

#pragma mark - cell刷新方法
- (void)reloadData {
    [self.tableView reloadData];// 重新载入tableview所有cell  一般是在数据源有改变的时候
    [self.tableView reloadSectionIndexTitles];// 重新载入，section的索引标题。reloads the index bar.
}

#pragma mark - UITableView滚动方法
- (void)scrollToRowAtIndexPath {
    // 根据传入的indexPath，滚动到相对应的位置，第二个参数是控制对应的cell再滚动后处于tableview的顶部/底部/中部等
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
    // 滚动到被选中项。  滚动后处于tableview的顶部/底部/中部等
    [self.tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark - UITableViewDataSource
// 返回多少组,没实现该方法,默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

// 返回第section组中有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];
    [cell setText:[NSString stringWithFormat:@"我是第%ld区 第%ld个cell",indexPath.section,indexPath.row] indexPath:indexPath];
    return cell;
}

// 返回某个section对应的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"header标题";
}

// 返回某个section对应的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @"footer标题";
}

#pragma mark - UITableViewDelegate

#pragma mark - 高度代理方法
// 设置header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
    return section_headerH;
}

// 设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return CGFLOAT_MIN;
    return section_footerH;
}

// 设置某行cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellH;
}

#pragma mark - 设置分组View的方法
// 设置第section分组的header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //UIView  *headerView = [UIView bp_loadInstanceFromNib];
    UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectZero];
    headerView.backgroundColor = kRedColor;
    headerView.text = [NSString stringWithFormat:@"我是Section Header:第%ld区",section];
    return headerView;
}

// 返回某个section对应的footer标题
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    //UIView *footerView = [UIView bp_loadInstanceFromNib];
    UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = kWhiteColor;
    footerView.text = [NSString stringWithFormat:@"我是Section Footer:第%ld区",section];
    return footerView;
}

#pragma mark - 操作cell时调用的方法
// cell选中时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //反选 点击的时候灰色 返回来的时候又变回白色
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// cell取消选中时调用
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDelegate代理方法

#pragma mark - Cell显示过程代理方法
// 即将显示tableviewcell时调用
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

// 即将显示header时调用，在cell之后调用
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
}

// 即将显示footer时调用，在header之后调用
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

// 停止显示cell的时候调用,在删除cell之后调用，界面不显示cell时。
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
}

// 停止显示header的时候调用
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
}

// 停止显示footer的时候调用
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

#pragma mark - 编辑模式相关的代理方法
// 返回每一行cell的编辑模式， 可以再次设置add或者删除操作。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

// cell左滑删除时，删除按钮的标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"";

}

// 自定义编辑左滑后出现的界面。  不止只有一个delete按钮， 可以自行定义，返回一个数组。数组中放着UITableviewRowAction
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @[];
}

// 未实现 默认为yes,进入编辑时，cell是否缩进。  在开启编辑状态时调用。
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 右滑准备进行编辑的时候 调用。 将setediting = yes时不调用
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// 完成编辑的时候调用
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - 索引
//返回要显示的section索引标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[];

}
// return list of section titles to display in section index view (e.g. "ABCD...Z#")
// 点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

// 返回指定点所在位置的indexPath
- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point {
    return [NSIndexPath indexPathWithIndex:0];
}
// 返回指定cell所在的indexPath
- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell {
    return [NSIndexPath indexPathWithIndex:0];

}
// 返回指定范围rect中的所有cell的indexPath
- (NSArray *)indexPathsForRowsInRect:(CGRect)rect {
    // returns nil if rect not valid
    return @[];
}

// 返回索引indexPath所指向的cell。
- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark -  插入,删除,刷新,移动section组
// 插入section
- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    
}
// 删除section
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    
}
// 刷新section
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    
}

// 移动section
- (void)moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    
}

#pragma mark - TableView 属性相关
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 45;
        _tableView.sectionHeaderHeight = 45;
        _tableView.sectionFooterHeight = 45;

        //分割线位置及颜色
        _tableView.separatorColor = kThemeColor;
        _tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);// 设置端距，这里表示separator离左边和右边均0像素
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        //估算高度,默认0
        //warning: 注意不能是CGFLOAT_MIN
        _tableView.estimatedRowHeight = 0; //iOS11之前，默认为0，之后自动计算
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = kPurpleColor;
        
        UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerH)];
        headerView.backgroundColor = kGreenColor;
        headerView.text = @"我是tableHeader";
        UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, footerH)];
        footerView.backgroundColor = kWhiteColor;
        footerView.text = @"我是tablefooter";
        _tableView.tableHeaderView = headerView;
        _tableView.tableFooterView = footerView;
        [self register_tableView_nib]; //注册cell的时机
        
        // 设置允许多选
        _tableView.allowsMultipleSelection = YES;
    }
    return _tableView;
}



- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - dealloc
- (void)dealloc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

