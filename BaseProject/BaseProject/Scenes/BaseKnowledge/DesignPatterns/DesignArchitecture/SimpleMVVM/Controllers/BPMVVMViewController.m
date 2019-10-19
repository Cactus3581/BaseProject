//
//  BPMVVMViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/1/16.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPMVVMViewController.h"
#import "BPMVVMModel.h"
#import "BPMVVMViewModel.h"
#import "BPMVVMTableViewCell.h"
#import <Masonry.h>

@interface BPMVVMViewController ()<UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) BPMVVMViewModel *viewModel;
@property (strong, nonatomic) NSArray *dataArray;
@end

@implementation BPMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUI];
    self.tableView.dataSource = self.viewModel;
}

- (BPMVVMViewModel *)viewModel {
    if (!_viewModel) {
        BPMVVMViewModel *viewModel = [BPMVVMViewModel viewModel];
        _viewModel = viewModel;

        // 请求数据
        weakify(self);
        [viewModel setDataLoadSuccessedConfig:^(NSArray * _Nonnull dataSource) {
            strongify(self);
            self.dataArray = dataSource;
            [self.tableView reloadData];
        } failed:^{
        }];
        
        // TableView DataSource 的回调
        weakify(viewModel);
        [viewModel configTableviewCell:^BPMVVMTableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            BPMVVMTableViewCell *cell = [BPMVVMTableViewCell cellWithTableView:tableView];
            [cell setModel:viewModel.data[indexPath.row] indexPath:indexPath];
            return cell;
        }];
    }
    return _viewModel;
}

#pragma mark - initialize methods
- (void)initializeUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = kWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableHeaderView = [[UIView alloc]init];
    _tableView.tableFooterView = [[UIView alloc]init];
    
    //warning: 注意不能是CGFLOAT_MIN
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
