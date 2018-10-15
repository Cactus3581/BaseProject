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
#import "BPDownloader.h"
#import "BPDownLoadItem.h"
#import "BPDownLoad.h"

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatusNotification:) name:kDownloadStatusNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeProgressNotification:) name:kDownloadDownLoadProgressNotification object:nil];

}

- (void)changeStatusNotification:(NSNotification *)notification {
    BPDownLoadItem *item = [notification valueForKey:@"object"];
    if (![item.downLoadUrl isEqualToString:self.model.mediaUrl]) {
        return;
    }
    [self.downLoadView setItem:item];
}

- (void)changeProgressNotification:(NSNotification *)notification {
    BPDownLoadItem *item = [notification valueForKey:@"object"];
    if (![item.downLoadUrl isEqualToString:self.model.mediaUrl]) {
        return;
    }
    [self.downLoadView setItem:item];
}

- (void)downLoad:(BPDownLoadGeneralView *)downLoadGeneralView item:(BPAudioModel *)model {
    BPDownLoadItem *item = [[BPDownLoadItem alloc] init];
    item.identify = model.identify;
    item.downLoadUrl = model.mediaUrl;
    item.title = model.title;
    item.filepath = @"";
    [[BPDownloader shareDownloader] downloadItem:item];
}

- (void)setup {
    BPDownLoadGeneralView *downLoadView = [BPDownLoadGeneralView bp_loadInstanceFromNib];
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
    [self.downLoadView setModel:self.model];
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
