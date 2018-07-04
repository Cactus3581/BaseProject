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

@interface BPDownLoadOneFileViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (strong, nonatomic) NSArray *array;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BPAudioModel *model;

@end

@implementation BPDownLoadOneFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self initializeViews];
}

- (void)configLayoutStyle {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)handleData {
    self.array = @[@"开始下载",@"暂停下载",@"继续下载",@"重置"];
    self.model = [BPDownLoadDataSource downLoadOneDataSourceWithIndex:0];
}

- (void)initializeViews {
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.model.smallpic] placeholderImage:nil];
    self.titleLabel.text = self.model.title;
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
