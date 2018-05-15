//
//  BP1STCellAutoLayoutHeightViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/16.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BP1STCellAutoLayoutHeightViewController.h"
#import "BPCellAutoLayoutHeightTableViewCell.h"
#import "BPCellAutoLayoutHeightHeaderView.h"
#import "BPCellAutoLayoutHeightFooterView.h"
#import "Masonry.h"
#import "BPCellAutoLayoutHeightModel.h"
#import "BPCellAutoLayoutHeightDataSource.h"
#import "YYFPSLabel.h"

@interface BP1STCellAutoLayoutHeightViewController () <UITableViewDelegate,UITableViewDataSource,BPCellAutoLayoutHeightHeaderViewDelegate,BPCellAutoLayoutHeightFooterViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableDictionary *heightAtIndexPath;
@property (nonatomic,assign) CGFloat sectionHeaderHeight;
@property (nonatomic,assign) CGFloat sectionFooterHeight;
@end

@implementation BP1STCellAutoLayoutHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTable];
}

- (void)configureTable {
    [self.tableView reloadData];
}

//下划线 循环引用
- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.backgroundColor = kWhiteColor;
        //iOS 8自动计算（方法一代码）
        _tableView.estimatedRowHeight = 80.0f;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionHeaderHeight = 80.0f;
        _tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        _tableView.estimatedSectionFooterHeight = 80.0f;
        _tableView.sectionFooterHeight = UITableViewAutomaticDimension;
        //禁止系统自动对scrollview调整contentInsets的。
//        if (kiOS11) {
//            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }else {
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
        //iOS11下默认开启自动算高。不想使用Self-Sizing的话，可以通过以下方式关闭：
        //_tableView.estimatedRowHeight = 0;
        //_tableView.estimatedSectionHeaderHeight = 0;
        //_tableView.estimatedSectionFooterHeight = 0;
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

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
//    if(height) {
//        return height.floatValue;
//    }
//    else {
//        return 100;
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
//    return 80;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
//    return 80;
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    self.sectionHeaderHeight = view.frame.size.height;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    self.sectionFooterHeight =  view.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BPCellAutoLayoutHeightHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BPCellAutoLayoutHeightHeaderView"];
    header.delegate = self;
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    BPCellAutoLayoutHeightFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BPCellAutoLayoutHeightFooterView"];
    footer.delegate = self;
    return footer;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPCellAutoLayoutHeightTableViewCell";
    BPCellAutoLayoutHeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    [cell set1stModel:model indexPath:indexPath];
    return cell;
}

- (void)headerViewAction:(BPCellAutoLayoutHeightHeaderView *)view {
    [self.tableView reloadData];
}

- (void)footerViewAction:(BPCellAutoLayoutHeightFooterView *)view {
    [self.tableView reloadData];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = self.sectionHeaderHeight + 1;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

#pragma mark -懒加载
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithArray:[BPCellAutoLayoutHeightDataSource array]];
        [YYFPSLabel bp_addFPSLableOnWidnow];
    }
    return _array;
}

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
