//
//  BPCategoryDetailViewController.m
//  BaseProject
//
//  Created by Ryan on 2018/7/8.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPCategoryDetailViewController.h"
#import "BPTopCategoryListView.h"
#import "BPTopCategoryListTagView.h"

@interface BPCategoryDetailViewController ()<BPTopCategoryListTagViewDelegate>
@property (weak, nonatomic) IBOutlet BPTopCategoryListView *listView;
@property (weak, nonatomic) IBOutlet BPTopCategoryListTagView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightConstraint;
@end

@implementation BPCategoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagView.delegate = self;
    [self handleModel];
}

- (void)handleModel {
    self.tagView.model = self.model;
    if (!self.model.sub.count) { //没有tag
        self.tagViewHeightConstraint.constant = 0.f;
        if (self.model.thirdCategoryModel) {
            self.listView.array = self.model.thirdCategoryModel.data;
        }else {
            
        }
    }else {
        self.tagViewHeightConstraint.constant = self.model.tagHeight;
        [self handleListData];
    }
}

- (void)handleListData {
    __block NSInteger showNumber = 0;
    [self.model.sub enumerateObjectsUsingBlock:^(BPTopCategorySecondCategoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isSelected) {
            showNumber = idx;
        }
    }];
    BPTopCategorySecondCategoryModel *secondCategoryModel = self.model.sub[showNumber];
    if (secondCategoryModel.thirdCategoryModel) {
        self.listView.array = secondCategoryModel.thirdCategoryModel.data;
    }else {
        
    }
}

#pragma tagView delegate
- (void)getHeight:(CGFloat)height {
    if (self.model.sub.count) {
        if (self.model.tagHeight != height) {
            self.model.tagHeight = height;
            self.tagViewHeightConstraint.constant = height;
        }
    }else {
        self.tagViewHeightConstraint.constant = 0.f;
    }
}

- (void)didSelectWithModel:(BPTopCategorySecondCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    if (model.thirdCategoryModel) {
        self.listView.array = model.thirdCategoryModel.data;
    }else {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
