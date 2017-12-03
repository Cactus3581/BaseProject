//
//  BPXRZViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/1.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPXRZViewController.h"
#import "BPSimpleModel.h"
#import "BPXRZViewModel.h"
#import "BPSimpleTableViewCell.h"
#import "BPSimpleTableController.h"

@interface BPXRZViewController ()
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) BPXRZViewModel *viewModel;
@end

@implementation BPXRZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BPWhiteColor;
    [self handleData];
}

- (BPXRZViewModel *)viewModel{
    if (!_viewModel) {
        BPXRZViewModel *viewModel = [BPXRZViewModel viewModel];
        weakify(viewModel);
        [viewModel configTableviewCell:^BPSimpleTableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            BPSimpleTableViewCell *cell = [BPSimpleTableViewCell cellWithTableView:tableView];
            cell.model = viewModel.data[indexPath.row];
            return cell;
        }];
        weakify(self);

        [viewModel setDataLoadSuccessedConfig:^(NSArray * _Nonnull dataSource) {
            strongify(self);
            self.dataArray = dataSource;
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
    BPSimpleModel *model = self.dataArray[indexPath.row];
    NSString *className = model.fileName;
    Class classVc = NSClassFromString(className);
    if (classVc) {
        if (model.subVc_array.count) {
            BPSimpleTableController *vc = [[classVc alloc] init];
            vc.dataArray = model.subVc_array;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            UIViewController * vc = [[classVc alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
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
