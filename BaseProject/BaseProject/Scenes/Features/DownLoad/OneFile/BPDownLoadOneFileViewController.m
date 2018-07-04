//
//  BPDownLoadOneFileViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/7/4.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPDownLoadOneFileViewController.h"
#import "BPDownLoadMacro.h"
#import "BPAudioModel.h"
#import "UIImageView+WebCache.h"
#import "BPDownLoadDataSource.h"
#import "BPDownLoadGeneralView.h"

@interface BPDownLoadOneFileViewController ()<UITableViewDelegate,UITableViewDataSource,BPDownLoadGeneralViewDelegate>
@property (strong, nonatomic) NSArray *array;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BPAudioModel *model;
@property (weak, nonatomic) IBOutlet UIView *downLoadBackView;
@property (weak, nonatomic) BPDownLoadGeneralView *downLoadView;
@end

@implementation BPDownLoadOneFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configLayoutStyle];
    [self setup];
    [self handleData];
    [self initializeViews];
}

- (void)downLoad:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)item {
    
}

- (void)setup {
    BPDownLoadGeneralView *downLoadView = [[[NSBundle mainBundle] loadNibNamed:@"BPDownLoadGeneralView" owner:self options:nil] lastObject];
    _downLoadView = downLoadView;
    _downLoadView.delegate = self;
    [self.downLoadBackView addSubview:_downLoadView];
    [_downLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.downLoadBackView);
    }];
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)handleData {
    self.array = @[@"开始下载",@"暂停下载",@"继续下载",@"重置"];
    self.model = [BPDownLoadDataSource downLoadOneDataSourceWithIndex:0];
}

- (void)initializeViews {
    [self.downLoadView setItem:self.model];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.array[indexPath.row];
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
