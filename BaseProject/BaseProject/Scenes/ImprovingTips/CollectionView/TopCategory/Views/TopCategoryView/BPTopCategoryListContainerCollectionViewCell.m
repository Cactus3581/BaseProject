//
//  BPTopCategoryListContainerCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "BPTopCategoryListContainerCollectionViewCell.h"
#import "BPTopCategoryListView.h"
#import "BPTopCategoryListTagView.h"

@interface BPTopCategoryListContainerCollectionViewCell()<BPTopCategoryListTagViewDelegate>
@property (weak, nonatomic) IBOutlet BPTopCategoryListView *listView;
@property (weak, nonatomic) IBOutlet BPTopCategoryListTagView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightConstraint;
@property (nonatomic,strong) BPTopCategoryFirstCategoryModel *model;
@end

@implementation BPTopCategoryListContainerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    self.tagView.delegate = self;
}

- (void)setModel:(BPTopCategoryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    _model = model;
    self.tagView.model = model;
    if (!model.sub.count) { //没有tag
//        self.tagViewHeightConstraint.constant = 0.f;
        if (model.thirdCategoryModel) {
            self.listView.array = model.thirdCategoryModel.data;
        }else {
            
        }
    }else {
//        self.tagViewHeightConstraint.constant = model.tagHeight;
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
//            self.tagViewHeightConstraint.constant = height;
        }
    }else {
//        self.tagViewHeightConstraint.constant = 0.f;
    }
}

- (void)didSelectWithModel:(BPTopCategorySecondCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    if (model.thirdCategoryModel) {
        self.listView.array = model.thirdCategoryModel.data;
    }else {

    }
}

@end
