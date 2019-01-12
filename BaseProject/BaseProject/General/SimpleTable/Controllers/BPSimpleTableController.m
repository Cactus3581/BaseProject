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
#import "BPBaseWebViewController.h"

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
            [cell setModel:viewModel.data[indexPath.row] indexPath:indexPath];
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
        if (model.subVc_array.count) {
            BPSimpleTableController *vc = [[classVc alloc] init];
            [vc setLeftBarButtonTitle:model.title];
            //[vc setLeftBarButtonTitle:BPLocalizedString(bp_naviItem_backTitle)];
            vc.dataArray = model.subVc_array;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            BPBaseViewController * vc = [[classVc alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            //vc.navigationItem.title = model.title;
            [vc setLeftBarButtonTitle:model.title];
            NSDictionary *dict = @{@"type":@(indexPath.row)};
            model.dynamicJumpString = BPJSON(dict);// 暂时不用plist的元数据了，因为个人开发用，有些麻烦，如果正式用，必须用plist的数据
            vc.dynamicJumpString = model.dynamicJumpString;
            if (model.url) {
                [(BPBaseWebViewController *)vc setUrl:model.url];
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
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
