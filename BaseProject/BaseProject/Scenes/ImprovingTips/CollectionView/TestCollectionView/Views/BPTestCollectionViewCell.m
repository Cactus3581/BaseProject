//
//  BPTestCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/5/17.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTestCollectionViewCell.h"
#import "BPTestTableViewCell.h"
#import "KSHeritageDictionaryListTagView.h"
#import "BPTagLabelView.h"

static NSString *identifier = @"BPTestTableViewCell";

@interface BPTestCollectionViewCell()<UITableViewDelegate,UITableViewDataSource,KSHeritageDictionaryListTagViewDelegate>
//@property (weak, nonatomic) KSHeritageDictionaryListTagView *tagView;
@property (weak, nonatomic) BPTagLabelView *tagLabelView;

@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic,strong) KSWordBookAuthorityDictionaryFirstCategoryModel *model;
@end

@implementation BPTestCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = kWhiteColor;
        [self configTableView];
    }
    return self;
}
- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
//    self.tagView.model = model;

    KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel = self.model.sub[0];
    self.array = secondCategoryModel.thirdCategoryModel.data;
    [self.tableView reloadData];
}

#pragma tagView delegate
- (void)getHeight:(CGFloat)height {
    if (self.model.sub.count) {
        if (self.model.tagHeight != height) {
            self.model.tagHeight = height;
//            [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(height);
//            }];
        }
    }else {
//        [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(0);
//        }];

    }
}
- (void)configTableView {
    self.backgroundColor = kWhiteColor;
    
//    KSHeritageDictionaryListTagView *tagView = [[KSHeritageDictionaryListTagView alloc] init];
//    [self addSubview:tagView];
//    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.top.equalTo(self);
//        make.height.mas_equalTo(0);
//    }];
//    self.tagView = tagView;
//    self.tagView.delegate = self;

    
    BPTagLabelView *tagLabelView = [[BPTagLabelView alloc] init];

    [self addSubview:tagLabelView];
    tagLabelView.titlesArray = @[@"我爱你",@"可是你并不知道",@"你是不是傻逼",@"嗯",@"别说话",@"滚犊子",@"我去你妈的，再见～"];
    self.tagLabelView = tagLabelView;
    [tagLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self).offset(100);
        make.height.mas_equalTo(tagLabelView.height);
    }];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:tableView];
    _tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.top.equalTo(self.tagLabelView.mas_bottom);
    }];
    
    [_tableView registerClass:[BPTestTableViewCell class] forCellReuseIdentifier:identifier];
    _tableView.backgroundColor = kWhiteColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 165.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return BPValidateArray(self.array).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BPTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    KSWordBookAuthorityDictionaryThirdCategoryModel *thirdCategoryModel = self.array[indexPath.row];
    [cell setModel:thirdCategoryModel indexPath:indexPath];
    return cell;
}
@end
