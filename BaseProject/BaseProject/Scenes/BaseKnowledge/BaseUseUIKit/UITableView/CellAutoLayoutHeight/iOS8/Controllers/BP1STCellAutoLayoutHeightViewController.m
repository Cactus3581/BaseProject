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

// 如果使用预估 可以减少heightForRowAtIndexPath的调用次数。10个数据，关闭预估54，开启预估14，cell都是7次，开启预估跟不开启调用次数都一样

static CGFloat cellHeight = 100;

@interface BP1STCellAutoLayoutHeightViewController () <UITableViewDelegate,UITableViewDataSource,BPCellAutoLayoutHeightHeaderViewDelegate,BPCellAutoLayoutHeightFooterViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) NSMutableDictionary *heightAtIndexPath;//实现缓存的目的是：reloadtdada之后，发现页面自己滑动了
@property (nonatomic,assign) NSInteger heightTime;
@property (nonatomic,assign) NSInteger estimatedHeightTime;
@property (nonatomic,assign) NSInteger cellforTime;
@end

@implementation BP1STCellAutoLayoutHeightViewController

/*
 计算tableview的contentSize
 
 1. numberOfRowsInSection //一次性就调用完
 2. estimatedHeightForRowAtIndexPath//在加载的时候一次性就调用完了，后面不会再调，除非reloaddata
 3. heightForRowAtIndexPath滑动的时候，不断调用）

 创建显示的UIView（滑动的时候，不断调用）
 cellForRowAtIndexPath
 willDisplayCell
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rightBarButtonTitle = @"reloaddata";
    [self configureTable];
}

- (void)rightBarButtonItemClickAction:(id)sender {
    [self.tableView reloadData];
}

#pragma mark - iOS 8自动计算（方法一代码）
- (void)configureTable {
    //PS：iOS8 系统中 rowHeight 的默认值已经设置成了 UITableViewAutomaticDimension，所以第二行代码可以省略。
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    /*
         if (kiOS11) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
         }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
         }
     */
}

#pragma mark - TableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

#pragma mark -  iOS 8自动计算（方法二代码）
#pragma mark - 返回高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPLog(@"heightTime = %ld",++self.heightTime);//14 //28 //54
    return UITableViewAutomaticDimension;
}

//在加载的时候一次性就调用完了，后面不会再调，除非reloaddata
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPLog(@"estimatedHeightTime = %ld",++self.estimatedHeightTime); //40 40
    NSNumber *height = [self.heightAtIndexPath objectForKey:indexPath];
    if(height) {
        return height.floatValue;
    }
    else {
        return cellHeight;
    }
}

#pragma mark -  生成UIView子类实例
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"BPCellAutoLayoutHeightTableViewCell";
    BPCellAutoLayoutHeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BPCellAutoLayoutHeightModel *model = self.array[indexPath.row];
    [cell set1stModel:model indexPath:indexPath];
    BPLog(@"cellforTime = %ld",++self.cellforTime);//7 //7 //7

    return cell;
}

#pragma mark - 高度缓存：1. 为了防止重新计算，提高效率性能 2.刷新再点击状态栏，不能精确滚动到顶部
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSNumber *height = @(cell.frame.size.height);
    [self.heightAtIndexPath setObject:height forKey:indexPath];
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

//数据源
- (NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithArray:[BPCellAutoLayoutHeightDataSource array]];
        [YYFPSLabel bp_addFPSLableOnWidnow];
    }
    return _array;
}

//缓存高度数据
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
