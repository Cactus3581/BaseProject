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
    self.view.backgroundColor = kWhiteColor;
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
        BPBaseViewController *vc = [[classVc alloc] init];
        [vc setLeftBarButtonTitle:model.title];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //点击后取消选中颜色。同[self.tableView deselectRowAtIndexPath:indexPath animated:NO];效果
    BPSimpleTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath*)indexPath {

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
