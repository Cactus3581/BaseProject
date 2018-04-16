//
//  BPMultiLevelCatalogueViewController.m
//  PowerWord7
//
//  Created by xiaruzhen on 2018/4/11.
//  Copyright © 2018年 Kingsoft. All rights reserved.
//

#import "BPMultiLevelCatalogueViewController.h"
#import "KSPhraseCardHeadCell.h"
#import "KSPhraseCardHeaderView.h"
#import "MJExtension.h"
#import "KSPhraseCardHeightHelper.h"
#import "KSMultiLevelCatalogueModel.h"
#import "NSObject+YYModel.h"
#import <YYModel.h>
#import "YYModel.h"

@interface BPMultiLevelCatalogueViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;//显示的数据
@property (nonatomic,strong) NSArray *arraySource;//显示的数据
@end

@implementation BPMultiLevelCatalogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self configTableView];
}

- (void)configTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"KSPhraseCardHeaderView" bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:@"KSPhraseCardHeaderView"];
    [self.tableView registerClass:[KSPhraseCardHeadCell class] forCellReuseIdentifier:@"KSPhraseCardHeadCell"];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.bounces = YES;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return BPValidateArray(self.arraySource).count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    KSMultiLevelCatalogueModel1st *model = BPValidateArrayObjAtIdx(self.arraySource, section);
    return BPValidateArray(model.array_1st).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"KSPhraseCardHeadCell";
    KSPhraseCardHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    KSMultiLevelCatalogueModel1st *model1 = BPValidateArrayObjAtIdx(self.arraySource, indexPath.section);
    KSMultiLevelCatalogueModel2nd *model2 = BPValidateArrayObjAtIdx(model1.array_1st, indexPath.row);
    [cell setModel:model2 indexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    KSPhraseCardHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"KSPhraseCardHeaderView"];
    KSMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
    [header setModel:sectionModel section:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    KSMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,section);
//    self.sectionHeight = sectionModel.headerHeight;
    return sectionModel.headerHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KSMultiLevelCatalogueModel1st *sectionModel = BPValidateArrayObjAtIdx(self.arraySource,indexPath.section);
    KSMultiLevelCatalogueModel2nd *model = BPValidateArrayObjAtIdx(sectionModel.array_1st, indexPath.row);
    return model.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 1000;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

- (void)handleData {
NSDictionary *dic = @{
                      @"array":@[
                                    @{
                                        @"title_1st":@"i go",
                                        @"array_1st":@[
                                                        @{
                                                            @"title_2nd":@"我要去的意思",
                                                            @"array_2nd":@[
                                                                                @{
                                                                                    @"title_3rd":@"i go to zoo",
                                                                                    @"brief_3rd":@"我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，我要去公园，",
                                                                                },
                                                                                @{
                                                                                    @"title_3rd":@"i go to home",
                                                                                    @"brief_3rd":@"我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，我要回家，",
                                                                                    },
                                                                        ],
                                                        },
                                                        @{
                                                            @"title_2nd":@"我不要去的意思",
                                                            @"array_2nd":@[
                                                                                @{
                                                                                    @"title_3rd":@"i not go to zoo",
                                                                                    @"brief_3rd":@"我不要去公园",
                                                                                },
                                                                                @{
                                                                                    @"title_3rd":@"i not go to home",
                                                                                    @"brief_3rd":@"我不要回家",
                                                                        },
                                                                    ],
                                                            },
                                                    ],
                                     },
                                    @{
                                        @"title_1st":@"you go",
                                        @"array_1st":@[
                                                @{
                                                    @"title_2nd":@"你要去的意思",
                                                    @"array_2nd":@[
                                                            @{
                                                                @"title_3rd":@"you go to zoo",
                                                                @"brief_3rd":@"你要去公园",
                                                                },
                                                            @{
                                                                @"title_3rd":@"you go to home",
                                                                @"brief_3rd":@"你要回家",
                                                                },
                                                            ],
                                                    },
                                                ],
                                        },
                                ],
                      };
    KSMultiLevelCatalogueModel *model = [KSMultiLevelCatalogueModel yy_modelWithDictionary:dic];
    
//    [KSPhraseCardHeightHelper handleData:_data successblock:^{
//        self.arraySource = _data.phrases;
//        [self.tableView reloadData];
//    }];
    [KSPhraseCardHeightHelper handleData:model];
    self.arraySource = model.array;
    [self.tableView reloadData];
}

- (NSArray *)arraySource {
    if (!_arraySource) {
        _arraySource = [NSArray array];
    }
    return _arraySource;
}

//旋转事件，需要重新计算cell高度
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //计算旋转之后的宽度并赋值
        CGSize screen = [UIScreen mainScreen].bounds.size;
        //界面处理逻辑
        BPLog(@"kScreenWidth = %.2f",kScreenWidth);
        [self handleData];
        //动画播放完成之后
        if(screen.width > screen.height){
            NSLog(@"横屏");
        }else{
            NSLog(@"竖屏");
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        NSLog(@"动画播放完之后处理");
    }];
}

- (void)dealloc {
}

@end
