//
//  BPNestBottomCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/6/11.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPNestBottomCollectionViewCell.h"
#import "BPNestLinkageBaseTableView.h"

@interface BPNestBottomCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) BPNestLinkageBaseTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL isScroll;

@end

static NSString *ide = @"UITableViewCell";

@implementation BPNestBottomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus1) name:@"scrollViewDidScroll1" object:nil];

        _isScroll = NO;
        self.tableView.backgroundColor = kPurpleColor;

    }
    return self;
}

- (void)changeScrollStatus1 {
    self.isScroll = YES;
}

// 返回第section组中有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ide forIndexPath:indexPath];
    cell.contentView.backgroundColor = kWhiteColor;
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld区%ld行",indexPath.section,indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    BPLog(@"contentOffset = %.2f",scrollView.contentOffset.y);
    if (self.isScroll) {
        if (scrollView.contentOffset.y<=0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll2" object:nil];//到顶通知父视图改变状态
            self.isScroll = NO;
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollViewDidScroll3" object:nil];//到顶通知父视图改变状态
        }
    }else {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
}

#pragma mark - TableView 属性相关
- (UITableView *)tableView {
    if (!_tableView) {
        BPNestLinkageBaseTableView *tableView= [[BPNestLinkageBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView = tableView;
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = [[UIView alloc]init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.rowHeight = 100;
        _tableView.sectionHeaderHeight = 0;
        _tableView.sectionFooterHeight = 0;
        if (kiOS11) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
//            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.backgroundColor = kPurpleColor;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ide];
        _tableView.showsVerticalScrollIndicator = NO;
        [self.contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
