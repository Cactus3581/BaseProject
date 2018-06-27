//
//  BP3RDCellAutoLayoutHeightViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP3RDCellAutoLayoutHeightViewController.h"
#import "BPCellAutoLayoutHeightTableViewCell.h"
#import "BPCellAutoLayoutHeightHeaderView.h"
#import "BPCellAutoLayoutHeightFooterView.h"
#import "Masonry.h"
#import "BPCellAutoLayoutHeightModel.h"
#import "BPCellAutoLayoutHeightDataSource.h"

@interface BP3RDCellAutoLayoutHeightViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,assign) CGFloat heightTime;
@property (nonatomic,assign) CGFloat estimatedHeightTime;
@end

@implementation BP3RDCellAutoLayoutHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeViews];
}

- (void)initializeViews {
    [self.tableView reloadData];
}

//下划线 循环引用
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.estimatedRowHeight = 0.0f;
        _tableView.backgroundColor = kWhiteColor;
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellAutoLayoutHeightHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BPCellAutoLayoutHeightHeaderView"];
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellAutoLayoutHeightTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BPCellAutoLayoutHeightTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"BPCellAutoLayoutHeightFooterView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"BPCellAutoLayoutHeightFooterView"];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    BPCellAutoLayoutHeightHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BPCellAutoLayoutHeightHeaderView"];
//    return header;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    BPCellAutoLayoutHeightFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BPCellAutoLayoutHeightFooterView"];
//    return footer;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPCellAutoLayoutHeightTableViewCell";
    BPCellAutoLayoutHeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    [cell set3rdModel:model indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPLog(@"self.heightTime = %.2f",++self.heightTime);
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    CGFloat height = [BPCellAutoLayoutHeightTableViewCell height3rdWithModel:model];
//    return model.cell3rdHeight;
    return height;
}

#pragma mark -懒加载
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
