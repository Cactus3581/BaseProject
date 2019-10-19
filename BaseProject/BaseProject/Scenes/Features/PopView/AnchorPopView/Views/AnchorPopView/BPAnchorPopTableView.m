//
//  BPAnchorPopTableView.m
//  BaseProject
//
//  Created by Ryan on 2018/1/6.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPAnchorPopTableView.h"
#import "Masonry.h"

@interface BPAnchorPopTableView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation BPAnchorPopTableView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self addSubview:self.tableView];
    self.backgroundColor = kClearColor;
    self.tableView.backgroundColor = kClearColor;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = kThemeColor;
        backgroundView.alpha = 0.8;
        cell.backgroundView = backgroundView;
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = kWhiteColor;
        [cell.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(cell.contentView);
            make.height.mas_equalTo(kOnePixel);
        }];
    }
    cell.textLabel.text = @"i am cell";
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

@end
