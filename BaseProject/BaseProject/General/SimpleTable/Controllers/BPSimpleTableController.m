//
//  BPSimpleTableController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPSimpleTableController.h"
#import "BPSimpleTableViewCell.h"
#import "BPSimpleModel.h"
#import "BPSimpleViewModel.h"

@interface BPSimpleTableController ()
@property (strong, nonatomic) BPSimpleViewModel *viewModel;
@end

@implementation BPSimpleTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BPWhiteColor;
    [self handleData];
}

- (BPSimpleViewModel *)viewModel{
    if (!_viewModel) {
        BPSimpleViewModel *viewModel = [BPSimpleViewModel viewModelWithArray:self.dataArray];
        weakify(viewModel);
        [viewModel configTableviewCell:^BPSimpleTableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            BPSimpleTableViewCell *cell = [BPSimpleTableViewCell cellWithTableView:tableView];
            cell.model = viewModel.data[indexPath.row];
            return cell;
        }];

        _viewModel = viewModel;
    }
    return _viewModel;
}

- (void)handleData {
    self.tableView.dataSource = self.viewModel;
    [self refreshDataSuccessed];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BPSimpleModel *model = self.dataArray[indexPath.row];
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
