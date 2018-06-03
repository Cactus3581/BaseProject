//
//  BPTestViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2017/12/5.
//  Copyright © 2017年 cactus. All rights reserved.
//

#import "BPTestViewController.h"

@interface BPTestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *bottomView;

@end

static NSString *cell_identifier = @"cell";


static CGFloat cellH = 50;

@implementation BPTestViewController

#pragma mark - vc system methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Group";
    self.view.backgroundColor = kGreenColor;
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"backImage"] forBarMetrics:UIBarMetricsDefault];

    [self configSubViews];
}

#pragma mark - config tableView
- (void)configSubViews {
    [self.view addSubview:self.bottomView];
    
    if (kiOS11) {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.height.mas_equalTo(49);
        }];
    }else {
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.view);
            make.height.mas_equalTo(49);
        }];
    }

    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
}

#pragma mark - tabeview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 19;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_identifier];
    }
    cell.textLabel.text = @"我是cell";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kYellowColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellH;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
    //    return section_footerH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - lazy load methods
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = (id)self;
        _tableView.dataSource = (id)self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        /*
         UILabel *headerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerH)];
         headerView.backgroundColor = kGreenColor;
         headerView.text = @"我是tableHeader";
         UILabel *footerView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, footerH)];
         footerView.backgroundColor = kGreenColor;
         footerView.text = @"我是tablefooter";
         _tableView.tableHeaderView = headerView;
         _tableView.tableFooterView = footerView;
         */
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.backgroundColor = kPurpleColor;
        //[self register_tableView_nib];
    }
    return _tableView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(pop)]) {
        [_delegate pop];
    }
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = kLightGrayColor;
    }
    return _bottomView;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - dealloc
- (void)dealloc {
    BPLog(@"retain  count = %ld\n",BPRetainCount(self));
    BPLog(@"retain  count = %ld\n",BPRetainCount(self.view));
    BPLog(@"retain  count = %ld\n",BPRetainCount(_tableView));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
