//
//  BPBDNestListViewController.m
//  BaseProject
//
//  Created by Ryan on 2019/4/29.
//  Copyright © 2019 cactus. All rights reserved.
//

#import "BPBDNestListViewController.h"
#import "KSSentenceTexTableView.h"
#import "KSDailySentenceModel.h"
#import "MJExtension.h"

#import "UIView+BPNib.h"
#import "KSSentenceTextTableViewCell.h"
#import "KSSentenceTextHeaderView.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "KSSentenceTextFooterView.h"

@interface BPBDNestListViewController ()

@property (weak, nonatomic) KSSentenceTexTableView *sentenceTexTableView;
@property (nonatomic, strong) KSDailySentenceModel *model;

@end


@implementation BPBDNestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    KSDailySentenceModel *model = [[KSDailySentenceModel alloc] init];
    NSMutableArray *muArray = @[].mutableCopy;
    
    for (int i = 0; i < 3; i++) {
        KSDailySentenceContentModel *contentModel = [[KSDailySentenceContentModel alloc] init];
        contentModel.title = @(i+1).stringValue;
        NSMutableArray *muItemArray = @[].mutableCopy;
        for (int i = 0; i < 3; i++) {
            KSDailySentenceContentItemModel *contentItemModel = [[KSDailySentenceContentItemModel alloc] init];
            NSMutableArray *mudetailArray = @[].mutableCopy;
            for (int i = 0; i < 3; i++) {
                KSDailySentenceContentItemDetailModel *detailModel = [[KSDailySentenceContentItemDetailModel alloc] init];
                detailModel.content = @"十年驱驰海色寒，孤臣于此望宸銮。十年驱驰海色寒，孤臣于此望宸銮。十年驱驰海色寒，孤臣于此望宸銮。十年驱驰海色寒，孤臣于此望宸銮";
                [mudetailArray addObject:detailModel];
            }
            contentItemModel.item = mudetailArray.copy;
            [muItemArray addObject:contentItemModel];
        }
        contentModel.contentList = muItemArray.copy;
        [muArray addObject:contentModel];
    }
    model.array = muArray.copy;
    
    
    NSString *json = [model mj_JSONString];
    BPLog(@"%@",json);
    
    [model.array enumerateObjectsUsingBlock:^(KSDailySentenceContentModel *contentModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *muItemArray = @[].mutableCopy;
        
        NSInteger number = contentModel.contentList.count;
        
        [contentModel.contentList enumerateObjectsUsingBlock:^(KSDailySentenceContentItemModel *contentItemModel, NSUInteger index, BOOL * _Nonnull stop) {
            
            
            [contentItemModel.item enumerateObjectsUsingBlock:^(KSDailySentenceContentItemDetailModel *detailModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == 0) {
                    // 不隐藏索引
                    // detailModel.customIndex = @(index+1).stringValue;
                } else {
                    // 隐藏索引
                    detailModel.hiddenIndexLabel = YES;
                }
                
                if (number > 1) { // 如果数量大于一个，显示自定义的索引
                    detailModel.customIndex = @(index+1).stringValue;
                } else {// 如果数量只有一个，不显示自定义的索引，并且将约束缩进
                    detailModel.customIndex = nil;
                    // detailModel.hiddenIndexLabel = YES;
                }
                
                [muItemArray addObject:detailModel];
            }];
            contentItemModel.item = nil;
            
        }];
        contentModel.customArray = muItemArray.copy;
        contentModel.contentList = nil;
    }];
    
    NSString *json1 = [model mj_JSONString];
    BPLog(@"%@",json1);
    
    _model = model;
    
    KSSentenceTexTableView *sentenceTexTableView = [KSSentenceTexTableView bp_loadInstanceFromNib];
    sentenceTexTableView.layer.cornerRadius = 5;
    sentenceTexTableView.layer.masksToBounds = YES;
    sentenceTexTableView.backgroundColor = kThemeColor;
    [self.view addSubview:sentenceTexTableView];
    [sentenceTexTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    sentenceTexTableView.model = model;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BPLog(@"table = %.2f",[sentenceTexTableView getListHeight]);
    });
    
    return;
}

@end
