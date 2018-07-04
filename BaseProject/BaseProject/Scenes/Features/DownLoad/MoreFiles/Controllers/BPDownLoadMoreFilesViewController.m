//
//  BPDownLoadMoreFilesViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownLoadMoreFilesViewController.h"
#import "BPDownLoadMoreFilesTableViewCell.h"
#import "BPDownLoadMacro.h"
#import "BPDownLoadDataSource.h"

@interface BPDownLoadMoreFilesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *array;

@end

@implementation BPDownLoadMoreFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self initializeViews];
}

- (void)handleData {
    self.array = [BPDownLoadDataSource downLoadMoreDataSource];
}
#pragma mark - config rightBarButtonItem
- (void)configRightBarButtomItem {
    UIView *view = [[UIView alloc] init];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTintColor:kWhiteColor];
    [rightBarButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton setTitle:@"全部开始" forState:UIControlStateNormal];
    rightBarButton.titleLabel.font  = BPFont(16);
    [rightBarButton addTarget:self action:@selector(allStartDownLoad) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton.frame = CGRectMake(0, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton sizeToFit];
    rightBarButton.frame = CGRectMake(CGRectGetMinX(rightBarButton.frame), 0, CGRectGetWidth(rightBarButton.bounds), bp_naviItem_height);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    UIButton *rightBarButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton1 setTintColor:kWhiteColor];
    [rightBarButton1 setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [rightBarButton1 setTitle:@"全部停止" forState:UIControlStateNormal];
    rightBarButton1.titleLabel.font  = BPFont(16);
    [rightBarButton1 addTarget:self action:@selector(allStopDownLoad) forControlEvents:UIControlEventTouchUpInside];
    rightBarButton1.frame = CGRectMake(CGRectGetMaxX(rightBarButton.frame)+10, 0, bp_naviItem_width, bp_naviItem_height);
    [rightBarButton1 sizeToFit];
    rightBarButton1.frame = CGRectMake(CGRectGetMinX(rightBarButton1.frame), 0, CGRectGetWidth(rightBarButton1.bounds), bp_naviItem_height);
    rightBarButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [view addSubview:rightBarButton];
    [view addSubview:rightBarButton1];
    
    view.frame = CGRectMake(0, 0, rightBarButton.width+10+rightBarButton1.width+5, bp_naviItem_height);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

- (void)allStartDownLoad {
    
}

- (void)allStopDownLoad {
    
}

- (void)initializeViews {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(BPDownLoadMoreFilesTableViewCell.class) bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPDownLoadMoreFilesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setItem:self.array[indexPath.row] indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

