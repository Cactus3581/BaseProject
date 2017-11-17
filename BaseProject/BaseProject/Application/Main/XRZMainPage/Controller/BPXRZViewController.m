//
//  BPXRZViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPXRZViewController.h"
#import "BPMasterCatalogueModel.h"
#import "BPXRZViewModel.h"
#import "BPXRZTableViewCell.h"

@interface BPXRZViewController ()
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) BPXRZViewModel *viewModel;
@end

@implementation BPXRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self handleData];
}

- (BPXRZViewModel *)viewModel{
    if (!_viewModel) {
        BPXRZViewModel *viewModel = [BPXRZViewModel viewModel];
        weakify(viewModel);
        [viewModel configTableviewCell:^BPXRZTableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            BPXRZTableViewCell *cell = [BPXRZTableViewCell cellWithTableView:tableView];
            cell.model = viewModel.data[indexPath.row];
            return cell;
        }];
        weakify(self);
        [viewModel setDataLoadSuccessedConfig:^{
            strongify(self);
            [self refreshDataSuccessed];
        } failed:^{
            strongify(self);
            [self refreshDataFailed];
        }];
        _viewModel = viewModel;
    }
    return _viewModel;
}

- (void)handleData {
    self.tableView.dataSource = self.viewModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BPMasterCatalogueModel *model = self.dataArray[indexPath.row];
    NSString *className = model.fileName;
    Class classVc = NSClassFromString(className);
    if (classVc) {
        UIViewController *vc = [[classVc alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
