//
//  BPManualLayoutCellHeightViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/22.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPManualLayoutCellHeightViewController.h"
#import "BPCellHeightAutoLayoutTextViewTableViewCell.h"
#import "BPCellHeightAutoLayoutLabelTableViewCell.h"
#import "YYFPSLabel.h"
#import "BPCellAutoLayoutHeightModel.h"
#import "BPCellAutoLayoutHeightDataSource.h"

@interface BPManualLayoutCellHeightViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableDictionary *heightAtIndexPath;
@end

static NSString *labelCellIde = @"BPCellHeightAutoLayoutLabelTableViewCell";
static NSString *textViewCellIde = @"BPCellHeightAutoLayoutTextViewTableViewCell";
static CGFloat cellHeight = 100;

@implementation BPManualLayoutCellHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"reloaddata";
    [self configureTable];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self.tableView reloadData];
}

#pragma mark - iOS 8自动计算（方法一代码）
- (void)configureTable {
    //PS：iOS8 系统中 rowHeight 的默认值已经设置成了 UITableViewAutomaticDimension，所以第二行代码可以省略。
    self.tableView.estimatedRowHeight = cellHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //禁止系统自动对scrollview调整contentInsets的。
    /*
     if (kiOS11) {
     _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
     }else {
     self.automaticallyAdjustsScrollViewInsets = NO;
     }
     */
}

#pragma mark - TableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BPLog(@"");
    return self.array.count;
}

#pragma mark -  iOS 8自动计算（方法二代码）
//PS：iOS8 系统中 rowHeight 的默认值已经设置成了 UITableViewAutomaticDimension，所以第二行代码可以省略。
#pragma mark - 返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPLog(@"");
    return UITableViewAutomaticDimension;
}

//在加载的时候一次性就调用完了，后面不会再调，除非reloaddata
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    BPLog(@"");
    if(height) {
        return height.floatValue;
    }
    else {
        return cellHeight;
    }
}

#pragma mark -  生成UIView子类实例
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPCellHeightAutoLayoutLabelTableViewCell";
    BPCellHeightAutoLayoutLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    [cell set1stModel:model indexPath:indexPath];
    BPLog(@"");
    return cell;
}

#pragma mark - 高度缓存：1. 为了防止重新计算，提高效率性能 2.刷新再点击状态栏，不能精确滚动到顶部
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
    BPLog(@"");
}

#pragma mark -懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.backgroundColor = kWhiteColor;
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellHeightAutoLayoutLabelTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BPCellHeightAutoLayoutLabelTableViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

//数据源
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithArray:[BPCellAutoLayoutHeightDataSource array]];
        [YYFPSLabel bp_addFPSLableOnWidnow];
    }
    return _array;
}

//缓存高度数据
- (NSMutableDictionary *)heightAtIndexPath {
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [NSMutableDictionary dictionary];
    }
    return _heightAtIndexPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
