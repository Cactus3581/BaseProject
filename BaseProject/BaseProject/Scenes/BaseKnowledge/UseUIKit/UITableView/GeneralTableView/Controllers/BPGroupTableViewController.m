//
//  BPGroupTableViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/3.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPGroupTableViewController.h"
#import "BPTableViewCell.h"
#import "BPTableViewSectionHeaderView.h"
#import "BPTableViewSectionFooterView.h"
#import "BPTableViewModel.h"
#import "MJExtension.h"
#import "UIResponder+BPMsgSend.h"

/*
 2. table及cell样式，及点击颜色
 3. 编辑cell
 */

static NSString *cellIdentifier = @"BPTableViewCell";
static NSString *sectionHeaderViewIdentifier = @"sectionHeaderView";
static NSString *sectionFooterViewIdentifier = @"sectionFooterView";

static CGFloat tableHeaderViewHeight = 200;
static CGFloat tableFooterViewHeight = 200;
static CGFloat sectionHeaderViewHeight = 150;
static CGFloat sectionFooterViewHeight = 150;
static CGFloat cellHeight = 100;


@interface BPGroupTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end


@implementation BPGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self getCellAndFrame];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count; // 默认为1
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BPTableViewModel *model = _dataArray[section];
    return model.array.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPTableViewModel *model = _dataArray[section];
    BPTableViewSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderViewIdentifier];
    headerView.label.text = model.sectionHeaderText;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    BPTableViewModel *model = _dataArray[section];
    BPTableViewSectionFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionFooterViewIdentifier];
    if (!footerView) {
        footerView = [[BPTableViewSectionFooterView alloc] initWithReuseIdentifier:sectionFooterViewIdentifier];
    }
    footerView.label.text = model.sectionFooterText;
    return footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPTableViewModel *model = _dataArray[indexPath.section];
    BPTableViewItemModel *itemModel = model.array[indexPath.row];
    BPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setText:itemModel.text indexPath:indexPath];
    return cell;
}

#pragma mark - 消息传递：响应者链
// 多层级View的通信，替代其他几种设计模式
- (void)bp_routerEventWithName:(NSString *)eventName userInfo:(NSObject *)userInfo {
    NSLog(@"%s eventName:%@",__func__,eventName);
}

#pragma mark - UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return sectionFooterViewHeight; // 使用CGFLOAT_MIN替代0。若返回0会按原来的默认值。
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return sectionHeaderViewHeight;
}

#pragma mark - Cell 高度计算/缓存
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消选中后显示的高亮状态,也就是只在选中的那一刻出现高亮
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 取消选中某行cell会调用 (当我选中第0行的时候，如果现在要改为选中第1行 - 》会先取消选中第0行，然后调用选中第1行的操作)
- (void)tableView:(nonnull UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"取消选中 didDeselectRowAtIndexPath row = %ld ", indexPath.row);
}

// 即将显示cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

// 即将显示header
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
}

// 即将显示footer
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

// cell的缩进级别
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

#pragma mark - 获取cell、indexPath、rect、point
- (void)getCellAndFrame {
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    BPTableViewModel *model = _dataArray.lastObject;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:model.array.count-1 inSection:_dataArray.count-1];
    
//    [self getInfoFromIndexPath:firstIndexPath];
    [self getInfoFromIndexPath:lastIndexPath];
}

- (void)getInfoFromIndexPath:(NSIndexPath *)indexPath {
    
    // 根据指定 IndexPath 获取 cell
    BPTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        BPLog(@"cell text = %@",cell.textLabel.text);
    }
    
    // 根据指定 cell 获取 IndexPath
    NSIndexPath *indexPath1 = [_tableView indexPathForCell:cell];
    if (indexPath1) {
        BPLog(@"indexPath section = %ld,row = %ld",(long)indexPath1.section,(long)indexPath1.row);
    }
    
    // 获取可见的 cell 数组
    NSArray *cells = [_tableView visibleCells];
    [cells enumerateObjectsUsingBlock:^(BPTableViewCell *cell, NSUInteger idx, BOOL * _Nonnull stop) {
        BPLog(@"cells：text = %@",cell.textLabel.text);
    }];
    
    // 获取可见的 IndexPaths 数组
    NSArray *indexPaths = [_tableView indexPathsForVisibleRows];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        BPLog(@"indexPath：section = %ld,row = %ld",(long)indexPath.section,(long)indexPath.row);
    }];
    
    // 获取 cell 在self.view上的位置
    CGRect rect = [_tableView convertRect:cell.frame toView:self.view];
    if (!CGRectIsNull(rect)) {
        BPLog(@"self.view rect = %@",NSStringFromCGRect(rect));
    }
    
    // 根据指定 index 获取 cell 相对于 tableView 的 Rect
    CGRect rect1 = [_tableView rectForRowAtIndexPath:indexPath];
    if (!CGRectIsNull(rect1)) {
        BPLog(@"tableView rect = %@",NSStringFromCGRect(rect1));
    }

    // 根据point 获取 indexpath
    NSIndexPath *indexPath2 = [_tableView indexPathForRowAtPoint:_tableView.contentOffset];
    if (indexPath) {
        BPLog(@"indexPath：section = %ld,row = %ld",(long)indexPath2.section,(long)indexPath2.row);
    }
    
    // 返回指定范围rect中的所有cell的indexPath
    indexPaths = [_tableView indexPathsForRowsInRect:rect1];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indexPath, NSUInteger idx, BOOL * _Nonnull stop) {
        BPLog(@"indexPath：section = %ld,row = %ld",(long)indexPath.section,(long)indexPath.row);
    }];
}

#pragma mark - 插入，删除，刷新（先修改数据再修改UI）
- (IBAction)insertAction:(id)sender {
    
    // 插入一个区

    /*
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];

    BPTableViewModel *model = [[BPTableViewModel alloc] init];
    
    model.sectionHeaderText = [NSString stringWithFormat:@"SectionHeader：第%ld区",0];
    model.sectionFooterText = [NSString stringWithFormat:@"SectionFooter：第%ld区",0];
    
    NSMutableArray *muArray = @[].mutableCopy;
    for (int j = 0; j<1; j++) {
        BPTableViewItemModel *itemModel = [[BPTableViewItemModel alloc] init];
        itemModel.text = [NSString stringWithFormat:@"Cell：第%ld区，第%ld行",0,j];
        [muArray addObject:itemModel];
    }
    model.array = muArray.copy;
    
    [_tableView beginUpdates];
    
    // 插入分区
    [_dataArray insertObject:model atIndex:0];

    [_tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
    [_tableView endUpdates];

     */
    
    // 插入一些行

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];

    BPTableViewModel *model = _dataArray[0];
    
    NSMutableArray *muArray = model.array.mutableCopy;
    BPTableViewItemModel *itemModel = [[BPTableViewItemModel alloc] init];
    itemModel.text = [NSString stringWithFormat:@"Cell：第%ld区，第%ld行",0,0];
    [muArray addObject:itemModel];
    model.array = muArray.copy;

    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (IBAction)deleteAction:(id)sender {
    
    // 删除分区
//    [_dataArray removeObjectAtIndex:0];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:0];
//    [_tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
    // 删除一些行
    BPTableViewModel *model = _dataArray[0];
    
    NSMutableArray *muArray = model.array.mutableCopy;
    [muArray removeObjectAtIndex:0];
    model.array = muArray.copy;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 刷新方法
- (IBAction)reloadAction:(id)sender {
    
    // 全局刷新
    [_tableView reloadData];
    
    // 局部刷新：前提是模型数据的个数不变，修改模型（不修改模型个数）之后进行局部刷新
    
    // 刷新一个分区
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
    // 刷新一些行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    

    // 刷新索引栏：新加或者删除了索引类别而无需刷新整个表视图的情况下。
    [_tableView reloadSectionIndexTitles];
    
    [_tableView performBatchUpdates:^{
        
    } completion:^(BOOL finished) {
        
    }];
    
    // 刷新行高
    [_tableView beginUpdates];
    [_tableView beginUpdates];
}

- (IBAction)editAction:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (IBAction)moveAction:(id)sender {
    
    _tableView.editing = true;

    // 移动一个分区
    [_tableView moveSection:0 toSection:1];
    
    // 移动某行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [_tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

#pragma mark - 移动

// 设置 cell 是否允许移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 设置能否被移动
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    // 一般,移动都是发生在同区之间,数据在不同区之间移动,那么数据一开始就应该不会编辑到一个区
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        // 允许移动(目的地)
        return proposedDestinationIndexPath;
    }else{
        // 不允许移动(源始地)
        return sourceIndexPath;
    }
}

// 移动 cell 时触发
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 移动cell之后更换数据数组里的循序
    [self.dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
    BPTableViewModel *model = _dataArray[destinationIndexPath.section];
    NSMutableArray *muArray = model.array.mutableCopy;
    [muArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}

#pragma mark - 编辑：左滑/删除/添加

// 设置 cell 是否允许被编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 返回编辑样式,是添加还是删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 第3个分区进行增加操作
    if (indexPath.section == 0) {
        return  UITableViewCellEditingStyleInsert;
    }
    // 其余分区进行删除操作
    return UITableViewCellEditingStyleDelete;
}

// 设置默认的左滑按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

// 设置左滑显示对应按钮及其处理事件
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 创建第一个按钮和触发事件
    UITableViewRowAction *cellActionA = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"按钮-1" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // 在此写点击按钮时的触发事件
        // ......
        NSLog(@"点击了 按钮-1");
    }];
    // 定义按钮的颜色
    cellActionA.backgroundColor = [UIColor greenColor];
    
    // 创建第二个按钮和触发事件
    UITableViewRowAction *cellActionB = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"按钮-2" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // 在此写点击按钮时的触发事件
        // ......
    }];
    // 注意这里返回的是一个按钮组，即使只定义了一个按钮也要返回一个组
    return @[cellActionA, cellActionB];
}

// 点击左滑出现的按钮时触发
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击左滑出现的按钮时触发");
    
    // 判断状态
    // 删除数据
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:{
            // 做判断,如果
            if ([_dataArray count] > 1) {
                
                // 先删除数据
                [[_dataArray objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
                // 删除cell(指定行)
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section], nil]
                                 withRowAnimation:UITableViewRowAnimationLeft];
            }else{
                // 直接移除掉整个数组
                [_dataArray removeObjectAtIndex:indexPath.section];
                // 删除整个分区
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
            }
        }
            break;
            
        case UITableViewCellEditingStyleInsert:{
            // 先添加数据源
            [[_dataArray objectAtIndex:indexPath.section] addObject:@""];
            // 自定义要插入的行数(indexPath.row + ?(?>0) ?是几就代表添加的数据会出现在+号下面的几个位置处 ?为0就会出现在点击加号那一行的上面)
            NSIndexPath * selfIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:selfIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
            break;
    }
}

// 左滑结束时调用(只对默认的左滑按钮有效，自定义按钮时这个方法无效)
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"左滑结束");
}

#pragma mark - 滚动跳转
- (void)scrollToRowAtIndexPath {
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    // 根据传入的indexPath，滚动到相对应的位置，第二个参数是控制对应的cell再滚动后处于tableview的顶部/底部/中部等
    [_tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    // 滚动到被选中项 滚动后处于tableview的顶部/底部/中部
    [_tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    // UIScroll的方法
    [_tableView scrollRectToVisible:CGRectZero animated:YES];
    [_tableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - 实现水平滚动
- (void)scrollToRowAtIndexPath1 {
    _tableView.transform;// cell 也要旋转；
}



#pragma mark - 索引
//返回要显示的section索引标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexs = @[].mutableCopy;
    for(BPTableViewModel *model in _dataArray){
        [indexs addObject:model.indexName];
    }
    return indexs.copy;
}

// 点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

#pragma mark - TableView 属性

- (void)initializeViews {
    self.rightBarButtonTitle = @"获取";
    
    _dataArray = [NSMutableArray array];
    NSArray *poem = @[@"登鹳雀楼",@"悯农",@"静夜思"];
    NSArray *indexName = @[@"A",@"B",@"C"];

    NSArray *author = @[@"出自王之涣",@"出自李绅",@"出自李白"];

    NSArray *poem0 = @[@"白日依山尽",@"黄河入海流",@"欲穷千里目",@"更上一层楼"];
    NSArray *poem1 = @[@"锄禾日当午",@"汗滴禾下土",@"谁知盘中餐",@"粒粒皆辛苦"];
    NSArray *poem2 = @[@"床前明月光",@"疑是地上霜",@"举头望明月",@"低头思故乡"];
    NSArray *array = @[poem0,poem1,poem2];

    [poem enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL * _Nonnull stop) {
       
        BPTableViewModel *model = [[BPTableViewModel alloc] init];
        model.sectionHeaderText = name;
        model.sectionFooterText = author[idx];
        model.indexName = indexName[idx];
        
        NSMutableArray *muArray = @[].mutableCopy;
        [array[idx] enumerateObjectsUsingBlock:^(NSString *lineText, NSUInteger idx, BOOL * _Nonnull stop) {
            BPTableViewItemModel *itemModel = [[BPTableViewItemModel alloc] init];
            itemModel.text = lineText;
            [muArray addObject:itemModel];
        }];
        model.array = muArray.copy;
        
        [_dataArray addObject:model];
    }];

    // tableView为Group样式时，默认section有Header并显示
    
    //当有导航栏时tableview默认会自动从导航栏下方开始布局
    if (kiOS11) {
        //_tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // _tableView.backgroundColor = kWhiteColor;
    // 设置tableView的背景图
    _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"humingtao.png"]];

    //_tableView.contentInset = UIEdgeInsetsMake(30, 0, 30, 0);
    _tableView.showsVerticalScrollIndicator = YES;
    
    //设置代理和数据源
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //分割线位置及颜色
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorColor = kThemeColor;
    _tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);// 设置端距，这里表示separator离左边和右边均0像素
    
    // 针对所有 Cell设置高度
    _tableView.rowHeight = 45;
    _tableView.sectionHeaderHeight = 45;
    _tableView.sectionFooterHeight = 45;
    
    // 针对所有 Cell设置估算高度 注意不能是CGFLOAT_MIN
    _tableView.estimatedRowHeight = 0; //iOS11之前，默认为0，之后自动计算
    _tableView.rowHeight = UITableViewAutomaticDimension;

    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    
    // 设置索引条内部文字颜色
    _tableView.sectionIndexColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    // 设置索引条背景颜色
    _tableView.sectionIndexBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    // 设置滑动条的内边距
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //设置 tableHeaderView：grouped类型的tableview，height = CGFLOAT_MIN
    
    
    UILabel *tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tableHeaderViewHeight)];
    tableHeaderView.font = [UIFont systemFontOfSize:15];
    tableHeaderView.text = @"我是tableHeaderView";
    _tableView.tableHeaderView = tableHeaderView;

    UILabel *tableFooterView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tableFooterViewHeight)];
    tableFooterView.font = [UIFont systemFontOfSize:15];
    tableFooterView.text = @"我是tableFooterView";
    _tableView.tableFooterView = tableFooterView; // 也去除UITableview底部空白的cell
    
    // 注册
    [_tableView registerNib:[BPTableViewCell bp_loadNib] forCellReuseIdentifier:cellIdentifier];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    [_tableView registerNib:[BPTableViewSectionHeaderView bp_loadNib] forHeaderFooterViewReuseIdentifier:sectionHeaderViewIdentifier];
    [_tableView registerClass:[BPTableViewSectionFooterView class] forHeaderFooterViewReuseIdentifier:sectionFooterViewIdentifier];
    
    // 设置允许多选
    _tableView.allowsMultipleSelection = YES;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - dealloc
- (void)dealloc {
    
}

@end
