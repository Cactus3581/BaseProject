//
//  BP2NDCellAutoLayoutHeightViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP2NDCellAutoLayoutHeightViewController.h"
#import "BPCellAutoLayoutHeightTableViewCell.h"
#import "BPCellAutoLayoutHeightModel.h"
#import "BPCellAutoLayoutHeightDataSource.h"

static NSString *identifier = @"BPCellAutoLayoutHeightTableViewCell";
static CGFloat cellHeight = 100;

@interface BP2NDCellAutoLayoutHeightViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,assign) NSInteger heightTime;
@property (nonatomic,assign) NSInteger estimatedHeightTime;
@end

@implementation BP2NDCellAutoLayoutHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"reloaddata";
    [self configureTable];
}

- (void)configureTable {
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    /*
     此类下（systemLayoutSizeFittingSize）
     开启预估
     好处是：
     1. heightforrow减少调用次数，提示效率
     坏处：
     1. 滚动条不稳定
     2. reloaddata tableView自动滑动（虽然可以增加缓存的代码，可减少调用次数）
     坏处：
     */
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPCellAutoLayoutHeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    [cell set2ndModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static BPCellAutoLayoutHeightTableViewCell *cell;
    static dispatch_once_t onceToken;
    //必须使用
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    });
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    [cell set2ndModel:model indexPath:indexPath];
    // 根据当前数据，计算Cell的高度，注意+1是contentview和cell之间的分割线高度
    model.cell2ndHeight = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + kOnePixel;
    return model.cell2ndHeight;
}

#pragma mark -懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.backgroundColor = kWhiteColor;
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellAutoLayoutHeightTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BPCellAutoLayoutHeightTableViewCell"];
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

- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithArray:[BPCellAutoLayoutHeightDataSource array]];
    }
    return _array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
