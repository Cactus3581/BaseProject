//
//  BPSimpleTableController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/11/21.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPSimpleTableController.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "BPSimpleTableViewCell.h"
#import "BPSimpleModel.h"
#import "BPSimpleViewModel.h"
#import "BPBaseWebViewController.h"

@interface BPSimpleTableController ()<UITableViewDelegate>

@property (strong, nonatomic) BPSimpleViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;

@end


@implementation BPSimpleTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeUI];
}

- (BPSimpleViewModel *)viewModel{
    if (!_viewModel) {
        BPSimpleViewModel *viewModel;
        if (_dataArray.count) {
            viewModel = [BPSimpleViewModel viewModelWithArray:_dataArray];
        } else if (_url){
            viewModel = [BPSimpleViewModel viewModel];
            weakify(self);
            [viewModel setDataLoadWithUrl:_url successed:^(NSArray * _Nonnull dataSource) {
                strongify(self);
                self.dataArray = dataSource;
                [self.tableView reloadData];
            } failed:^{
            }];
        }
        
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

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[];
    }
    return _dataArray;
}

/*双击tabbar回调*/
- (void)tabbarDoubleClick {
    UIEdgeInsets inset = BPSafeAreaInset(self.view);
    [self.tableView setContentOffset:CGPointMake(0, -inset.top)  animated:YES];
}

#pragma mark - initialize methods
- (void)initializeUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.tableFooterView = [[UIView alloc]init];
    //self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    //self.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    //warning: 注意不能是CGFLOAT_MIN
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    self.tableView.dataSource = self.viewModel;
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
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath*)indexPath {
    
}

- (NSIndexPath *)getIndexPathWithPoint:(CGPoint)point{
    __block NSIndexPath *indexPath = nil;
    point = CGPointMake(point.x, self.tableView.contentOffset.y + point.y);
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            indexPath = [self.tableView indexPathForCell:cell];
        }
    }];
    return indexPath;
}

- (void)dealloc {
    
}

@end
