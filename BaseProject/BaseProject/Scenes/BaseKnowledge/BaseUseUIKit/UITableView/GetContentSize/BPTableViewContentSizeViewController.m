//
//  BPTableViewContentSizeViewController.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/5/6.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPTableViewContentSizeViewController.h"

#import "UIView+BPNib.h"
#import "KSSentenceTextTableViewCell.h"
#import "KSSentenceTextHeaderView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "KSSentenceTextFooterView.h"

@interface BPTableViewContentSizeViewController ()<UITableViewDelegate,UITableViewDataSource,KSSentenceTextFooterViewDelegate>

@property (nonatomic, assign) BOOL isExpansion;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BPTableViewContentSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    
    //    关闭这个预估高度的效果 来获取contentSize
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    KSSentenceTextFooterView *footer = [KSSentenceTextFooterView bp_loadInstanceFromNib];
    footer.frame = CGRectMake(0, 0, _tableView.width, KSSentenceTextFooterViewHeight);
    footer.delegate = self;
    _tableView.tableFooterView = footer;
    
    [_tableView registerNib:[KSSentenceTextHeaderView bp_loadNib] forHeaderFooterViewReuseIdentifier:NSStringFromClass([KSSentenceTextHeaderView class])];
    [_tableView registerNib:[KSSentenceTextTableViewCell bp_loadNib] forCellReuseIdentifier:NSStringFromClass([KSSentenceTextTableViewCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)getListHeight {
    //    [self setNeedsLayout];
    //    [self layoutIfNeeded];
    //    [_tableView setNeedsLayout];
    //    [_tableView layoutIfNeeded];
    return _tableView.contentSize.height;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    BPLog(@"table5 = %.2f",[self getListHeight]);
    
    //    CGRect tableFrame = _tableView.frame;
    //    tableFrame.size = _tableView.contentSize;
    //    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
    //        make.left.mas_equalTo(self.bgView.mas_left).offset(15);
    //        make.right.mas_equalTo(self.bgView.mas_right).offset(-15);
    //        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-25);
    //        make.height.mas_equalTo(tableFrame.size.height);
    //    }];
    //
    //    [_tableView.superview layoutIfNeeded];
}

- (void)dealloc {
    [_tableView removeObserver:self forKeyPath:@"contentSize"];
}

@end
