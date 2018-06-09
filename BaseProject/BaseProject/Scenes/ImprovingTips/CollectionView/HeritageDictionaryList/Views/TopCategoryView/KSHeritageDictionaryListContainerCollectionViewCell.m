//
//  KSHeritageDictionaryListContainerCollectionViewCell.m
//  BaseProject
//
//  Created by xiaruzhen on 2018/4/27.
//  Copyright © 2018年 cactus. All rights reserved.
//

#import "KSHeritageDictionaryListContainerCollectionViewCell.h"
#import "KSHeritageDictionaryListView.h"
#import "KSHeritageDictionaryListTagView.h"

@interface KSHeritageDictionaryListContainerCollectionViewCell()<KSHeritageDictionaryListTagViewDelegate>
@property (weak, nonatomic) IBOutlet KSHeritageDictionaryListView *listView;
@property (weak, nonatomic) IBOutlet KSHeritageDictionaryListTagView *tagView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagViewHeightConstraint;
@property (nonatomic,strong) KSWordBookAuthorityDictionaryFirstCategoryModel *model;
@end

@implementation KSHeritageDictionaryListContainerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    self.tagView.delegate = self;
}

- (void)setModel:(KSWordBookAuthorityDictionaryFirstCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
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
    [self.model.sub enumerateObjectsUsingBlock:^(KSWordBookAuthorityDictionarySecondCategoryModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (model.isSelected) {
            showNumber = idx;
        }
    }];
    KSWordBookAuthorityDictionarySecondCategoryModel *secondCategoryModel = self.model.sub[showNumber];
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

- (void)didSelectWithModel:(KSWordBookAuthorityDictionarySecondCategoryModel *)model indexPath:(NSIndexPath *)indexPath {
    if (model.thirdCategoryModel) {
        self.listView.array = model.thirdCategoryModel.data;
    }else {

    }
}

@end
