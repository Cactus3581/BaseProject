//
//  KSSentenceTexTableView.m
//  BaseProject
//
//  Created by xiaruzhen on 2019/4/30.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "KSSentenceTexTableView.h"
#import "UIView+BPNib.h"
#import "KSSentenceTextTableViewCell.h"
#import "KSSentenceTextHeaderView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "KSSentenceTextFooterView.h"

/*
 获取高度：
 1. [self setNeedsLayout]; [self layoutIfNeeded];
 2. 观察者
 
 */
@interface KSSentenceTexTableView ()<UITableViewDelegate,UITableViewDataSource,KSSentenceTextFooterViewDelegate>

@property (nonatomic, assign) BOOL isExpansion;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KSSentenceTexTableView

- (void)awakeFromNib {
    [super awakeFromNib];
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

- (void)setModel:(KSDailySentenceModel *)model {
    _model = model;
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isExpansion) {
        return _model.array.count;
    }
    if (_model.array.count) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    KSDailySentenceContentModel *contentModel = _model.array[section];
    if (_isExpansion) {
        return contentModel.customArray.count;
    }
    if (contentModel.customArray.count) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSSentenceTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([KSSentenceTextTableViewCell class]) forIndexPath:indexPath];
    KSDailySentenceContentModel *contentModel = _model.array[indexPath.section];
    KSDailySentenceContentItemDetailModel *detailModel = contentModel.customArray[indexPath.row];
    cell.model = detailModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([KSSentenceTextTableViewCell class]) cacheByIndexPath:indexPath configuration:^(KSSentenceTextTableViewCell *cell) {
        KSDailySentenceContentModel *contentModel = _model.array[indexPath.section];
        KSDailySentenceContentItemDetailModel *detailModel = contentModel.customArray[indexPath.row];
        cell.model = detailModel;
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KSSentenceTextHeaderView *header = [KSSentenceTextHeaderView bp_loadInstanceFromNib];
    KSDailySentenceContentModel *contentModel = _model.array[section];
    header.model = contentModel;
    if (contentModel && BPValidateString(contentModel.title).length) {
        return header;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    KSDailySentenceContentModel *contentModel = _model.array[section];
    if (contentModel && BPValidateString(contentModel.title).length) {
        return KSSentenceTextHeaderViewHeight;
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)sentenceTextFooterView:(KSSentenceTextFooterView *)footer isExpansion:(BOOL)isExpansion {
    
    _isExpansion = isExpansion;
    
    [_tableView reloadData];
    
    //    NSRange range = NSMakeRange(0, (_tableView.numberOfSections - 1));
    //    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    //    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BPLog(@"table3 = %.2f",[self getListHeight]);

        if (_delegate && [_delegate respondsToSelector:@selector(sentenceTextFooterView:height:)]) {
            [_delegate sentenceTextFooterView:self height:[self getListHeight]];
        }
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    BPLog(@"table2 = %.2f",[self getListHeight]);

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
